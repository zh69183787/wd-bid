package com.wonders.stpt.bid.controller;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.wonders.stpt.bid.domain.*;
import com.wonders.stpt.bid.service.IRouteService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.util.Region;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wonders.stpt.bid.service.IBidCompanyService;
import com.wonders.stpt.bid.service.IBidPlanService;
import com.wonders.stpt.bid.service.IBidResultService;
import com.wonders.stpt.bid.utils.Context;

@Controller
@RequestMapping("/result")
public class ResultController extends BaseController {
    private final Logger logger = Logger.getLogger(ResultController.class);
    @Autowired
    private IBidResultService bidResultService;
    @Autowired
    private IBidCompanyService companyService;
    @Autowired
    private IBidPlanService bidPlanService;
    @Autowired
    private IRouteService routeService;

    @RequestMapping(method = RequestMethod.POST, value = "/results")
    public String results(BidPlan bidPlan, Model model) throws Exception {

        BidPlan b = bidPlanService.getBidPlan(bidPlan.getBiddingPlanId());
        List<BidResult> oldResultList = bidResultService.getBidResults(new BidResult(), new String[]{bidPlan.getBiddingPlanId()}, 1, Integer.MAX_VALUE);
//        access(b.getBidding().getRouteId());
        List<BidResult> resultList = new ArrayList<BidResult>();

        if (bidPlan.getBidResultList() != null) {
            if ("2".equals(b.getBidType())) {
                for (BidResult newResult : bidPlan.getBidResultList()) {
                    BidResult r = new BidResult();
                    BeanUtils.copyProperties(newResult, r);
                    if (StringUtils.isNotBlank(newResult.getMultiBiddingPrice())) {
                        String[] data = newResult.getMultiBiddingPrice().split(",");
                        for (String s : data) {
                            String[] info = s.split("-");
                            String biddingId = info[0];
                            String finalPrice = info[1];

                            r.setBiddingId(biddingId);
                            r.setFinalPrice(new BigDecimal(finalPrice));
                            resultList.add(r);
                        }
                    }

                }
            }else{
                resultList = bidPlan.getBidResultList();
            }
            for (BidResult newResult : resultList) {
                for (BidResult oldResult : oldResultList) {
                    if (oldResult.getBiddingId().equals(newResult.getBiddingId()) && oldResult.getCompanyId().equals(newResult.getCompanyId())) {
                        newResult.setBidResultId(oldResult.getBidResultId());
                    }
                }
                newResult.setCreator(getUserInfo().getUserId());
                newResult.setUpdater(getUserInfo().getUserId());
                bidResultService.save(newResult);

            }


            bidPlan = bidPlanService.getBidPlan(bidPlan.getBiddingPlanId());
            bidPlan.setUpdateTime(new Date());
            bidPlanService.save(bidPlan);
        }

        return "redirect:/result/detail?biddingPlanId=" + bidPlan.getBiddingPlanId();
    }

