package com.wonders.stpt.bid.service;

import com.wonders.stpt.bid.domain.Route;

import java.util.List;

/**
 * Created by Administrator on 2014/7/9.
 */
public interface IRouteService {
    List<Route> getRoutes(Route route,int pageIndex,int pageSize)throws Exception;

    Route getRoute(String routeId)throws Exception;

    int delete(String routeId)throws Exception;

    Route save(Route route)throws Exception;
    
    List<Route> getList()throws Exception;
    
    /** 
	 * 根据线路名称查找线路
	 **/
    Route getRouteByName(String routeName)throws Exception;
}
