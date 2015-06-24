package com.wonders.stpt.bid.service;

import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.domain.BidResult;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2014/7/11.
 */
public interface IBidCompanyService {
    List<BidCompany> getCompanies(BidCompany company,int pageIndex,int pageSize)throws Exception;

    BidCompany getBidCompany(String bidCompanyId)throws Exception;

    int delete(String bidCompanyId)throws Exception;

    BidCompany save(BidCompany bidCompany)throws Exception;

//    List<String> getGroups();

}