    /**
     * 分组查询
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/group")
    public String selectByGroup(BidResult result, String type, Model model) throws Exception {
        if ("3".equals(type))
            result.setFinalPrice(BigDecimal.valueOf(0.0001));
        List<BidResult> list = bidResultService.selectByGroupC(result);

        if (StringUtils.isBlank(type))
            type = "1";
        //共计
        List listAll = bidResultService.countAll(result);

        //单位统计
        List listCompanyName = bidResultService.countGroup(result);

        //根据集团统计
        List listGroups = bidResultService.countGroups(result);
        //将数据整理成页面显示的结果集
        List listResult = null;
        if (list.size() > 0)
            listResult = dispose(list, listCompanyName, listGroups, type);
        model.addAttribute("listAll", listAll);
        model.addAttribute("results", listResult);
        model.addAttribute("result", result);
        model.addAttribute("type", type);
        return "/result/report";
    }


    @RequestMapping(method = RequestMethod.GET, value = "/{companyId}/results")
    public String record(@PathVariable String companyId, String type, Model model) throws Exception {
        BidResult result = new BidResult();
        result.setCompanyId(companyId);
        if (StringUtils.isNotBlank(type)) {
            if ("2".equals(type)) {
                type = "2";
                result.setFinalPrice(new BigDecimal(1));
            } else {
                type = "1";
                result.setPrePrice(new BigDecimal(1));
            }
        } else {
            result.setPrePrice(new BigDecimal(1));
            type = "1";
        }
        model.addAttribute("type", type);
        model.addAttribute("companyId", companyId);
        model.addAttribute("results", bidResultService.getCompanyBidResult(result, 1, Integer.MAX_VALUE));


        return "/result/company_result";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/detail")
    public String detail(@RequestParam(required = true) String biddingPlanId, Model model) throws Exception {


        BidPlan bidPlan = bidPlanService.getBidPlan(biddingPlanId);
        if (bidPlan == null)
            throw new Exception("错误的参数:" + biddingPlanId + ",没有找到记录!");

        StringBuffer biddingIdList = new StringBuffer();
        for (Bidding bidding : bidPlan.getBiddingList()) {
            biddingIdList.append(bidding.getBiddingId()).append(",");
        }
        model.addAttribute("bidPlan", bidPlan);
        model.addAttribute("biddingIdList",StringUtils.substringBeforeLast(biddingIdList.toString(),","));
        return "result/result_list";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/results")
    public String results(@RequestParam(required = true) String biddingPlanId, Model model) throws Exception {

        List<BidResult> bidResults = bidResultService.getBidResults(new BidResult(), new String[]{biddingPlanId}, 1, Integer.MAX_VALUE);
        HashMap<String, BidResult> companyResultMap = new HashMap<String, BidResult>();
        ArrayList<BidResult> list = new ArrayList<BidResult>();
        if (bidResults == null) {
            bidResults = new ArrayList<BidResult>();
        } else {
            for (BidResult result : bidResults) {
                if (companyResultMap.containsKey(result.getCompanyId())) {
                    BidResult oResult = companyResultMap.get(result.getCompanyId());
                    oResult.setMultiBiddingPrice(oResult.getMultiBiddingPrice() + "," + result.getBiddingId() + "-" + result.getFinalPrice());
                } else {
                    companyResultMap.put(result.getCompanyId(), result);
                    result.setMultiBiddingPrice(result.getBiddingId() + "-" + result.getFinalPrice());
                    list.add(result);
                }
            }
        }
        model.addAttribute("bidResults", list);
        return "result/result_list";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/export")
    public void export(String companyId, String type, Model model, HttpServletResponse response) throws Exception {
        BidResult result = new BidResult();
        result.setCompanyId(companyId);
        String title = "执行计划——";
        if (StringUtils.isNotBlank(type)) {
            if ("2".equals(type)) {
                type = "2";
                result.setFinalPrice(new BigDecimal(1));
                title += "中标记录";
            } else {
                type = "1";
                result.setPrePrice(new BigDecimal(1));
                title += "投标记录";
            }
        } else {
            result.setPrePrice(new BigDecimal(1));
            type = "1";
            title += "投标记录";
        }
        List<BidResult> list = bidResultService.getCompanyBidResult(result, 1, Integer.MAX_VALUE);//获取记录

        HashMap map = new HashMap();
        map.put("result", list);
        map.put("type", type);

        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename="
                + URLEncoder.encode(title + ".xls", "UTF-8"));
        OutputStream os = response.getOutputStream();
        Context context = new Context();
        org.apache.poi.ss.usermodel.Workbook wb = context.output(this.getClass().getResourceAsStream("/templateResult.xls"), map);
        wb.write(os);
        os.flush();
        os.close();

    }

    /**
     * 汇总数据处理
     *
     * @return
     */
    public List dispose(List<BidResult> list, List listCompanyName, List listGroups, String type) {
        List listResult = new ArrayList();
        Map map = new HashMap();
        Map mapg = null;
        List lg = new ArrayList();
        List lc = new ArrayList();
        int g = 0, c = 0, cl = 0, gl = 0, wcl = 0, wgl = 0;
        for (int i = 0; i < list.size(); i++) {
            if (i == 0) {
                lc.add(list.get(i));
                c = 1;
                map.put("listCompanyName", lc);
                map.put("cc", c);
            } else {
                if (list.get(i).getCompany().getGroups() == null) {
                    if (list.get(i).getCompany().getGroups() == null && list.get(i - 1).getCompany().getGroups() == null) {//没有集团
                        //同一集团下
                        if (list.get(i).getCompany().getCompanyName() != null && list.get(i).getCompany().getCompanyName().equals(list.get(i - 1).getCompany().getCompanyName())) {
                            //同一单位下
                            lc.add(list.get(i));
                            c += 1;
                            map.put("cc", c);
                        } else {
                            c += 1;//多一行统计
                            g += c;
                            if (((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() > 0)
                                wgl += ((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() + 1;//applyNums统计显示中标时候的集团中合并的行数
                            map.put("cl", listCompanyName.get(cl++));
                            map.put("companyName", list.get(i - 1));
                            lg.add(map);

                            map = new HashMap(); //为第下一个单位创建集合
                            lc = new ArrayList();
                            lc.add(list.get(i));
                            c = 1;
                            map.put("listCompanyName", lc);
                            map.put("cc", c);
                        }
                    } else {
                        c += 1;//多一行统计
                        g += c;
                        if (((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() > 0)
                            wgl += ((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() + 1;//applyNums统计显示中标时候的集团中合并的行数
                        map.put("cl", listCompanyName.get(cl++));
                        map.put("companyName", list.get(i - 1));
                        lg.add(map);
                        mapg = new HashMap();
                        mapg.put("listGroups", lg);
                        mapg.put("gl", listGroups.get(gl++));
                        mapg.put("gc", g);
                        mapg.put("wgl", wgl);
                        mapg.put("groupName", ((List<BidResult>) ((Map) lg.get(0)).get("listCompanyName")).get(0).getCompany().getGroups());
                        if (mapg != null) {
                            listResult.add(mapg);//将集团
                        }
                        g = 0;
                        wgl = 0;
                        lg = new ArrayList();
                        lc = new ArrayList();
                        lc.add(list.get(i));
                        c = 1;
                        map = new HashMap();
                        map.put("listCompanyName", lc);
                        map.put("cc", c);

                    }
                } else if (list.get(i).getCompany().getGroups().equals(list.get(i - 1).getCompany().getGroups())) {
                    //同一集团下
                    if (list.get(i).getCompany().getCompanyName().equals(list.get(i - 1).getCompany().getCompanyName())) {
                        //同一单位下
                        lc.add(list.get(i));
                        c += 1;
                        map.put("cc", c);
                    } else {
                        c += 1;//多一行统计
                        g += c;
                        if (((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() > 0)
                            wgl += ((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() + 1;//applyNums统计显示中标时候的集团中合并的行数
                        map.put("cl", listCompanyName.get(cl++));
                        lg.add(map);
                        map = new HashMap(); //为第下一个单位创建集合
                        lc = new ArrayList();
                        lc.add(list.get(i));
                        c = 1;
                        map.put("listCompanyName", lc);
                        map.put("cc", c);
                    }
                } else {
                    c += 1;//多一行统计
                    g += c;
                    if (((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() > 0)
                        wgl += ((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() + 1;//applyNums统计显示中标时候的集团中合并的行数
                    map.put("cl", listCompanyName.get(cl++));
                    lg.add(map);
                    mapg = new HashMap();
                    mapg.put("listGroups", lg);
                    mapg.put("gl", listGroups.get(gl++));
                    mapg.put("gc", g);
                    mapg.put("wgl", wgl);
                    if (mapg != null) {
                        listResult.add(mapg);//将集团
                    }
                    g = 0;
                    wgl = 0;
                    lg = new ArrayList();
                    lc = new ArrayList();
                    lc.add(list.get(i));
                    c = 1;
                    map = new HashMap();
                    map.put("listCompanyName", lc);
                    map.put("cc", c);

                }
            }
        }
        c += 1;//多一行统计
        g += c;
        lg.add(map);
        if (((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() > 0)
            wgl += ((Map<String, BigDecimal>) listCompanyName.get(cl)).get("applyNums").intValue() + 1;//applyNums统计显示中标时候的集团中合并的行数

        map.put("cl", listCompanyName.get(cl));
        mapg = new HashMap();
        mapg.put("listGroups", lg);
        mapg.put("gl", listGroups.get(gl));
        mapg.put("gc", g);
        mapg.put("wgl", wgl);
        if (mapg != null) {
            listResult.add(mapg);//将集团
        }
        return listResult;
    }

    //导出数据
    @RequestMapping(method = RequestMethod.GET, value = "/exports")
    public void export(BidResult result, String type, Model model, HttpServletResponse response) throws Exception {
        if ("3".equals(type))
            result.setFinalPrice(BigDecimal.valueOf(0.0001));
        List<BidResult> list = bidResultService.selectByGroupC(result);
        if (StringUtils.isBlank(type))
            type = "1";
        //共计
        List listAll = bidResultService.countAll(result);
        //单位统计
        List listCompanyName = bidResultService.countGroup(result);
        //根据集团统计
        List listGroups = bidResultService.countGroups(result);
        //将数据整理成页面显示的结果集
        List listResult = new ArrayList();
        if (list.size() > 0)
            listResult = dispose(list, listCompanyName, listGroups, type);
        String title = "";
        if ("".equals(result.getCompany()) || result.getCompany() == null) {//导出全部
            if ("1".equals(type)) {
                title = "全部投中标情况汇总";
            } else if ("2".equals(type)) {
                title = "全部投标情况汇总";
            } else if ("3".equals(type)) {
                title = "全部中标情况汇总";
            }
        } else {//根据条件导出数据
            if ("1".equals(type)) {
                title = "统计汇总表";
            } else if ("2".equals(type)) {
                title = "投标情况汇总表";
            } else if ("3".equals(type)) {
                title = "中标情况汇总表";
            }
        }
        //if()
        HashMap map = new HashMap();
        map.put("result", listResult);
        map.put("listAll", listAll);
        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename="
                + URLEncoder.encode(title + ".xls", "UTF-8"));
        OutputStream os = response.getOutputStream();
        Context context = new Context();
        org.apache.poi.ss.usermodel.Workbook wb = null;
        HSSFSheet sheet = null;//org.apache.poi.hssf.usermodel.HSSFSheet
        int g = 2, c = 2;//标记合并开始位置
        if ("1".equals(type)) {//投中标汇总模板
            wb = context.output(this.getClass().getResourceAsStream("/templateTW.xls"), map);
            sheet = (HSSFSheet) wb.getSheetAt(0);
            for (int i = 0; i < listResult.size(); i++) {//遍历集团组
                System.out.println(String.valueOf(((Map) listResult.get(i)).get("gc")));
                sheet.addMergedRegion(new Region(g, (short) 0, g + Integer.valueOf(String.valueOf(((Map) listResult.get(i)).get("gc"))) - 2, (short) 0));
                c = g;

                for (int j = 0; j < ((List) ((Map) listResult.get(i)).get("listGroups")).size(); j++) {//遍历单位组
                    sheet.addMergedRegion(new Region(c, (short) 1, c + Integer.valueOf(String.valueOf(((Map) ((List) ((Map) listResult.get(i)).get("listGroups")).get(j)).get("cc"))) - 1, (short) 1));
                    c += Integer.valueOf(String.valueOf(((Map) ((List) ((Map) listResult.get(i)).get("listGroups")).get(j)).get("cc"))) + 1;
                    /*for(int k=0;k<((List)((Map)((List)((Map)listResult.get(i)).get("listGroups")).get(j)).get("listCompanyName")).size();k++){//遍历每一条记录

        			}*/
                }
                g += Integer.valueOf(String.valueOf(((Map) listResult.get(i)).get("gc"))) + 1;//计算第i+1个集团合并的开始位置
            }
        }
        if ("2".equals(type)) {//投标汇总模板
            wb = context.output(this.getClass().getResourceAsStream("/templateTender.xls"), map);
            sheet = (HSSFSheet) wb.getSheetAt(0);
            for (int i = 0; i < listResult.size(); i++) {//遍历集团组
                System.out.println(String.valueOf(((Map) listResult.get(i)).get("gc")));
                sheet.addMergedRegion(new Region(g, (short) 0, g + Integer.valueOf(String.valueOf(((Map) listResult.get(i)).get("gc"))) - 2, (short) 0));
                c = g;

                for (int j = 0; j < ((List) ((Map) listResult.get(i)).get("listGroups")).size(); j++) {//遍历单位组
                    sheet.addMergedRegion(new Region(c, (short) 1, c + Integer.valueOf(String.valueOf(((Map) ((List) ((Map) listResult.get(i)).get("listGroups")).get(j)).get("cc"))) - 1, (short) 1));
                    c += Integer.valueOf(String.valueOf(((Map) ((List) ((Map) listResult.get(i)).get("listGroups")).get(j)).get("cc"))) + 1;
                    /*for(int k=0;k<((List)((Map)((List)((Map)listResult.get(i)).get("listGroups")).get(j)).get("listCompanyName")).size();k++){//遍历每一条记录

        			}*/
                }
                g += Integer.valueOf(String.valueOf(((Map) listResult.get(i)).get("gc"))) + 1;//计算第i+1个集团合并的开始位置
            }
        }
        if ("3".equals(type)) {//中标汇总模板
            wb = context.output(this.getClass().getResourceAsStream("/templateWinning.xls"), map);
            sheet = (HSSFSheet) wb.getSheetAt(0);
            for (int i = 0; i < listResult.size(); i++) {//遍历集团组
                System.out.println(String.valueOf(((Map) listResult.get(i)).get("gc")));
                sheet.addMergedRegion(new Region(g, (short) 0, g + Integer.valueOf(String.valueOf(((Map) listResult.get(i)).get("gc"))) - 1, (short) 0));
                c = g;

                for (int j = 0; j < ((List) ((Map) listResult.get(i)).get("listGroups")).size(); j++) {//遍历单位组
                    sheet.addMergedRegion(new Region(c, (short) 1, c + Integer.valueOf(String.valueOf(((Map) ((List) ((Map) listResult.get(i)).get("listGroups")).get(j)).get("cc"))), (short) 1));
                    c += Integer.valueOf(String.valueOf(((Map) ((List) ((Map) listResult.get(i)).get("listGroups")).get(j)).get("cc"))) + 1;
        			/*for(int k=0;k<((List)((Map)((List)((Map)listResult.get(i)).get("listGroups")).get(j)).get("listCompanyName")).size();k++){//遍历每一条记录
        				
        			}*/
                }
                g += Integer.valueOf(String.valueOf(((Map) listResult.get(i)).get("gc"))) + 1;//计算第i+1个集团合并的开始位置
            }
        }

        wb.write(os);
        os.flush();
        os.close();

    }
}
