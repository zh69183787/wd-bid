package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.RoleDao;
import com.wonders.stpt.bid.dao.UserDao;
import com.wonders.stpt.bid.dao.UserRoleDao;
import com.wonders.stpt.bid.domain.Role;
import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.domain.UserRole;
import com.wonders.stpt.bid.domain.UserSecurityInfo;
import com.wonders.stpt.bid.service.IUserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by Administrator on 2014/9/29.
 */

public class UserDetailServiceImpl extends JdbcUserDetailsManager implements IUserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private UserRoleDao userRoleDao;

    protected UserDetails createUserDetails(String username, UserDetails userFromUserQuery,
                                            List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();

        if (!isUsernameBasedPrimaryKey()) {
            returnUsername = username;
        }

        return new UserSecurityInfo(returnUsername, userFromUserQuery.getPassword(), userFromUserQuery.isEnabled(),
                true, true, true, combinedAuthorities, ((UserSecurityInfo) userFromUserQuery).getRealName(), ((UserSecurityInfo) userFromUserQuery).getUserId());
    }

    protected List<UserDetails> loadUsersByUsername(String loginName) {

        List<UserDetails> userDetailsList = null;
        try {
            userDetailsList = new ArrayList<UserDetails>();

            User example = new User();
            example.setLoginName(loginName);
            List<User> users = getUsers(example, 1, Integer.MAX_VALUE);
            if (users == null)
                return userDetailsList;

            for (User user : users) {
                UserSecurityInfo userDetails = new UserSecurityInfo(user.getLoginName(), user.getPassword(), true, true, true, true, AuthorityUtils.NO_AUTHORITIES, user.getUserName(), user.getUserId());
                userDetailsList.add(userDetails);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userDetailsList;
    }

    protected List<GrantedAuthority> loadUserAuthorities(String loginName) {
        List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
        User example = new User();
        example.setLoginName(loginName);
        List<Role> roleList = roleDao.selectByLoginName(loginName);
        if (roleList == null || roleList.size() == 0)
            return grantedAuthorities;


        for (Role role : roleList) {
            grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleName()));
        }

        return grantedAuthorities;
    }

    public List<Role> getUserAuthorities(String loginName) throws Exception
    {
        return roleDao.selectByLoginName(loginName);
    }


    @Override
    public List<User> getUsers(User user, int pageIndex, int pageSize) throws Exception {
        return userDao.select(user,null, pageIndex, pageSize);
    }

    @Override
    public List<User> getUsers(String roleName, int pageIndex, int pageSize) throws Exception {
        return userDao.select(new  User(),roleName, pageIndex, pageSize);
    }

    @Override
    public User getUser(String loginName) throws Exception {
        User example = new User();
        example.setLoginName(loginName);
        List<User> users = getUsers(example, 1, Integer.MAX_VALUE);

        if (users != null && users.size() > 1)
            throw new Exception("存在多个相同帐号");

        if (users.size() == 1)
            return users.get(0);

        return null;

    }

    @Override
    public void save(User user) throws Exception {
        if (StringUtils.isBlank(user.getUserId())) {
            if (!userExists(user.getLoginName())) {
                userDao.insert(user);
            }else{
                throw new Exception("帐号已被使用,请换个帐号!");
            }
        } else {
            userDao.update(user);
        }
        if (getEnableAuthorities()) {

            List<Role> roleList = user.getRoles();
            userRoleDao.delete(user.getLoginName());
            if(roleList!=null &&roleList.size() > 0){

                for (Role role : roleList) {
                    UserRole userRole = new UserRole();
                    userRole.setLoginName(user.getLoginName());
                    userRole.setRoleName(role.getRoleName());
                    userRoleDao.insert(userRole);
                }
            }
        }
    }

    @Override
    public List<Role> getRoles() throws Exception{
        Role role = new Role();
        role.setRemoved("0");
        return roleDao.select(role,1,Integer.MAX_VALUE);
    }

    public boolean userExist(String loginName) throws Exception {
        User example = new User();
        example.setLoginName(loginName);
        List<User> users = userDao.select(example,null, 1, Integer.MAX_VALUE);
        if (users.size() > 1)
            throw new Exception("存在多个相同帐号");

        return users.size() == 1;
    }

    @Override
    public User getCurrentUser() {
        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            return null;
        }
        Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (object instanceof UserSecurityInfo) {
            UserSecurityInfo userDetails = (UserSecurityInfo) object;
            User user = new User();
            user.setUserId(userDetails.getUserId());
            user.setUserName(userDetails.getRealName());
            user.setLoginName(userDetails.getUsername());
            Collection<GrantedAuthority> grantedAuthorities = userDetails.getAuthorities();
            List<Role> roleList = new ArrayList<Role>();

            for (GrantedAuthority grantedAuthority : grantedAuthorities) {
                Role role = new Role();
                role.setRoleName(grantedAuthority.getAuthority());
                roleList.add(role);
            }
            user.setRoles(roleList);
            return user;
        } else {
            return null;
        }
    }

    private UserDetails toUserDetails(User user) {
        List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
        if (user.getRoles() != null) {
            List<Role> roleList = user.getRoles();
            for (Role role : roleList) {
                grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleName()));
            }
        }


        UserSecurityInfo userDetails = new UserSecurityInfo(user.getLoginName(), user.getPassword(), true, true, true, true, grantedAuthorities, user.getUserName(), user.getUserId());
        return userDetails;
    }
}
