package com.wonders.stpt.bid.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wonders.stpt.bid.dao.BidCompanyDao;
import com.wonders.stpt.bid.dao.BiddingDao;
import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.domain.BidResult;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.service.IBiddingService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wonders.stpt.bid.dao.BidPlanDao;
import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.service.IBidPlanService;

@Service
public class BidPlanServiceImpl implements IBidPlanService {

    @Autowired
    private BidPlanDao bidPlanDao;

    @Autowired
    private IBiddingService biddingService;


    @Override
    public List<BidPlan> getBidPlans(BidPlan bidPlan, int pageIndex, int pageSize) throws Exception {
        return bidPlanDao.selectPlan(bidPlan, pageIndex, pageSize);
    }

    @Override
    public List<BidPlan> getBidPlans(BidPlan bidPlan,BidCompany company,int pageIndex,
                                     int pageSize) throws Exception {
        // TODO Auto-generated method stub
        return bidPlanDao.select(bidPlan,company, pageIndex, pageSize);
    }

    @Override
    public BidPlan getBidPlan(String bidPlanId) throws Exception {
        // TODO Auto-generated method stub
        return bidPlanDao.selectById(bidPlanId);
    }

    @Override
    public int delete(String bidPlanId) throws Exception {
        // TODO Auto-generated method stub
        return bidPlanDao.delete(bidPlanId);
    }


    @Override
    public BidPlan save(BidPlan bidPlan) throws Exception {
        // TODO Auto-generated method stub
        if (StringUtils.isBlank(bidPlan.getBiddingPlanId())) {//没有主键为新增
            bidPlanDao.insert(bidPlan);
        } else {
            bidPlanDao.update(bidPlan);
            bidPlanDao.deleteRelation(bidPlan.getBiddingPlanId());
        }
        for (Bidding bidding : bidPlan.getBiddingList()) {
            bidPlanDao.insertRelation(bidPlan.getBiddingPlanId(),bidding.getBiddingId());
        }
        if("1".equals(bidPlan.getBidType())&&bidPlan.getBiddingList().size()>0)//单线
        {
            Bidding bidding = biddingService.getBidding(bidPlan.getBiddingList().get(0).getBiddingId());
            bidding.setBiddingType(bidPlan.getBiddingType());
            bidding.setBiddingTypeId(bidPlan.getBiddingTypeId());
            biddingService.save(bidding);
        }

        return bidPlan;
    }

	@Override
	public List<Map<String, Object>> getDistributionPlan(BidPlan bidPlan)
			throws Exception {
		// TODO Auto-generated method stub
		return bidPlanDao.getDistributionPlan(bidPlan);
	}

//	@Override
//	public List<BidPlan> getBidPlanss(BidPlan bidPlan, int pageIndex,
//			int pageSize) throws Exception {
//		// TODO Auto-generated method stub
//		return bidPlanDao.selects(bidPlan, pageIndex, pageSize);
//	}


}
