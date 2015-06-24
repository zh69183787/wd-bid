package com.wonders.stpt.bid.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.wonders.stpt.bid.domain.BidImportMain;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.domain.Dictionary;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.domain.vo.HighChartData;
import com.wonders.stpt.bid.service.IBidImportMainService;
import com.wonders.stpt.bid.service.IBiddingService;
import com.wonders.stpt.bid.service.IDictionaryService;
import com.wonders.stpt.bid.service.IRouteService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;


@Controller
@RequestMapping("/bidding")
public class BiddingController extends BaseController {

    private final Logger logger = Logger.getLogger(BiddingController.class);

    @Autowired
    private IBiddingService biddingService;
    @Autowired
    private IRouteService routeService;
    
    @Autowired
    private IBidImportMainService bidImportMainService;
    
    @Autowired
    private IDictionaryService dictionaryService;

    @RequestMapping(method = RequestMethod.GET, value = "/biddingTimerTask")
    public void biddingTimerTask(Model model) throws Exception {

        biddingService.updateCompleteTime();
        model.addAttribute("success","数据同步成功");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/form")
    public String input(Bidding bidding, Model model) throws Exception {

        //model.addAttribute("route", routeService.getRoutes(route, 1, Integer.MAX_VALUE));
        bidding.setBidType("1");
        bidding.setCreateTime(new Date());
        model.addAttribute("bidding",bidding);
        return "bidding/bidding_save";
    }

    /**
     * 获取所有的线路
     *
     * @param route
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/routeList")
    public void routeList(Route route, Model model) throws Exception {
        List<Route> routes = routeService.getRoutes(route, 1, Integer.MAX_VALUE);
        model.addAttribute("route", routes);
        //return "bidding/bidding_save";
    }

    /**
     * 查询
     *
     * @param bidding
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/biddings")
    public void biddings(Bidding bidding, @RequestParam(required = false, value = "routeIds[]") String[] routeIds,
                         @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (routeIds != null && routeIds.length == 1) {
            bidding.setRouteId(routeIds[0]);
        }

        if (!hasAdminRole()) {
            if (bidding.getRoute() == null)
                bidding.setRoute(new Route());

            bidding.getRoute().setCreator(getUserInfo().getUserId());
        }

        List biddings = biddingService.getBiddings(bidding, pageIndex, pageSize);
        model.addAttribute("biddings", biddings);
        model.addAttribute("pageInfo", ((PageList) biddings).getPageInfo());
    }
    
    
    /**
     * 查询
     *
     * @param bidding
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/biddingsImportUnHas")
    public String biddingsImportUnHas(Bidding bidding, @RequestParam(required = false, value = "routeIds[]") String[] routeIds,
    		@RequestParam(required = true) String mainId,
                         @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (routeIds != null && routeIds.length == 1) {
            bidding.setRouteId(routeIds[0]);
        }

        if (!hasAdminRole()) {
            if (bidding.getRoute() == null)
                bidding.setRoute(new Route());

            bidding.getRoute().setCreator(getUserInfo().getUserId());
        }

        List biddings = biddingService.selectByMainIdIsDels(bidding, mainId, pageIndex, pageSize);
        BidImportMain bidImportMain = bidImportMainService.getBo(mainId);
        model.addAttribute("bidImportMain", bidImportMain);
        model.addAttribute("biddings", biddings);
        model.addAttribute("pageInfo", ((PageList) biddings).getPageInfo());
        
        return "bidimport/biddingUnHasImports";
    }

    /**
     * 模糊查询
     *
     * @param bidding
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/fuzzy")
    public void fuzzy(Bidding bidding, Model model) throws Exception {

        List biddings = biddingService.getBiddings(bidding, 1, 10);

        model.addAttribute("biddings", biddings);
        /*model.addAttribute("biddings", biddings);
        model.addAttribute("pageInfo", ((PageList) biddings).getPageInfo());*/
    }

