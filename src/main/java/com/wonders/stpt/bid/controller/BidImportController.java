package com.wonders.stpt.bid.controller;

import java.util.Date;
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

import com.wonders.stpt.bid.domain.BidImport;
import com.wonders.stpt.bid.domain.BidImportMain;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.service.IBidImportMainService;
import com.wonders.stpt.bid.service.IBidImportService;
import com.wonders.stpt.bid.service.IBiddingService;
import com.wonders.stpt.bid.service.IDictionaryService;
import com.wonders.stpt.bid.service.IRouteService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;


@Controller
@RequestMapping("/bidimport")
public class BidImportController extends BaseController {

    private final Logger logger = Logger.getLogger(BidImportController.class);

    @Autowired
    private IBidImportService bidImportService;
    @Autowired
    private IBidImportMainService bidImportMainService;
    @Autowired
    private IRouteService routeService;
    
    @Autowired
    private IBiddingService biddingService;
    

    @RequestMapping(method = RequestMethod.GET, value = "/form")
    public String input(BidImport bidImport, Model model) throws Exception {

        //model.addAttribute("route", routeService.getRoutes(route, 1, Integer.MAX_VALUE));
        bidImport.setBidType("1");
        bidImport.setCreateTime(new Date());
        model.addAttribute("bidImport",bidImport);
        return "bidimport/bidimport_save";
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
        //return "bidImport/bidImport_save";
    }
    
    
    
