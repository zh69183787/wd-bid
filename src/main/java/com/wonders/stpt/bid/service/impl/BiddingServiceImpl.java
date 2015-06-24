package com.wonders.stpt.bid.service.impl;

import java.util.List;
import java.util.Map;

import javax.xml.ws.soap.Addressing;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.wonders.stpt.bid.dao.BiddingDao;
import com.wonders.stpt.bid.dao.DictionaryDao;
import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.service.IBiddingService;
@Service
public class BiddingServiceImpl implements IBiddingService {

	@Autowired
	private BiddingDao biddingDao;
	
	@Autowired
	private DictionaryDao dictionaryDao;

    @Override
    public void updateCompleteTime() throws Exception {
        biddingDao.updateCompleteTimeNull();
        biddingDao.updateCompleteTime();
    }

    @Override
    public Integer hasUsed(String biddingId) throws Exception {
        return biddingDao.countBiddingId(biddingId);
    }

    @Override
	public List<Bidding> getBiddings(Bidding bidding, int pageIndex,
			int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return biddingDao.select(bidding, pageIndex, pageSize);
	}

	@Override
	public Bidding getBidding(String BiddingId) throws Exception {
		// TODO Auto-generated method stub
		Bidding bidding = biddingDao.selectById(BiddingId);
		bidding.setDictBiddingType(dictionaryDao.selectByFullCodeAndDictType(bidding.getBiddingTypeId(), "bidTypes"));
		return bidding;
	}

	@Override
	public int delete(String biddingId) throws Exception {
		// TODO Auto-generated method stub
		return biddingDao.delete(biddingId);
	}

	@Override
	public Bidding save(Bidding bidding) throws Exception {
		// TODO Auto-generated method stub
		if(StringUtils.isBlank(bidding.getBiddingId())){//新增
			biddingDao.insert(bidding);
		}else{
			biddingDao.update(bidding);
		}
		return bidding;
	}

	@Override
	public List<Bidding> selectfuzzy(Bidding bidding) throws Exception {
		// TODO Auto-generated method stub
		return biddingDao.selectfuzzy(bidding);
	}


    @Override
    public List<Bidding> getBiddings(String[] biddingIdList) {
        return biddingDao.selectByBiddingIds(biddingIdList);
    }

	@Override
	public List<Bidding> getBiddingWithoutSelf(Bidding bidding, int pageIndex,
			int pageSize) {
		return biddingDao.selectIdNameWithoutSelf(bidding, pageIndex, pageSize);
	}

	@Override
	public List<Bidding> selectByMainIdIsDels(Bidding bidding,String mainId, int pageIndex,
			int pageSize) {
		// TODO Auto-generated method stub
		return biddingDao.selectByMainIdIsDels(bidding, mainId,  pageIndex, pageSize);
	}

	@Override
	public List<Map<String, Object>> countForSeason(String year)
			throws Exception {
		// TODO Auto-generated method stub
		return biddingDao.countForSeason(year);
	}

	@Override
	public List<Map<String, Object>> countForRoute(String year)
			throws Exception {
		// TODO Auto-generated method stub
		return biddingDao.countForRoute(year);
	}
	
	


}
