package com.wonders.stpt.bid.service;

import java.util.List;

import com.wonders.stpt.bid.domain.BidChange;


public interface IBidChangeService {
	List<BidChange> getBidChanges(BidChange bidChange,int pageIndex,int pageSize)throws Exception;

	BidChange getBidChange(String bidChangeId)throws Exception;

    int delete(String bidChangeId)throws Exception;

    BidChange save(BidChange bidChange)throws Exception;
    
    List<BidChange> getList()throws Exception;
}
