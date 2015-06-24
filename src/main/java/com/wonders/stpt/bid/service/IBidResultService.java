package com.wonders.stpt.bid.service;

import com.wonders.stpt.bid.domain.BidResult;
import com.wonders.stpt.bid.domain.Route;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2014/7/11.
 */
public interface IBidResultService {
    List<BidResult> getBidResults(BidResult bidResult,String[] biddingPlanIds,int pageIndex,int pageSize)throws Exception;
    
    BidResult getBidResult(String bidResultId)throws Exception;

    int delete(String bidResultId)throws Exception;

    BidResult save(BidResult bidResult)throws Exception;

    List<Map> statisticalBidResult(BidResult bidResult,String[] biddingPlanIds)throws Exception;

    List<BidResult> getCompanyBidResult(BidResult result, int page, int pageSize);
    
    /**
     * 分组查询
     * @return
     */
    public List<BidResult> selectByGroupC(BidResult result);
    
    /**
     * 统计总数
     * @return
     */
    public List<Map> countAll(BidResult result);
    /**
     * 分组统计
     * @param type
     * @return
     */
    public List<Map> countGroup(BidResult result);
    /**
     * 分组统计（groups）
     * @return
     */
    public List<Map> countGroups(BidResult result);
}
