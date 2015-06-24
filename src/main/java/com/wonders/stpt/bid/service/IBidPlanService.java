package com.wonders.stpt.bid.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.domain.BidPlan;


public interface IBidPlanService {

    List<BidPlan> getBidPlans(BidPlan bidPlan,int pageIndex,int pageSize)throws Exception;
	List<BidPlan> getBidPlans(BidPlan bidPlan,BidCompany company,int pageIndex,int pageSize)throws Exception;

	BidPlan getBidPlan(String bidPlanId)throws Exception;

    int delete(String bidPlanId)throws Exception;

    BidPlan save(BidPlan bidPlan)throws Exception;

    public List<Map<String,Object>> getDistributionPlan(BidPlan bidPlan)throws Exception;
//    List<BidPlan> getBidPlanReport(BidPlan bidPlan,String companyId,String groups, int pageIndex, int pageSize)throws Exception;

}
