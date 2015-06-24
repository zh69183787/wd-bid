package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.UserDao;
import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.domain.UserSecurityInfo;
import com.wonders.stpt.bid.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2014/9/29.
 */

public class UserServiceImpl {
//    @Autowired
//    private UserDao userDao;
//    @Override
//    public User getUser(String loginName) {
//        return userDao.selectByLoginName(loginName);
//    }
//
//    @Override
//    public UserSecurityInfo getCurrentUser() {
//        if (SecurityContextHolder.getContext().getAuthentication()==null) {
//            return null;
//        }
//        Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        if(object instanceof UserSecurityInfo){
//            UserSecurityInfo userDetails = (UserSecurityInfo) object;
//            return userDetails;
//        }else{
//            return null;
//        }
//    }
}
