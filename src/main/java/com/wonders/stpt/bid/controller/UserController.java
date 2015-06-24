package com.wonders.stpt.bid.controller;

import com.wonders.stpt.bid.domain.Role;
import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.service.IUserService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2014/10/11.
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    @Autowired
    private IUserService userService;

    @RequestMapping(method = RequestMethod.GET)
    public String input(Model model) throws Exception {

        model.addAttribute("roles", userService.getRoles());
        return "user/user";
    }

    @RequestMapping(method = RequestMethod.GET, value = "users")
    public String users(User user, Model model,
                        @RequestParam(required = false, defaultValue = "1") int pageIndex,
                        @RequestParam(required = false, defaultValue = "15") int pageSize) throws Exception {
        if(!hasAdminRole()){
           throw new AccessDeniedException("对不起，您没有访问权限!");
        }
        List<User> users = userService.getUsers(user, pageIndex, pageSize);
        model.addAttribute("users", users);
        model.addAttribute("pageInfo", ((PageList) users).getPageInfo());
        return "user/users";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{loginName}")
    public String user(@PathVariable String loginName, Model model) throws Exception {
        User user = userService.getUser(loginName);
        if(!hasAdminRole() && !user.getUserId().equals(getUserInfo().getUserId())){
            throw new AccessDeniedException("对不起，您没有访问权限!");
        }
        model.addAttribute("userInfo", user);
        model.addAttribute("roles", userService.getRoles());
        model.addAttribute("hasRoles",userService.getUserAuthorities(loginName));
        return "user/user";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String add(User user, Model model) throws Exception {
        if(!hasAdminRole()){
            throw new AccessDeniedException("对不起，您没有访问权限!");
        }
        List<Role> roleList = user.getRoles();
        List<Role> nList = new ArrayList<Role>();
        for (Role role : roleList) {
            if (StringUtils.isNotBlank(role.getRoleName())) {
                nList.add(role);
            }
        }
        user.setRoles(nList);
        try {
            userService.save(user);
        } catch (Exception e) {
           if("帐号已被使用,请换个帐号!".equals(e.getMessage()))
               return  "redirect:/user?errorCode=1";
        }
        return "redirect:/user/users";
    }

    @RequestMapping(method = RequestMethod.PUT, value = "{loginName}")
    public String update(@PathVariable String loginName, User user, Model model) throws Exception {
        if(!hasAdminRole()&&!user.getUserId().equals(getUserInfo().getUserId())){
            throw new AccessDeniedException("对不起，您没有访问权限!");
        }
        List<Role> roleList = user.getRoles();
        List<Role> nList = new ArrayList<Role>();
        for (Role role : roleList) {
            if (StringUtils.isNotBlank(role.getRoleName())) {
                nList.add(role);
            }
        }
        user.setRoles(nList);

        userService.save(user);
        return "redirect:/user/users";
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "{loginName}")
    public String delete(@PathVariable String loginName, Model model) throws Exception {
        userService.deleteUser(loginName);
        return "redirect:/user/users";
    }

    @RequestMapping(method = RequestMethod.GET, value = "{loginName}/password")
    public String password(@PathVariable String loginName, Model model) throws Exception {
        User user = userService.getUser(loginName);
        model.addAttribute("userInfo",user);
        return "/user/change_password";
    }

    @RequestMapping(method = RequestMethod.PUT, value = "{loginName}/password")
    public String changePassword(@PathVariable String loginName,String oldPassword,String newPassword, Model model) throws Exception {
        try {
            User user = userService.getUser(loginName);
            if(!hasAdminRole()&&!user.getUserId().equals(getUserInfo().getUserId())){
                throw new AccessDeniedException("对不起，您没有访问权限!");
            }
            userService.changePassword(oldPassword,newPassword);
            model.addAttribute("loginName",loginName);
        } catch (BadCredentialsException e) {
            model.addAttribute("msg","旧密码错误,请重新输入!");
            return "/user/change_password";
        }

        return "redirect:/user/{loginName}/password";
    }
}
