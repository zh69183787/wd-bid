package com.wonders.stpt.bid.dao;

import com.wonders.stpt.bid.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2014/9/29.
 */
public interface UserDao extends GenericDAO<User> {
    public List<User> select(@Param("user")User user,@Param("roleName")String roleName,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize);

}