    @RequestMapping(method = RequestMethod.GET, value = "/cancel")
    public String cancel(String biddingId, Model model) throws Exception {
        Bidding bidding = new Bidding();
        bidding.setBiddingId(biddingId);
        bidding.setBidState(Bidding.CANCEL_STATE);
        biddingService.save(bidding);
        return "redirect:/bidding/biddings";

    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/cancelImport")
    public String cancelImport(String biddingId,String mainId, Model model) throws Exception {
        Bidding bidding = new Bidding();
        bidding.setBiddingId(biddingId);
        bidding.setBidState(Bidding.CANCEL_STATE);
        biddingService.save(bidding);
        return "redirect:/bidding/biddingsImportUnHas?mainId="+mainId;

    }

    @RequestMapping(method = RequestMethod.POST, value = "/compare")
    public void compare(Bidding bidding, Model model) throws Exception {

        if (!validate(bidding.getBiddingId(),bidding.getRouteId(),bidding.getBiddingName(),null)) {
            model.addAttribute("msg", "biddingNameNot");
        }
        if (!validate(bidding.getBiddingId(),bidding.getRouteId(),null,bidding.getBiddingNo())) {
            model.addAttribute("msg", "biddingNoNot");
        }

    }

    /**
     * 保存
     *
     * @param bidding
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/save")
    public String save(Bidding bidding, @RequestParam(required = false, defaultValue = "1") int pageIndex, @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
       // String biddingId,String routeId, String biddingName, String biddingNo
//        if (!validate(bidding.getBiddingId(),bidding.getRouteId(),bidding.getBiddingName(),null)) {
//            model.addAttribute("msg", "biddingNameNot");
//            return "bidding/bidding_save";
//        }
        if (!validate(bidding.getBiddingId(),bidding.getRouteId(),null,bidding.getBiddingNo())) {
            model.addAttribute("msg", "biddingNoNot");
            return "bidding/bidding_save";
        }

        if (StringUtils.isBlank(bidding.getBiddingId())) {
            bidding.setUpdateTime(new Date());
            bidding.setRemoved("0");
            bidding.setUpdater(getUserInfo().getUserId());
            bidding.setCreator(getUserInfo().getUserId());
            access(bidding.getRouteId());
            biddingService.save(bidding);

        } else {
            Bidding b = biddingService.getBidding(bidding.getBiddingId());
            access(b.getRouteId());
            b.setUpdater(getUserInfo().getUserId());
            BeanUtils.copyProperties(bidding, b, "updater");
            biddingService.save(b);
            return "redirect:/bidding/biddings?pageIndex=" + pageIndex + "&pageSize=" + pageSize;
        }

        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("bidding", bidding);
        return "bidding/bidding_save";
    }


    /**
     * 去除同一路线下的相同标段false为重复
     *
     * @return
     */
    private boolean validate(String biddingId,String routeId, String biddingName, String biddingNo) throws Exception {
        Bidding bidding = new Bidding();
        bidding.setRouteId(routeId);
//        bidding.setBiddingName(biddingName);
        bidding.setBiddingNo(biddingNo);
        bidding.setBiddingId(biddingId);
        bidding.setRemoved("0");
        
        if (StringUtils.isNotBlank(biddingName) || StringUtils.isNotBlank(biddingNo) ) {
            if (StringUtils.isBlank(bidding.getBiddingId())) {//新增

                List comList = biddingService.getBiddings(bidding, 1, Integer.MAX_VALUE);
                if (comList.size() > 0) {
                    return false;
                }
            } else {
                List list = biddingService.getBiddings(bidding, 1, Integer.MAX_VALUE);
                if (list.size() > 1) {
                    return false;
                } else if (list.size() == 1 && !biddingId.equals(((Bidding) list.get(0)).getBiddingId())) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{biddingId}/delete")
    public String delete(@PathVariable String biddingId) throws Exception {
        Bidding bidding = biddingService.getBidding(biddingId);
        if(bidding!=null){
            bidding.setRemoved("1");
            biddingService.save(bidding);
        }
        
        return "redirect:/bidding/biddings";
    }

    /**
     * 根据biddingId查找记录
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{biddingId}")
    public String bidding(@PathVariable String biddingId, Model model, @RequestParam(required = false, defaultValue = "1") int pageIndex,
                          @RequestParam(required = false, defaultValue = "15") int pageSize) throws Exception {
        Bidding bidding = biddingService.getBidding(biddingId);
        model.addAttribute("bidding", bidding);
        access(bidding.getRouteId());
        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("pageSize", pageSize);
        return "bidding/bidding_save";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/getBiddingWithoutSelf")
    public void getBiddingWithoutSelf(Bidding bidding, @RequestParam(required = false, defaultValue = "1") int pageIndex,
                                      @RequestParam(required = false, defaultValue = "15") int pageSize,Model model){
    	List<Bidding> biddings = biddingService.getBiddingWithoutSelf(bidding,pageIndex,Integer.MAX_VALUE);
        model.addAttribute(biddings);
    }
    
    
    
    /**
     * ajax  获取季度统计图
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/seasonReport")
    public void seasonReport( @RequestParam(required = false) String year,Model model) throws Exception {
    	List<Dictionary> types = dictionaryService.selectAllByParentNo("80");
        List<Map<String,Object>> counts = biddingService.countForSeason(year);
        List<HighChartData> datas = new ArrayList<HighChartData>();
        
        
        for(Dictionary d:types){
        	HighChartData hd = new HighChartData(d.getDictName(),4);
        	
        	for(Map<String,Object> m :counts ){
        		if(m.get("btype").equals(d.getDictCode())){
        			hd.getData()[Integer.parseInt(m.get("season").toString())-1] = Double.parseDouble(m.get("countnum").toString()) ;
        		}
        	}
        	datas.add(hd);
        }
        
        model.addAttribute("datas", datas);
    }
    
    /**
     * ajax  获取线路统计图
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/routeReport")
    public void routeReport( @RequestParam(required = false) String year,Model model) throws Exception {
    	List<Dictionary> types = dictionaryService.selectAllByParentNo("80");
        List<Map<String,Object>> counts = biddingService.countForRoute(year);
        List<HighChartData> datas = new ArrayList<HighChartData>();
        
        List<String> categories = new ArrayList<String>();
        for(Map<String,Object> m :counts){
        	if(!categories.contains(m.get("rname"))){
        		categories.add(m.get("rname").toString());
        	}
        }
        
        for(Dictionary d:types){
        	HighChartData hd = new HighChartData(d.getDictName(),categories.size());
        	
        	for(Map<String,Object> m :counts ){
        		if(m.get("btype").equals(d.getDictCode())){
        			hd.getData()[categories.indexOf(m.get("rname"))] = Double.parseDouble(m.get("countnum").toString()) ;
        		}
        			
        	}
        	datas.add(hd);
        }
        
        model.addAttribute("categories", categories);
        model.addAttribute("datas", datas);
    }
}
