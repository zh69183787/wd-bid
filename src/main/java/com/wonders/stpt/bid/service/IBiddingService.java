package com.wonders.stpt.bid.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.domain.Bidding;

public interface IBiddingService {

    void updateCompleteTime()throws Exception;

    Integer hasUsed(String biddingId)throws Exception;

	List<Bidding> getBiddings(Bidding bidding,int pageIndex,int pageSize)throws Exception;

    Bidding getBidding(String BiddingId)throws Exception;

    int delete(String biddingId)throws Exception;

    Bidding save(Bidding bidding)throws Exception;
    /**
     * 模糊查询
     * @param bidding
     * @return
     * @throws Exception
     */
    List<Bidding> selectfuzzy(Bidding bidding)throws Exception;

    List<Bidding> getBiddings(String[] biddingIdList);

	List<Bidding> getBiddingWithoutSelf(Bidding bidding, int pageIndex,
			int pageSize);

	List<Bidding> selectByMainIdIsDels(Bidding bidding,String mainId, int pageIndex,
			int pageSize);
	
	
	 /**
     * 根据年份查询统计报表
     * @param year
     * @return
     * @throws Exception
     */
    List<Map<String,Object>>  countForSeason(String year)throws Exception;
    
    /**
     * 根据线路查询统计报表
     * @param year
     * @return
     * @throws Exception
     */
    List<Map<String,Object>>  countForRoute(String year)throws Exception;
}
