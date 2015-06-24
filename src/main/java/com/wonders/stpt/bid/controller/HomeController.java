package com.wonders.stpt.bid.controller;

import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.domain.User;
import com.wonders.stpt.bid.service.IBidPlanService;
import com.wonders.stpt.bid.service.IReportService;
import com.wonders.stpt.bid.service.IUserService;

/**
 * Created by Administrator on 2014/7/9.
 */
@Controller
public class HomeController extends BaseController {

    @Autowired
    private IReportService reportService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IBidPlanService bidPlanService;

    @RequestMapping(method = RequestMethod.GET, value = "/")
    public String index(Model model) throws Exception {
        return "redirect:/dashboard";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/biddingTypeTree")
    public String biddingTypeTree(Model model) throws Exception {
        return "/include/bidding_type_tree";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/dashboard")
    public void dashboard(Model model, String dateRange,String method, Date beginDate, Date endDate, String type) throws Exception {

        Date[] dates = calcDate(dateRange, beginDate, endDate);
        beginDate = dates[0];
        endDate = dates[1];
        Date beginBidDate = dates[2];
        Date endBidDate = dates[3];
        model.addAttribute("detail", reportService.getBidPlanReport(beginBidDate, endBidDate));
//        model.addAttribute("detail", reportService.getARouteReport(null, null, beginBidDate, endBidDate, null, null, null));
        model.addAttribute("group", reportService.getBidNumList(null, beginBidDate, endBidDate));
        model.addAttribute("applyDateNum", reportService.getOpenBidNum("0", beginDate, endDate));
        model.addAttribute("checkDateNum", reportService.getOpenBidNum("1", beginDate, endDate));
        model.addAttribute("bidBeginNum", reportService.getOpenBidNum("2", beginDate, endDate));
        model.addAttribute("bidEndNum", reportService.getOpenBidNum("3", beginDate, endDate));
        model.addAttribute("tecOpenDateNum", reportService.getOpenBidNum("4", beginDate, endDate));
        model.addAttribute("tecAppraiseDateNum", reportService.getOpenBidNum("5", beginDate, endDate));
        model.addAttribute("bizAppraiseDateNum", reportService.getOpenBidNum("6", beginDate, endDate));
        model.addAttribute("method", method);
        
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        model.addAttribute("year", year);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/plans")
    public void plans(Model model, String dateRange, Date beginDate, Date endDate, String type) throws Exception {

        Date[] dates = calcDate(dateRange, beginDate, endDate);
        beginDate = dates[0];
        endDate = dates[1];
        BidPlan bidPlan = new BidPlan();
        Integer iType = null;
        if (type != null) {
            try {
                iType = Integer.parseInt(type);
            } catch (Exception e) {
            }

            switch (iType) {
                case 0:
                    bidPlan.setBeginApplyDate(beginDate);
                    bidPlan.setEndApplyDate(endDate);
                    break;
                case 1:
                    bidPlan.setBeginCheckDate(beginDate);
                    bidPlan.setEndCheckDate(endDate);
                    break;
                case 2:
                    bidPlan.setBeginBidBeginDate(beginDate);
                    bidPlan.setBeginBidEndDate(endDate);
                    break;
                case 3:
                    bidPlan.setEndBidBeginDate(beginDate);
                    bidPlan.setEndBidEndDate(endDate);
                    break;
                case 4:
                    bidPlan.setBeginOpenDate(beginDate);
                    bidPlan.setEndOpenDate(endDate);
                    break;
                case 6:
                    bidPlan.setBeginBizDate(beginDate);
                    bidPlan.setEndBizDate(endDate);
                    break;
                case 5:
                    bidPlan.setBeginTecAppraiseDate(beginDate);
                    bidPlan.setEndTecAppraiseDate(endDate);
                    break;
            }
        }
        model.addAttribute("openBidPlan", bidPlanService.getBidPlans(bidPlan, 1, Integer.MAX_VALUE));
    }

    public Date[] calcDate(String dateRange, Date beginDate, Date endDate) {
        GregorianCalendar tempBeginDate = (new GregorianCalendar());
        GregorianCalendar tempEndDate = (new GregorianCalendar());

        Date beginBidDate = new Date();
        Date endBidDate = new Date();
        //中标情况
        GregorianCalendar tempBidBeginDate = (new GregorianCalendar());
        GregorianCalendar tempBidEndDate = (new GregorianCalendar());

        if ("1".equals(dateRange)) {
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            beginBidDate = tempBidBeginDate.getTime();
            endBidDate = tempBidEndDate.getTime();
        } else if ("2".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 30);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            tempBidBeginDate.add(Calendar.DATE, -30);
            beginBidDate = tempBidBeginDate.getTime();
            endBidDate = tempBidEndDate.getTime();
        } else if ("3".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 90);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            tempBidBeginDate.add(Calendar.DATE, -90);
            beginBidDate = tempBidBeginDate.getTime();
            endBidDate = tempBidEndDate.getTime();
        } else if ("4".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 7);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            tempBidBeginDate.add(Calendar.DATE, -7);
            beginBidDate = tempBidBeginDate.getTime();
            endBidDate = tempBidEndDate.getTime();
        } else if ("5".equals(dateRange)) {
            tempEndDate.add(Calendar.DATE, 180);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            tempBidBeginDate.add(Calendar.DATE, -180);
            beginBidDate = tempBidBeginDate.getTime();
            endBidDate = tempBidEndDate.getTime();
        } else {
            tempEndDate.add(Calendar.DATE, 30);
            beginDate = tempBeginDate.getTime();
            endDate = tempEndDate.getTime();

            tempBidBeginDate.add(Calendar.DATE, -30);
            beginBidDate = tempBidBeginDate.getTime();
            endBidDate = tempBidEndDate.getTime();
        }
        return new Date[]{beginDate, endDate, beginBidDate, endBidDate};
    }

