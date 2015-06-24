package com.wonders.stpt.bid.controller;

import com.wonders.stpt.bid.domain.*;
import com.wonders.stpt.bid.service.*;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageInfo;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Administrator on 2014/7/11.
 */
@Controller
@RequestMapping("/report")
public class ReportController extends BaseController {

    @Autowired
    private IBidResultService bidResultService;

    @Autowired
    private IBidPlanService bidPlanService;

    @Autowired
    private IReportService reportService;

    @Autowired
    private IBiddingService biddingService;

    @RequestMapping(method = RequestMethod.GET, value = "/plan")
    public String plan(Bidding bidding, @RequestParam(required = false, value = "routeIds[]") String[] routeIds,
                       @RequestParam(required = false, defaultValue = "1") int pageIndex,
                       @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (routeIds != null && routeIds.length == 1) {
            bidding.setRouteId(routeIds[0]);
        }

//        if (!hasAdminRole()) {
//            if (bidding.getRoute() == null)
//                bidding.setRoute(new Route());
//
//            bidding.getRoute().setCreator(getUserInfo().getUserId());
//        }
        bidding.setSortBy("SERIAL_NO");
        List<Bidding> biddings = biddingService.getBiddings(bidding, pageIndex, pageSize);
        HashMap<String, String> currentAppraise = new HashMap<String, String>();
//        for (Bidding b : biddings) {
//            //是否在同一个月份
//            if(b.getAppraiseDate()!=null&&DateFormatUtils.format(b.getAppraiseDate(),"yyyy-MM").equals(DateFormatUtils.format(new Date(),"yyyy-MM"))){
//                currentAppraise.put(b.getBiddingId(),"1");
//            }else{
//                currentAppraise.put(b.getBiddingId(),"0");
//            }
//        }
        model.addAttribute("biddings", biddings);
//        model.addAttribute("appraiseMap",currentAppraise);
        model.addAttribute("pageInfo", ((PageList) biddings).getPageInfo());
        return "/report/plan_report";
    }


    @RequestMapping(method = RequestMethod.GET)
    public String report(BidPlan bidPlan, BidCompany company, @RequestParam(required = false) String routeIds, String type, String dateRange,String method, Date beginDate, Date endDate
            , @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "4") int pageSize,
                         Model model) throws Exception {
//        String[] routeIdArr = null;
//        if (StringUtils.isNotBlank(routeIds))
//            routeIdArr = routeIds.split(",");

        GregorianCalendar tempBeginDate = (new GregorianCalendar());
        GregorianCalendar tempEndDate = (new GregorianCalendar());
        GregorianCalendar tempBidBeginDate = (new GregorianCalendar());
        GregorianCalendar tempBidEndDate = (new GregorianCalendar());
        if ("1".equals(dateRange)) {
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
            if("1".equals(method)){
                beginDate = tempBidBeginDate.getTime();
                endDate = tempBidEndDate.getTime();
            }
        } else if ("2".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 30);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            if("1".equals(method)){
                tempBidBeginDate.add(Calendar.DATE, -30);
                beginDate = tempBidBeginDate.getTime();
                endDate = tempBidEndDate.getTime();
            }
        } else if ("3".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 90);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            if("1".equals(method)){
                tempBidBeginDate.add(Calendar.DATE, -90);
                beginDate = tempBidBeginDate.getTime();
                endDate = tempBidEndDate.getTime();
            }
        }else if ("4".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 7);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
            if("1".equals(method)){
                tempBidBeginDate.add(Calendar.DATE, -7);
                beginDate = tempBidBeginDate.getTime();
                endDate = tempBidEndDate.getTime();
            }
        }else if ("5".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 180);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
            if("1".equals(method)){
                tempBidBeginDate.add(Calendar.DATE, -180);
                beginDate = tempBidBeginDate.getTime();
                endDate = tempBidEndDate.getTime();
            }
        } else {
            tempEndDate.add(Calendar.DATE, 30);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            if("1".equals(method)){
                tempBidBeginDate.add(Calendar.DATE, -30);
                beginDate = tempBidBeginDate.getTime();
                endDate = tempBidEndDate.getTime();
            }
        }


        if ("0".equals(type)) {
            bidPlan.setBeginApplyDate(beginDate);
            bidPlan.setEndApplyDate(endDate);
        }

        if ("1".equals(type)) {
            bidPlan.setBeginCheckDate(beginDate);
            bidPlan.setEndCheckDate(endDate);
        }

        if ("2".equals(type)) {
            bidPlan.setBeginBidBeginDate(beginDate);
            bidPlan.setBeginBidEndDate(endDate);
        }

        if ("3".equals(type)) {
            bidPlan.setEndBidBeginDate(beginDate);
            bidPlan.setEndBidEndDate(endDate);
        }

        if ("4".equals(type)) {
            bidPlan.setBeginOpenDate(beginDate);
            bidPlan.setEndOpenDate(endDate);
        }

        if ("6".equals(type)) {
            bidPlan.setBeginBizDate(beginDate);
            bidPlan.setEndBizDate(endDate);
        }

        if ("5".equals(type)) {
            bidPlan.setBeginTecAppraiseDate(beginDate);
            bidPlan.setEndTecAppraiseDate(endDate);
        }
        

        List<BidPlan> list = bidPlanService.getBidPlans(bidPlan, company, pageIndex, pageSize);
        
        model.addAttribute("plans", list);
        StringBuffer planIds = new StringBuffer();
        for (BidPlan plan : list) {
            planIds.append(plan.getBiddingPlanId()).append(",");
        }
        model.addAttribute("planIds", planIds.toString());
