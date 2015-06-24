package com.wonders.stpt.bid.controller;

import com.wonders.stpt.bid.domain.Role;
import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.service.IRouteService;
import com.wonders.stpt.bid.service.IUserService;
import com.wonders.stpt.bid.utils.common.CustomTimestampEditor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2014/7/9.
 */
public class BaseController {


    @Autowired
    private IUserService userService;
    @Autowired
    private IRouteService routeService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(true);
        SimpleDateFormat timestampFormat = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
        timestampFormat.setLenient(true);

        binder.registerCustomEditor(Timestamp.class, new CustomTimestampEditor(timestampFormat, true));
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    public boolean hasObserverRole(){

        return hasRole("ROLE_OBSERVER");
    }

    public boolean hasAdminRole(){

        return hasRole("ROLE_ADMIN");
    }

    public boolean hasEditorRole(){

        return hasRole("ROLE_EDITOR");
    }


    public boolean hasRole(String roleName){
        User user =  userService.getCurrentUser();
        List<Role> roleList = user.getRoles();
        for (Role role : roleList) {
            if(role.getRoleName().equals(roleName))
                return true;
        }

        return false;
    }

    public void access(String routeId) throws Exception{
//        Route route = routeService.getRoute(routeId);
//        if(route != null && !hasAdminRole()&&!getUserInfo().getUserId().equals(route.getCreator())){
//                throw new AccessDeniedException("对不起，您没有访问权限!");
//        }
    }

    @ModelAttribute
    public void addUserInfo( Model model) {
        model.addAttribute("currentUser",getUserInfo() );
    }

    protected User getUserInfo(){
        return userService.getCurrentUser();
    }
}
