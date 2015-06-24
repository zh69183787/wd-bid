package com.wonders.stpt.bid.dao;

import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2014/9/24.
 */
public interface ReportDao {

    List<Map> countRouteId(@Param("p")Map parameter);
    List<Map> countRouteByType(@Param("p")Map parameter);

    List<Map> countAllRoute(@Param("p")Map parameter);

    List<Map> countRouteBiddingNum(@Param("type")String type);

    List<Map>  countBidByGroupsOrName(@Param("p")Map parabmeter, @Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize);
//    List<Map>  countBidByType(@Param("p")Map parameter);
    List<Map> countOpenBidNumList(@Param("type") String type, @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);
    List<Map> countBidNumByType(@Param("type") String type, @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

   Integer countOpenBidNum(@Param("type") String type, @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);
    List<Map> countBidNumByBiddingType(@Param("p")Map parameter);
    List<Map> selectBidPlan(@Param("beginDate")Date beginDate,@Param("endDate")Date endDate);



}
