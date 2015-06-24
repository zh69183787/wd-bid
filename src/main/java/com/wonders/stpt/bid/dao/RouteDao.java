package com.wonders.stpt.bid.dao;

import com.wonders.stpt.bid.domain.Route;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2014/7/8.
 */
public interface RouteDao extends GenericDAO<Route> {
	/**
	 * 根据条件分页查询
	 * @param route
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
    public List<Route> select(@Param("route")Route route,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize)throws Exception;

    /** 
	 * 根据线路名称查找线路
	 **/
	public List<Route>  getRouteByName(@Param("routeName") String routeName) throws Exception;
}
