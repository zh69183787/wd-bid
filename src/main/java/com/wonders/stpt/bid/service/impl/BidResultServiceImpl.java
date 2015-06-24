package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.BidResultDao;
import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.domain.BidResult;
import com.wonders.stpt.bid.service.IBidResultService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2014/7/11.
 */
@Service
public class BidResultServiceImpl implements IBidResultService {

    @Autowired
    private BidResultDao bidResultDao;

    @Override
    public List<BidResult> getBidResults(BidResult bidResult,String[] biddingPlanIds, int pageIndex, int pageSize) throws Exception {

        return bidResultDao.select(bidResult,biddingPlanIds, pageIndex,  pageSize);
    }

	@Override
	public BidResult getBidResult(String bidResultId) throws Exception {
		// TODO Auto-generated method stub
		return bidResultDao.selectById(bidResultId);
	}

	@Override
	public int delete(String bidResultId) throws Exception {
		// TODO Auto-generated method stub
		return bidResultDao.delete(bidResultId);
	}

	@Override
	public BidResult save(BidResult bidResult) throws Exception {
		// TODO Auto-generated method stub
		if(StringUtils.isBlank(bidResult.getBidResultId())){
            if("0".equals(bidResult.getRemoved()))
			bidResultDao.insert(bidResult);
		}else{
			bidResultDao.update(bidResult);
		}
		return bidResult;
	}

    @Override
    public List<Map> statisticalBidResult(BidResult bidResult, String[] biddingPlanIds) throws Exception{
        return  bidResultDao.countByPlanId(bidResult,biddingPlanIds);
    }

    @Override
    public List<BidResult> getCompanyBidResult(BidResult result, int i, int maxValue) {
        return bidResultDao.selectResults(result);
    }

	@Override
	public List<BidResult> selectByGroupC(BidResult result) {
		// TODO Auto-generated method stub
		return bidResultDao.selectByGroupC(result);
	}

	@Override
	public List<Map> countAll(BidResult result) {
		// TODO Auto-generated method stub
		return bidResultDao.countAll(result);
	}

	@Override
	public List<Map> countGroup(BidResult result) {
		// TODO Auto-generated method stub
		return bidResultDao.countGroup(result);
	}

	@Override
	public List<Map> countGroups(BidResult result) {
		// TODO Auto-generated method stub
		return bidResultDao.countGroups(result);
	}

}
