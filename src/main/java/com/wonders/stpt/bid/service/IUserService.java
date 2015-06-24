package com.wonders.stpt.bid.service;

import com.wonders.stpt.bid.domain.Role;
import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.domain.UserSecurityInfo;

import java.util.List;

/**
 * Created by Administrator on 2014/9/29.
 */
public interface IUserService {

    List<User> getUsers(User user,int pageIndex,int pageSize) throws Exception;

    List<User> getUsers(String roleName,int pageIndex,int pageSize) throws Exception;

    User getUser(String loginName) throws Exception;

    void save(User user) throws Exception;

    User getCurrentUser() ;

    boolean userExists(String loginName) throws Exception;

    void changePassword(String oldPassword,String newPassword);

    void deleteUser(String loginName);

    List<Role> getRoles() throws Exception;

    List<Role> getUserAuthorities(String loginName) throws Exception;
}