    @RequestMapping(method = RequestMethod.GET, value = "/menu")
    public String menu(ModelMap model, HttpServletRequest request) throws Exception {
        return "/include/menu";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/home")
    public void home(ModelMap model, HttpServletRequest request) throws Exception {
    }

    @RequestMapping(method = RequestMethod.GET, value = "/testUpload")
    public void testUpload(ModelMap model, HttpServletRequest request) throws Exception {

    }

    @RequestMapping(method = RequestMethod.GET, value = "/index")
    public String bridge(ModelMap model, HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();
        String loginName = (String) session.getAttribute("loginName");
        System.out.println("=================================" + loginName + "=================================");
        if (loginName == null)
            loginName = getCookieByName(request, "loginName");
        if (StringUtils.isNotBlank(loginName) && loginName.length()==16) {
            loginName = loginName.substring(0,12);
        }
        User user = userService.getUser(loginName);
        if (user == null)
            return "home";
        model.put("username", user.getLoginName());
        model.put("password", user.getPassword());
        return "/bridge";
    }

    private static String getCookieByName(HttpServletRequest request, String name) {
        String cookieValue = null;
        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];

                if (name.equals(cookie.getName())) {
                    try {
                        cookieValue = java.net.URLDecoder.decode(cookie.getValue(), "utf-8");
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }

        return cookieValue;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/logout")
    public void logout(ModelMap model, HttpServletRequest request) throws Exception {
    }

    @RequestMapping(method = RequestMethod.GET, value = "/navigation")
    public String navigation(ModelMap model, HttpServletRequest request) throws Exception {
        return "/include/navigation";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/403")
    public String forbidden(ModelMap model, HttpServletRequest request) throws Exception {
        return "403";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/405")
    public String notSupport(ModelMap model, HttpServletRequest request) throws Exception {
        return "405";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/authenticationError")
    public String authenticationError(ModelMap model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        AuthenticationException authenticationException = (AuthenticationException) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
        if (authenticationException instanceof BadCredentialsException)
            model.addAttribute("errorDetails", "用户名或密码错误");
        else if (authenticationException instanceof LockedException)
            model.addAttribute("errorDetails", "当前帐号被锁定");
        else
            model.addAttribute("errorDetails", "发生错误，请重试");
        return "home";
    }
}