//        model.addAttribute("groups", companyService.getGroups());
        if (list != null)
            model.addAttribute("pageInfo", ((PageList<BidPlan>) list).getPageInfo());


        return "/report/report";
    }


    @RequestMapping(method = RequestMethod.GET, value = "/bidResults")
    public void bidResults(BidResult bidResult, @RequestParam(required = false) String biddingPlanIds, Model model) throws Exception {
        String[] biddingPlanIdArr = null;
        if (StringUtils.isNotBlank(biddingPlanIds)) {
            biddingPlanIdArr = biddingPlanIds.split(",");
        } else {
            return;
        }
//        bidResult.setCompany(company);
        List<BidResult> list = bidResultService.getBidResults(bidResult, biddingPlanIdArr, 1, Integer.MAX_VALUE);
        model.addAttribute("statistics", bidResultService.statisticalBidResult(bidResult, biddingPlanIdArr));
        model.addAttribute("bidResults", list);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/export")
    public ModelAndView export(BidPlan bidPlan, BidCompany company, @RequestParam(required = false) String routeIds, Model model) throws Exception {
        if (bidPlan.getBeginOpenDate() != null && bidPlan.getEndOpenDate() != null) {
            model.addAttribute("title", DateFormatUtils.format(bidPlan.getBeginOpenDate(), "yyyy年MM月dd日") + "至" + DateFormatUtils.format(bidPlan.getEndOpenDate(), "yyyy年MM月dd日") + "开标汇总表");
        } else if (bidPlan.getBeginOpenDate() != null && bidPlan.getEndOpenDate() == null) {
            model.addAttribute("title", DateFormatUtils.format(bidPlan.getBeginOpenDate(), "yyyy年MM月dd日") + "至今开标汇总表");
        } else
            model.addAttribute("title", "开标汇总表");
        String[] routeIdArr = null;
        if (StringUtils.isNotBlank(routeIds))
            routeIdArr = routeIds.split(",");
        List<BidPlan> list = bidPlanService.getBidPlans(bidPlan, company, 1, Integer.MAX_VALUE);
        StringBuffer planIds = new StringBuffer();
        for (BidPlan plan : list) {
            planIds.append(plan.getBiddingPlanId()).append(",");
        }
        model.addAttribute("plans", list);
//        model.addAttribute("sheetSize", 60);
        BidResult result = new BidResult();
        result.setCompany(company);
        String[] ids = planIds.toString().split(",");
        if (ids.length == 0)
            ids = null;
        List<BidResult> bidResults = bidResultService.getBidResults(result, ids, 1, Integer.MAX_VALUE);
        model.addAttribute("statistics", bidResultService.statisticalBidResult(result, ids));
        model.addAttribute("bidResults", bidResults);
        return new ModelAndView(new JXLExcelView(), model.asMap());
    }


    @RequestMapping(method = RequestMethod.GET, value = "/route/{routeId}/detail")
    public String routeDetail(@PathVariable String routeId, Date beginOpenDate, Date endOpenDate, String isCheck, String hasLimit, Model model) throws Exception {

        model.addAttribute("detail", reportService.getARouteReport(beginOpenDate, endOpenDate, null, null, isCheck, hasLimit, routeId));
        return "/report/route_report_detail";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/route")
    public String route(Date beginOpenDate, Date endOpenDate, String isCheck, String hasLimit, String routeId, Model model) throws Exception {

        model.addAttribute("reportList", reportService.getAllRouteReport(beginOpenDate, endOpenDate, isCheck, hasLimit, routeId));
        model.addAttribute("reportByType", reportService.getAllRouteReportType(beginOpenDate, endOpenDate, isCheck, hasLimit, routeId));
//        model.addAttribute("routeNum",reportService.getRouteBiddingNum("route"));
//        model.addAttribute("biddingNum",reportService.getRouteBiddingNum("bidding"));
        model.addAttribute("beginOpenDate", beginOpenDate);
        model.addAttribute("endOpenDate", endOpenDate);
        model.addAttribute("hasLimit", hasLimit);
        model.addAttribute("isCheck", isCheck);
        model.addAttribute("routeId", routeId);
        return "/report/route_report";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/companies/ratio")
    public void companiesRatio(Date beginOpenDate, Date endOpenDate, String routeId, String biddingTypeId, Model model) throws Exception {


        List<Map> companies = reportService.getBidPeReport(beginOpenDate, endOpenDate, routeId, "company", biddingTypeId, 1, Integer.MAX_VALUE);
        model.addAttribute("companies", companies);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/ratio")
    public String ratio(Date beginOpenDate, Date endOpenDate, String routeId, String biddingTypeId, Model model) throws Exception {

        model.addAttribute("groups", reportService.getBidPeReport(beginOpenDate, endOpenDate, routeId, "groups", biddingTypeId, 1, Integer.MAX_VALUE));

        List<Map> companies = reportService.getBidPeReport(beginOpenDate, endOpenDate, routeId, "company", biddingTypeId, 1, 5);
        PageInfo pageInfo = ((PageList) companies).getPageInfo();
        model.addAttribute("companies", companies);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("biddings", reportService.getBidPeReport(beginOpenDate, endOpenDate, routeId, "bidding", biddingTypeId, 1, Integer.MAX_VALUE));

        model.addAttribute("biddingTypeId", biddingTypeId);
        model.addAttribute("beginOpenDate", beginOpenDate);
        model.addAttribute("endOpenDate", endOpenDate);
        model.addAttribute("routeId", routeId);
        return "/report/ratio_report";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/charts")
    public void charts(Model model, String biddingId) throws Exception {
        BidPlan plan = new BidPlan();
        plan.setBiddingId(biddingId);
        List<BidPlan> plans = bidPlanService.getBidPlans(plan,null, 1, 1);
        BidPlan planResult = null;
        if (plans != null) {
            planResult = plans.get(0);
            if (planResult != null) {

                List<BidResult> bidResults = bidResultService.getBidResults(new BidResult(), new String[]{planResult.getBiddingPlanId()}, 1, Integer.MAX_VALUE);

                BigDecimal avgPrice = new BigDecimal(0);
                int bidCount = 0;
                for (BidResult bidResult : bidResults) {
                    if (bidResult.getPrePrice() != null) {
                        avgPrice = avgPrice.add(bidResult.getPrePrice());
                        if (bidResult.getPrePrice() != BigDecimal.ZERO) {
                            bidCount++;
                        }
                    }
                }

                model.addAttribute("list", bidResults);
                if (StringUtils.isNotBlank(planResult.getHasLimit()) && planResult.getLimitPrice() != null && planResult.getLimitPrice().doubleValue() > 0)
                    model.addAttribute("limitPrice", planResult.getLimitPrice());
                if (avgPrice == BigDecimal.ZERO) {
                    model.addAttribute("avgPrice", new BigDecimal(0).setScale(4, 1));
                } else {
                    model.addAttribute("avgPrice", new BigDecimal(avgPrice.doubleValue() / bidCount).setScale(4, 1));
                }
            }
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "/plan/biddingType")
    public void biddingType(Model model, String dateRange, String type, Date beginDate, Date endDate) throws Exception {
        GregorianCalendar tempBeginDate = (new GregorianCalendar());
        GregorianCalendar tempEndDate = (new GregorianCalendar());

        if ("1".equals(dateRange)) {
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
        } else if ("2".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 30);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
        } else if ("3".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 90);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
        } else if ("4".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 7);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
        }else if ("5".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 180);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
        } else {
            tempEndDate.add(Calendar.DATE, 30);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();
        }

        model.addAttribute("biddingTypeList", reportService.getOpenBidList(type, beginDate, endDate));


    }
}