    /**
     * 查询 导入计划列表
     *
     * @param bidImport
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/bidimports")
    public String bidImports(BidImport bidImport, 
                         @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (!hasAdminRole()) {
            if (bidImport.getRoute() == null)
                bidImport.setRoute(new Route());

            bidImport.getRoute().setCreator(getUserInfo().getUserId());
        }
        
        if(bidImport.getMainId()!=null&&!"".equals(bidImport.getMainId())){
        	BidImportMain bidImportMain = bidImportMainService.getBo(bidImport.getMainId());

            List bidImports = bidImportService.getBidImports(bidImport, pageIndex, pageSize);
            model.addAttribute("bidImports", bidImports);
            model.addAttribute("bidImportMain", bidImportMain);
          model.addAttribute("pageInfo", ((PageList) bidImports).getPageInfo());
        	
        	return "bidimport/bidimports";
        }else{
        	return "bidimportmain/bidImportMains";
        }
        
    }
    /**
     * 查询 主页表中显示导入的数据列表
     *
     * @param bidImport
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/bidimportsForMain")
    public String bidImportsByMainId(BidImport bidImport, 
    		@RequestParam(required = true) String mainId,
                         @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "10") int pageSize, Model model) throws Exception {
        if (!hasAdminRole()) {
            if (bidImport.getRoute() == null)
                bidImport.setRoute(new Route());

            bidImport.getRoute().setCreator(getUserInfo().getUserId());
        }
        
        bidImport.setMainId(mainId);

        List bidImports = bidImportService.getBidImports(bidImport, 1, Integer.MAX_VALUE);
        model.addAttribute("bidImports", bidImports);
        model.addAttribute("mainId", mainId);
        
        return "bidimport/bidimports_formain";
    }
    /**
     * 对比BIDDING  表中的数据
     *
     * @param bidImport
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/completeData")
    public String completeData(BidImport bidImport, 
    		@RequestParam(required = true) String mainId,
                         @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "10") int pageSize, Model model) throws Exception {
        if (!hasAdminRole()) {
            if (bidImport.getRoute() == null)
                bidImport.setRoute(new Route());

            bidImport.getRoute().setCreator(getUserInfo().getUserId());
        }
        bidImport.setMainId(mainId);
        Map<String,Object> data = bidImportService.completeData(bidImport);
        model.addAttribute("bidImports", data.get("bidImports"));
        model.addAttribute("bidImportMain", data.get("bidImportMain"));
        model.addAttribute("biddels", data.get("biddels"));
        model.addAttribute("mainId", mainId);
        return "redirect:/bidimport/bidimports";
    }
    /**
     * 模糊查询
     *
     * @param bidImport
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/fuzzy")
    public void fuzzy(BidImport bidImport, Model model) throws Exception {

        List bidImports = bidImportService.getBidImports(bidImport, 1, 10);

        model.addAttribute("bidImports", bidImports);
        /*model.addAttribute("bidImports", bidImports);
        model.addAttribute("pageInfo", ((PageList) bidImports).getPageInfo());*/
    }

    @RequestMapping(method = RequestMethod.GET, value = "/cancel")
    public String cancel(String biddingId, Model model) throws Exception {
        BidImport bidImport = new BidImport();
        bidImport.setBiddingId(biddingId);
        bidImportService.save(bidImport);
        return "redirect:/bidimport/bidimports";

    }

    /**
     * 查看对比
     * @param bidImport
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/compare")
    public String compare(BidImport bidImport, Model model) throws Exception {
    	
    	Bidding bidding = null;
    	if(bidImport.getBiddingId()!=null&&!"".equals(bidImport.getBiddingId()))
    		bidImport = bidImportService.getBidImport(bidImport.getBiddingId());
    	if(bidImport.getUbiddingId()!=null&&!"".equals(bidImport.getUbiddingId())){
    		bidding = biddingService.getBidding(bidImport.getUbiddingId());
    	}
    	model.addAttribute("bidImport", bidImport);
    	model.addAttribute("bidding", bidding);
    	return "bidimport/bidimport_compare";
    }
    
    /**
     * 查看对比
     * @param bidImport
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/compareSave")
    public String compareSave(BidImport bidImport, Model model) throws Exception {
    	
    	String isupdate = bidImport.getIsUpdate();
    	
    	Bidding bidding = null;
    	if(bidImport.getBiddingId()!=null&&!"".equals(bidImport.getBiddingId())){
    		bidImport = bidImportService.getBidImport(bidImport.getBiddingId());
    	}    
    	
    	if(bidImport.getUbiddingId()!=null&&!"".equals(bidImport.getUbiddingId())){
    		bidding = biddingService.getBidding(bidImport.getUbiddingId());
    	}
    	if(bidImport!=null&&"2".equals(isupdate)){//忽略
    		bidImport.setIsUpdate("2");
    		bidImportService.save(bidImport);
    		return "redirect:/bidimport/bidimports?mainId="+bidImport.getMainId();
    	}else{
    		bidImportService.saveComplete(bidImport,bidding);
    	}
    	
    	
    	model.addAttribute("bidImport", bidImport);
    	model.addAttribute("bidding", bidding);
    	return "redirect:/bidimport/compare?biddingId="+bidImport.getBiddingId();
    }

    /**
     * 保存
     *
     * @param bidImport
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/save")
    public String save(BidImport bidImport, @RequestParam(required = false, defaultValue = "1") int pageIndex, @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
       // String bidImportId,String routeId, String bidImportName, String bidImportNo

        if (StringUtils.isBlank(bidImport.getBiddingId())) {
            bidImport.setUpdateTime(new Date());
            bidImport.setRemoved("0");
            bidImport.setUpdater(getUserInfo().getUserId());
            bidImport.setCreator(getUserInfo().getUserId());
            bidImportService.save(bidImport);

        } else {
            BidImport b = bidImportService.getBidImport(bidImport.getBiddingId());
            b.setUpdater(getUserInfo().getUserId());
            BeanUtils.copyProperties(bidImport, b, "updater");
            b.setFullTypeName(bidImport.getFullTypeName());
            
            //匹对线路和招标类型
            
            
            
            
//            b.setTypeFour(typeFour);
            bidImportService.save(b);
            return "redirect:/bidimport/bidimports?mainId=" + bidImport.getMainId();
        }

        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("bidImport", bidImport);
        return "redirect:/bidimport/bidimports?mainId=" + bidImport.getMainId();
    }


    /**
     * 去除同一路线下的相同标段false为重复
     *
     * @return
     */
    private boolean validate(String biddingId,String biddingName, String biddingNo) throws Exception {
        BidImport bidImport = new BidImport();
        bidImport.setBiddingName(biddingName);
        bidImport.setBiddingNo(biddingNo);
        bidImport.setBiddingId(biddingId);

        if (StringUtils.isNotBlank(biddingName) || StringUtils.isNotBlank(biddingNo) ) {
            if (StringUtils.isBlank(bidImport.getBiddingId())) {//新增

                List comList = bidImportService.getBidImports(bidImport, 1, Integer.MAX_VALUE);
                if (comList.size() > 0) {
                    return false;
                }
            } else {
                List list = bidImportService.getBidImports(bidImport, 1, Integer.MAX_VALUE);
                if (list.size() > 1) {
                    return false;
                } else if (list.size() == 1 && !biddingId.equals(((BidImport) list.get(0)).getBiddingId())) {
                    return false;
                }
            }
        }

        return true;
    }

    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/delete")
    public String delete(@PathVariable String biddingId) throws Exception {

        return "redirect:/bidimport/bidimports";
    }

    /**
     * 根据bidImportId查找记录
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/editImport")
    public String editImport(@RequestParam(required = true) String bidImportId, Model model) throws Exception {
        BidImport bidImport = bidImportService.getBidImport(bidImportId);
        model.addAttribute("bidImport", bidImport);
        return "bidimport/bidimport_save";
    }


}
