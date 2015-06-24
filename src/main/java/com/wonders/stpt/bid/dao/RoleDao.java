package com.wonders.stpt.bid.dao;

import com.wonders.stpt.bid.domain.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2014/10/11.
 */
public interface RoleDao extends GenericDAO<Role> {
    public List<Role> select(@Param("role")Role user,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize);

    List<Role> selectByLoginName(String loginName);
}
