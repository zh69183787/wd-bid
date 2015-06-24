package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.ReportDao;
import com.wonders.stpt.bid.service.IReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Administrator on 2014/9/24.
 */
@Service
public class ReportServiceImpl implements IReportService {

    protected static final String BIDDING_TYPE = "bidding";
    protected static final String GROUPS_TYPE = "groups";

    protected static final String COMPANY_TYPE = "company";

    @Autowired
    private ReportDao reportDao;


    @Override
    public List<Map> getBidPlanReport(Date beginBizDate, Date endBizDate) throws Exception {

        return reportDao.selectBidPlan(beginBizDate, endBizDate);
    }

    @Override
    public List<Map> getARouteReport(Date beginOpenDate, Date endOpenDate, Date beginBizDate, Date endBizDate, String isCheck, String hasLimit, String routeId) throws Exception {

        HashMap parameter = new HashMap();
        parameter.put("beginOpenDate", beginOpenDate);
        parameter.put("endOpenDate", endOpenDate);
        parameter.put("endBizDate", endBizDate);
        parameter.put("beginBizDate", beginBizDate);
        parameter.put("isCheck", isCheck);
        parameter.put("hasLimit", hasLimit);
        parameter.put("routeId", routeId);
        List<Map> result =  reportDao.countRouteId(parameter);
        if (!result.isEmpty()) {
            Map total = result.get(result.size() - 1);
            total.put("zPercent",100);
            for (Map map : result) {

                if (!"total".equals(map.get("routeName"))) {
                    map.put("zPercent", ((BigDecimal) map.get("price")).divide((BigDecimal) total.get("price"), 4, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)));
                }
            }
        }
        return result;
    }

    @Override
    public Integer getOpenBidNum(String type, Date beginDate, Date endDate) throws Exception {

        return reportDao.countOpenBidNum(getCountField(type), beginDate, endDate);
    }

    @Override
    public List<Map> getAllRouteReport(Date beginOpenDate, Date endOpenDate, String isCheck, String hasLimit, String routeId) throws Exception {

        HashMap parameter = new HashMap();
        parameter.put("beginOpenDate", beginOpenDate);
        parameter.put("endOpenDate", endOpenDate);
        parameter.put("isCheck", isCheck);
        parameter.put("hasLimit", hasLimit);
        parameter.put("routeId", routeId);
        List<Map> result = reportDao.countAllRoute(parameter);
        if (!result.isEmpty()) {
            Map total = result.get(result.size() - 1);
            total.put("zPercent",100);
            for (Map map : result) {

                if (!"total".equals(map.get("name"))) {
                    map.put("zPercent", ((BigDecimal) map.get("price")).divide((BigDecimal) total.get("price"), 4, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)));
                }
            }
        }
        return result;
    }

    @Override
    public List<Map> getAllRouteReportType(Date beginOpenDate, Date endOpenDate, String isCheck, String hasLimit, String routeId) throws Exception {
        HashMap parameter = new HashMap();
        parameter.put("beginOpenDate", beginOpenDate);
        parameter.put("endOpenDate", endOpenDate);
        parameter.put("isCheck", isCheck);
        parameter.put("hasLimit", hasLimit);
        parameter.put("routeId", routeId);
        List<Map> result = reportDao.countRouteByType(parameter);
        if (!result.isEmpty()) {
            Map total = result.get(result.size() - 1);
            total.put("zPercent",100);
            for (Map map : result) {

                if (!"total".equals(map.get("name"))) {
                    map.put("zPercent", ((BigDecimal) map.get("price")).divide((BigDecimal) total.get("price"), 4, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)));
                }
            }
        }
        return result;

    }

    @Override
    public List<Map> getBidPeReport(Date beginOpenDate, Date endOpenDate, String routeId, String type, String biddingTypeId, int pageIndex, int pageSize) throws Exception {
        HashMap parameter = new HashMap();
        parameter.put("beginOpenDate", beginOpenDate);
        parameter.put("endOpenDate", endOpenDate);
        parameter.put("routeId", routeId);
        parameter.put("biddingTypeId", biddingTypeId);
//        if(BIDDING_TYPE.equals(type)){
//            return reportDao.countBidByType(parameter);
//        }else{
        parameter.put("type", type);
        return reportDao.countBidByGroupsOrName(parameter, pageIndex, pageSize);
//        }
    }

    @Override
    public Map getRouteBiddingNum(String type) throws Exception {
        List<Map> mapList = reportDao.countRouteBiddingNum(type);
        HashMap result = new HashMap();
        for (Map map : mapList) {
            result.put(map.get("RID"), ((BigDecimal) map.get("TOTAL")).intValue());
        }
        return result;
    }

    @Override
    public List<BigDecimal> getBidNumList(String type, Date beginDate, Date endDate) throws Exception {
        List<Map> list = reportDao.countBidNumByType(type, beginDate, endDate);

        ArrayList<BigDecimal> newList = new ArrayList<BigDecimal>();
        for (int i = 0; i < 5; i++) {
            newList.add(new BigDecimal(0));
        }

        for (Map map : list) {
            Integer index = Integer.parseInt((String) map.get("name"));
            BigDecimal num = (BigDecimal) map.get("biddingNum");
            newList.set(index - 1, num);
        }
        return newList;
    }

    @Override
    public List<Map> getOpenBidList(String type, Date beginDate, Date endDate) throws Exception {
        return reportDao.countOpenBidNumList(getCountField(type), beginDate, endDate);
    }


    private String getCountField(String type) {
        if ("0".equals(type)) {
            type = "APPLY_DATE";
        }
        if ("1".equals(type)) {
            type = "CHECK_DATE";
        }
        if ("2".equals(type)) {
            type = "BID_BEGIN";
        }
        if ("3".equals(type)) {
            type = "BID_END";
        }
        if ("4".equals(type)) {
            type = "TEC_OPEN_DATE";
        }
        if ("5".equals(type)) {
            type = "TEC_APPRAISE_DATE";
        }
        if ("6".equals(type)) {
            type = "BIZ_APPRAISE_DATE";
        }
        return type;
    }
}
