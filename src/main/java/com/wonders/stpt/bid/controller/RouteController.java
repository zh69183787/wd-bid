package com.wonders.stpt.bid.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.service.IUserService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.service.IBiddingService;
import com.wonders.stpt.bid.service.IRouteService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;

/**
 * Created by Administrator on 2014/7/9.
 */
@Controller
@RequestMapping("/route")
public class RouteController extends BaseController{

    private final Logger logger = Logger.getLogger(RouteController.class);

    @Autowired
    private IRouteService routeService;
    @Autowired
    private IUserService userService;
    @Autowired
    private IBiddingService biddingService;
    @RequestMapping(method = RequestMethod.GET, value = "/form")
    public String input(Model model)  throws Exception{

        model.addAttribute("users",userService.getUsers("ROLE_EDITOR",1,Integer.MAX_VALUE));
        return "route/route";
    }

    /**
     * 读取数据
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{routeId}")
    public String route(@PathVariable String routeId,Model model) throws Exception{
        model.addAttribute("route", routeService.getRoute(routeId)) ;
        model.addAttribute("users",userService.getUsers("ROLE_EDITOR",1,Integer.MAX_VALUE));
        return "route/route";
    }
    
    /**
     * 读取数据
     */
    @RequestMapping(method = RequestMethod.GET, value = "/routeEdit")
    public String routeEdit(@RequestParam(required=true) String routeId,@RequestParam(required=true) int pageIndex,Model model) throws Exception{
        model.addAttribute("route", routeService.getRoute(routeId)) ;
        model.addAttribute("users",userService.getUsers("ROLE_EDITOR",1,Integer.MAX_VALUE));
        model.addAttribute("pageIndex", pageIndex);
        return "route/route";
    }

    /**
     * 查询
     *
     * @param route
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/routes")
    public void routes(Route route,
                       @RequestParam(required = false, defaultValue = "1") int pageIndex,
                       @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception{

//        if(!hasAdminRole()){
//            route.setCreator(getUserInfo().getUserId());
//        }
    	List routes =  routeService.getRoutes(route,pageIndex,pageSize);
        model.addAttribute("routes", routes);
        model.addAttribute("pageInfo", ((PageList) routes).getPageInfo());
    }

    /**c
     *
     * 新增
     *
     * @param route
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.POST)
    public String create(Route route, Model model)throws Exception{
    	if(check(route)){
	    	route.setCreateTime(new Date());
	    	route.setUpdateTime(new Date());
	    	route.setRemoved("0");
            route.setCreator(getUserInfo().getUserId());
            route.setUpdater(getUserInfo().getUserId());
	        routeService.save(route);
    	}
        return "redirect:/route/routes";
    }
    @RequestMapping(method=RequestMethod.GET,value="/compare")
    public void compare(Route route, Model model)throws Exception{
    	if(check(route)){
    		model.addAttribute("msg", "yes");
    	}else{
    		model.addAttribute("msg", "no");
    	}
    }
    
    private Boolean check(Route r) throws Exception{
        Route route = new Route();
        route.setRouteId(r.getRouteId());
        route.setRouteName(r.getRouteName());

    	if(StringUtils.isBlank(route.getRouteId())){//新增
    		List list=routeService.getRoutes(route, 1, Integer.MAX_VALUE);
    		if(list.size()>0)
    			return false;
    	}else{
    		String routeId=route.getRouteId();
    		route.setRouteId(null);
    		List list=routeService.getRoutes(route, 1, Integer.MAX_VALUE);
    		route.setRouteId(routeId);
            if(list.size() > 1)
                return false;
    		if(list.size()==1&& !routeId.equals(((Route)list.get(0)).getRouteId()))
    				return false;
    	}
    	return true;
    }

    /**
     * 修改
     * @param route
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.POST, value = "/{routeId}")
    public String update(Route route,@RequestParam(required=false,defaultValue = "1")int pageIndex,@RequestParam(required=false,defaultValue = "15")int pageSize, Model model) throws Exception{
        if(!"1".equals(route.getRemoved())&&!check(route)){
            return "redirect:/route/routeEdit?routeId="+route.getRouteId()+"&msg=no&pageIndex="+pageIndex+"&pageSize="+pageSize;
        }

	        Route pRoute = routeService.getRoute(route.getRouteId());
            pRoute.setUpdater(getUserInfo().getUserId());
	        BeanUtils.copyProperties(route,pRoute,"updater");
	        if("1".equals(route.getRemoved())){//级联删除
	        	//根据routeId删除bidding中的记录
	        	Bidding bidding=new Bidding();
	        	bidding.setRouteId(route.getRouteId());
	        	List list=biddingService.getBiddings(bidding, 1, Integer.MAX_VALUE);
	        	
	        	for(int i=0;i<list.size();i++){
	        		bidding=(Bidding)list.get(i);
	        		bidding.setRemoved("1");
	        		biddingService.save(bidding);
	        	}
	        	
	        }
	        routeService.save(pRoute);

        return "redirect:/route/routes?pageIndex="+pageIndex+"&pageSize="+pageSize;
    }

    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{routeId}/delete")
    public String delete(@PathVariable String routeId) throws Exception {
        Route route = routeService.getRoute(routeId);
        if(route!=null){
            route.setRemoved("1");
            routeService.save(route);
        }

        return "redirect:/route/routes";
    }

}

