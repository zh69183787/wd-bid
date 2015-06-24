package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.RouteDao;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.service.IRouteService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2014/7/9.
 */
@Service
public class RouteServiceImpl implements IRouteService {

    @Autowired
    private RouteDao routeDao;

    @Override
    public List<Route> getRoutes(Route route, int pageIndex, int pageSize) throws Exception{
        return routeDao.select(route,pageIndex,pageSize);
    }

    @Override
    public Route getRoute(String routeId) throws Exception{
        return routeDao.selectById(routeId);
    }

    @Override
    public int delete(String routeId) throws Exception{
        return routeDao.delete(routeId);
    }

    @Override
    public Route save(Route route)throws Exception {
        if(StringUtils.isBlank(route.getRouteId()))
        routeDao.insert(route);
        else
        routeDao.update(route);
        return route;
    }

	@Override
	public List<Route> getList() throws Exception {
		// TODO Auto-generated method stub
		return routeDao.selectAll();
	}

	/** 
	 * 根据线路名称查找线路
	 **/
	@Override
	public Route getRouteByName(String routeName) throws Exception {
		List<Route> routes = routeDao.getRouteByName(routeName);
		if(routes!=null&&routes.size()>0){
			return routes.get(0);
		}
		return null;
	}
}
