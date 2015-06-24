package com.wonders.stpt.bid.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2014/9/24.
 */
public interface IReportService {
    List<Map> getARouteReport(Date beginOpenDate,Date endOpenDate,Date beginBizDate,Date endBizDate,String isCheck,String hasLimit,String routeId) throws Exception;
//    List getBiddingByBiddingTypeReport(Date beginOpenDate,Date endOpenDate,Date beginBizDate,Date endBizDate,String isCheck,String hasLimit,String routeId) throws Exception;

    List<Map> getAllRouteReport(Date beginOpenDate,Date endOpenDate,String isCheck,String hasLimit, String routeId) throws Exception;

    List<Map> getAllRouteReportType(Date beginOpenDate,Date endOpenDate,String isCheck,String hasLimit, String routeId) throws Exception;

    List<Map> getBidPeReport(Date beginOpenDate,Date endOpenDate,String routeId,String type,String biddingTypeId,int pageIndex,int pageSize) throws Exception;

    Map getRouteBiddingNum(String routeId) throws Exception;

    List<BigDecimal> getBidNumList(String type, Date beginDate, Date endDate) throws Exception;


    List<Map> getOpenBidList(String type, Date beginDate, Date endDate) throws Exception;

    List<Map> getBidPlanReport( Date beginBizDate,Date endBizDate) throws Exception;

    Integer getOpenBidNum(String type, Date beginDate, Date endDate) throws Exception;
}
