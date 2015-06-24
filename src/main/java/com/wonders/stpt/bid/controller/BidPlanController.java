package com.wonders.stpt.bid.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.domain.BidResult;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.domain.Dictionary;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.service.IBidPlanService;
import com.wonders.stpt.bid.service.IBidResultService;
import com.wonders.stpt.bid.service.IBiddingService;
import com.wonders.stpt.bid.service.IDictionaryService;
import com.wonders.stpt.bid.service.IRouteService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;

/**
 * Created by Administrator on 2014/7/10.
 */
@Controller
@RequestMapping("/plan")
public class BidPlanController extends BaseController {
    private final Logger logger = Logger.getLogger(BidPlanController.class);

    @Autowired
    private IBidPlanService bidPlanService;
    @Autowired
    private IBidResultService bidResultService;
    @Autowired
    private IBiddingService biddingService;
    
    @Autowired
    private IDictionaryService dictionaryService;

    @RequestMapping(method = RequestMethod.GET, value = "/singleRoute")
    public String singleRoute(Bidding bidding, Model model) throws Exception {

        BidPlan plan = new BidPlan();
        if (bidding != null && StringUtils.isNotBlank(bidding.getBiddingId())) {

            bidding = biddingService.getBidding(bidding.getBiddingId());
            plan.setBiddingId(bidding.getBiddingId());
            List<BidPlan> plans  = bidPlanService.getBidPlans(plan,1,1);
            if(plans!=null&&plans.size()>0){
                return "redirect:/plan/singleRoute/"+plans.get(0).getBiddingPlanId()+"?pageIndex=1";
            }
            plan.setBiddingType(bidding.getBiddingType());
            plan.setBiddingTypeId(bidding.getBiddingTypeId());
        }
        plan.getBiddingList().add(bidding);
        model.addAttribute("bidPlan", plan);
        return "/plan/singleRoute";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/multiRoute")
    public void multiRoute(Bidding bidding, Model model) throws Exception {
        BidPlan plan = new BidPlan();
        if (StringUtils.isNotBlank(bidding.getBiddingId())) {
            Integer count = biddingService.hasUsed(bidding.getBiddingId());
            if (count == 0) {
                bidding = biddingService.getBidding(bidding.getBiddingId());
                plan.getBiddingList().add(bidding);
            }


        }
        model.addAttribute("bidPlan", plan);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/multiRoute/{planId}")
    public String multiRoute(@PathVariable String planId, @RequestParam(required = true) int pageIndex, Model model) throws Exception {
        BidPlan plan = bidPlanService.getBidPlan(planId);
//        access(b.getBidding().getRouteId());

        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("bidPlan", plan);
        return "plan/multiRoute";
    }

    /**
     * 查询
     *
     * @param bidPlan
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/plans")
    public String bidPlans(BidPlan bidPlan,
                           @RequestParam(required = false, defaultValue = "1") int pageIndex,
                           @RequestParam(required = false, defaultValue = "15") int pageSize,
                           Model model) throws Exception {

        if (bidPlan.getBidding() != null
                && bidPlan.getBidding().getRoute() != null
                && StringUtils.isNotBlank(bidPlan.getBidding().getRoute()
                .getRouteId()))
            bidPlan.getBidding().setRouteId(
                    bidPlan.getBidding().getRoute().getRouteId());
        if (!hasAdminRole()) {
            if (bidPlan.getBidding() == null)
                bidPlan.setBidding(new Bidding());
            if (bidPlan.getBidding().getRoute() == null)
                bidPlan.getBidding().setRoute(new Route());
            bidPlan.getBidding().getRoute().setCreator(getUserInfo().getUserId());
        }
        List bidPlans = bidPlanService
                .getBidPlans(bidPlan, pageIndex, pageSize);
        model.addAttribute("bidPlans", bidPlans);
        model.addAttribute("pageInfo", ((PageList) bidPlans).getPageInfo());
        model.addAttribute("bidPlan", bidPlan);
        return "plan/plan_list";
    }
    
    /**
     * 招标结果分布情况
     *
     * @param bidPlan
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/distribution")
    public String distribution(BidPlan bidPlan,
                           @RequestParam(required = false, defaultValue = "1") int pageIndex,
                           @RequestParam(required = false, defaultValue = "15") int pageSize,
                           Model model) throws Exception {
    	List<Dictionary> types = dictionaryService.selectAllByParentNo("80");
    	String dictids ="";
    	int i=0;
        for(Dictionary d:types){
        	dictids+= d.getDictCode()+"-"+i+",";
        	i++;
        }
        if(!"".equals(dictids)){
        	dictids = dictids.substring(0, dictids.length()-1);
        }
    	model.addAttribute("types", types);
    	model.addAttribute("dictids", dictids);
        model.addAttribute("bidPlan", bidPlan);
        return "plan/plan_distribution";
    }
    
    /**
     * 招标结果分布情况
     *
     * @param bidPlan
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/distributionData")
    public void distributionData(BidPlan bidPlan,
    		@RequestParam(required = true) String dictids,
                           @RequestParam(required = false, defaultValue = "1") int pageIndex,
                           @RequestParam(required = false, defaultValue = Integer.MAX_VALUE+"") int pageSize,
                           Model model) throws Exception {

        if (bidPlan.getBidding() != null
                && bidPlan.getBidding().getRoute() != null
                && StringUtils.isNotBlank(bidPlan.getBidding().getRoute()
                .getRouteId()))
            bidPlan.getBidding().setRouteId(
                    bidPlan.getBidding().getRoute().getRouteId());
        if (!hasAdminRole()) {
            if (bidPlan.getBidding() == null)
                bidPlan.setBidding(new Bidding());
            if (bidPlan.getBidding().getRoute() == null)
                bidPlan.getBidding().setRoute(new Route());
            bidPlan.getBidding().getRoute().setCreator(getUserInfo().getUserId());
        }
        
        
        List<Map<String, Object>> bidPlans =  bidPlanService.getDistributionPlan(bidPlan);
        
        String[] dictIds =  dictids.split(",");
        int len =dictIds.length;
        
        
        
        DecimalFormat df = new DecimalFormat("#.0000");
       // List<Dictionary> types = dictionaryService.selectAllByParentNo("80");
        LinkedHashMap<String,String[]> data = new LinkedHashMap<String,String[]>();
        int dataLen = (len+1)*2+1;
        
        String[] last = new String[dataLen];
		for(int i=1;i<dataLen;i++){last[i]="0";}
		last[0]="合计";
        
        for(Map<String, Object> p:bidPlans){
        	String[] dates = null;
        	String code = (String) p.get("btype");
        	int countbid = Integer.parseInt(((BigDecimal) p.get("countbid")).toString());
        	double sumprice = Double.parseDouble(((BigDecimal) p.get("sumprice")).toString());
        	
        	int index = getIndexByCode(code,dictIds);
        	if(index==-1){ 
        		System.out.println(code+": 系统不能识别分类");
        		continue;}
        	if(data.get(p.get("routename"))!=null){
        		dates = data.get(p.get("routename"));
        		dates[index] = (Integer.parseInt(dates[index])+countbid)+"";
        		dates[index+1] = df.format((Double.parseDouble(dates[index+1])+sumprice));
        		
        		dates[dataLen-2] = (Integer.parseInt(dates[dataLen-2])+countbid)+"";
        		dates[dataLen-1] = df.format((Double.parseDouble(dates[dataLen-1])+sumprice));
        		
        	}else{
        		dates = new String[dataLen];
        		for(int i=0;i<dataLen;i++){dates[i]="0";}
        		dates[0] = (String) p.get("routename");
        		dates[index] = countbid+"";
        		dates[index+1] = df.format(sumprice);
        		
        		dates[dataLen-2] = countbid+"";
        		dates[dataLen-1] = df.format(sumprice);
        		data.put((String) p.get("routename"), dates);
        	}
        	 
        	last[index] = (Integer.parseInt(last[index])+countbid)+"";
    		last[index+1] = df.format(Double.parseDouble(last[index+1])+sumprice);
    		last[dataLen-2] = (Integer.parseInt(last[dataLen-2])+countbid)+"";
    		last[dataLen-1] = df.format(Double.parseDouble(last[dataLen-1])+sumprice);
    		
        	data.put((String) p.get("routename"), dates);
        }
        
        model.addAttribute("last", last);
        model.addAttribute("distributions", data);
      //  model.addAttribute("pageInfo", ((PageList) bidPlans).getPageInfo());
       // model.addAttribute("bidPlan", bidPlan);
       // return "plan/plan_list";
    }
    
    public int getIndexByCode(String code,String[] dictIds){
    	String index ="-1";
    	//int i=0;
    	for(String s:dictIds){
    		if((s.split("-")[0]).equals(code)){
    			index = s.split("-")[1];
    			break;
    		}
    		//i++;
    	}
    	if(index!="-1"){
    		return Integer.parseInt(index)*2+1;
    	}
//    	int c = Integer.
    	return Integer.parseInt(index);
    }
    

//    /**
//     * 查询
//     *
//     * @param bidPlan
//     * @param model
//     */
//    @RequestMapping(method = RequestMethod.POST, value = "/fuzzy")
//    public String fuzzy(BidPlan bidPlan,
//                        @RequestParam(required = false, defaultValue = "1") int pageIndex,
//                        @RequestParam(required = false, defaultValue = "15") int pageSize,
//                        Model model) throws Exception {
//        if (bidPlan.getBidding() != null
//                && bidPlan.getBidding().getRoute() != null
//                && StringUtils.isNotBlank(bidPlan.getBidding().getRoute()
//                .getRouteId()))
//            bidPlan.getBidding().setRouteId(
//                    bidPlan.getBidding().getRoute().getRouteId());
//        List bidPlans = bidPlanService
//                .getBidPlanss(bidPlan, pageIndex, pageSize);
//        model.addAttribute("bidPlans", bidPlans);
//        model.addAttribute("pageInfo", ((PageList) bidPlans).getPageInfo());
//        model.addAttribute("bidPlan", bidPlan);
//        return "plan/plan_list";
//    }

    /**
     * 保存
     *
     * @param bidPlan
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/save")
    public String save(BidPlan bidPlan,
                       @RequestParam(required = false, defaultValue = "1") int pageIndex,
                       @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (validate(bidPlan.getBiddingPlanId(), bidPlan.getBiddingList().get(0).getBiddingId(), bidPlan.getBiddingName(), bidPlan.getBidType()))
            if (StringUtils.isBlank(bidPlan.getBiddingPlanId())) {// 新增

                StringBuffer biddingIds = new StringBuffer("");
                for (Bidding bidding : bidPlan.getBiddingList()) {
                    biddingIds.append(bidding.getBiddingId()).append(",");
                }
//                access(biddingService.getBiddings(biddingIds.toString().split(",")).getRouteId());
                bidPlan.setRemoved("0");
                bidPlan.setCreator(getUserInfo().getUserId());
                bidPlan.setUpdater(getUserInfo().getUserId());
                // 判断biddingid是否存在 ，存在退出，不存在保存
                bidPlanService.save(bidPlan);
            } else {
                BidPlan b = bidPlanService.getBidPlan(bidPlan.getBiddingPlanId());

                // 判断db里的biddingid与页面上是否一样 ，true直接保存，false count（新的biddingid）
//                String routeId = b.getBidding().getRouteId();
//                access(routeId);
                b.setUpdater(getUserInfo().getUserId());
                BeanUtils.copyProperties(bidPlan, b, "updater");
                if ("1".equals(bidPlan.getRemoved())) {// 逻辑删除
                    BidResult br;
                    List result = bidResultService.getBidResults(new BidResult(),
                            new String[]{bidPlan.getBiddingPlanId()}, 1,
                            Integer.MAX_VALUE);
                    for (int i = 0; i < result.size(); i++) {
                        br = (BidResult) result.get(i);
                        if ("通过".equals(br.getIsApplicant()))
                            br.setIsApplicant("1");
                        else
                            br.setIsApplicant("0");
                        br.setRemoved("1");
                        bidResultService.save(br);
                    }
                }

                bidPlanService.save(b);
            }
        return "redirect:/plan/plans?pageIndex=" + pageIndex + "&pageSize=" + pageSize;
    }


    /**
     * 去重查询
     *
     * @param bidPlan
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/compare")
    public void compare(BidPlan bidPlan, Model model) throws Exception {
        if (validate(bidPlan.getBiddingPlanId(), bidPlan.getBiddingId(), bidPlan.getBiddingName(), bidPlan.getBidType())) {
            model.addAttribute("msg", "yes");
        } else {
            model.addAttribute("msg", "no");
        }
    }

    /**
     * false为重复
     *
     * @return
     * @throws Exception
     */
    private boolean validate(String planId, String biddingId, String biddingName, String bidType) throws Exception {
        BidPlan bidPlan = new BidPlan();
        bidPlan.setBiddingPlanId(planId);
        bidPlan.setBidType(bidType);
        if ("2".equals(bidType)) {
            bidPlan.setBiddingName(biddingName);
        } else {

            bidPlan.setBiddingId(biddingId);
        }
        if (StringUtils.isBlank(bidPlan.getBiddingPlanId())) {//新增是否重复
            List comPlan = bidPlanService.getBidPlans(bidPlan, 1, Integer.MAX_VALUE);
            if (comPlan.size() > 0) return false;
        } else {
            String biddingPlanId = bidPlan.getBiddingPlanId();// 当前更新记录的主键
            bidPlan.setBiddingPlanId(null);
            List bidPlans = bidPlanService.getBidPlans(bidPlan, 1,
                    Integer.MAX_VALUE);//或cout()
            bidPlan.setBiddingPlanId(biddingPlanId);
            if (bidPlans.size() > 1) {
                return false;
            } else if (bidPlans.size() == 1
                    && !biddingPlanId.equals(((BidPlan) bidPlans.get(0))
                    .getBiddingPlanId())) {
                return false;
            }
        }
        return true;
    }

    /**
     * 根据bidPianId值查询记录
     *
     * @param planId
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/singleRoute/{planId}")
    public String singleRoute(@PathVariable String planId, @RequestParam(required = true) int pageIndex, Model model)
            throws Exception {

        BidPlan b = bidPlanService.getBidPlan(planId);
//        access(b.getBidding().getRouteId());

        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("bidPlan", b);
        return "plan/singleRoute";
    }


//    /**
//     * 根据bidPianId值查询记录
//     *
//     * @param bidPlanId
//     * @param model
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(method = RequestMethod.GET, value = "/{bidPlanId}")
//    public String bidPlan(@PathVariable String bidPlanId, Model model)
//            throws Exception {
//
//        BidPlan b = bidPlanService.getBidPlan(bidPlanId);
//        access(b.getBidding().getRouteId());
//
//        //model.addAttribute("pageIndex", pageIndex);
//        model.addAttribute("bidPlan", b);
//        return "plan/plan_save";
//    }

    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{bidPlanId}/delete")
    public String delete(@PathVariable String bidPlanId) throws Exception {
        BidPlan plan = bidPlanService.getBidPlan(bidPlanId);
        if (plan != null) {
            plan.setRemoved("1");
            bidPlanService.save(plan);
        }

        return "redirect:/plan/plans";
    }
}
