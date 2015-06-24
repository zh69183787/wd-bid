package com.wonders.stpt.bid.service.impl;

import java.util.Date;
import java.util.List;

import com.wonders.stpt.bid.domain.BidResult;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wonders.stpt.bid.dao.BidCompanyDao;
import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.service.IBidCompanyService;

/**
 * Created by Administrator on 2014/7/11.
 */
@Service
public class BidCompanyServiceImpl implements IBidCompanyService {
    @Autowired
    private BidCompanyDao companyDao;

    @Override
    public List<BidCompany> getCompanies(BidCompany company, int pageIndex, int pageSize) throws Exception {
        return companyDao.select(company,  pageIndex,  pageSize);
    }

	@Override
	public BidCompany getBidCompany(String bidCompanyId) throws Exception {
		// TODO Auto-generated method stub
		return companyDao.selectById(bidCompanyId);
	}

	@Override
	public int delete(String bidCompanyId) throws Exception {
		// TODO Auto-generated method stub
		return companyDao.delete(bidCompanyId);
	}



	@Override
	public BidCompany save(BidCompany bidCompany) throws Exception {
		// TODO Auto-generated method stub
		if(StringUtils.isBlank(bidCompany.getCompanyId())){
			companyDao.insert(bidCompany);
		}else{
			companyDao.update(bidCompany);
		}
		return bidCompany;
	}

//    @Override
//    public List<String> getGroups() {
//        return companyDao.selectGroups();
//    }

}
