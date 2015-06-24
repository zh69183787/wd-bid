package com.wonders.stpt.bid.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.wonders.stpt.bid.dao.BiddingDao;
import com.wonders.stpt.bid.domain.Bidding;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wonders.stpt.bid.dao.BidChangeDao;
import com.wonders.stpt.bid.domain.BidChange;
import com.wonders.stpt.bid.service.IBidChangeService;

@Service
public class BidChangeServiceImpl implements IBidChangeService {
    @Autowired
    private BidChangeDao bidChangeDao;
    @Autowired
    private BiddingDao biddingDao;

    @Override
    public List<BidChange> getBidChanges(BidChange bidChange, int pageIndex,
                                         int pageSize) throws Exception {
        List<BidChange> changes = bidChangeDao.select(bidChange, pageIndex, pageSize);
        setBiddingRelations(changes);
        return changes;
    }

    private void setBiddingRelations(List<BidChange> changes){
        StringBuffer strBiddingIdList = new StringBuffer();
        for (BidChange change : changes) {
            if (StringUtils.isNotBlank(change.getBiddingIdList()))
                strBiddingIdList.append(change.getBiddingIdList()).append(",");
        }
        String[] biddingIdList = strBiddingIdList.toString().split(",");
        if (biddingIdList != null && biddingIdList.length > 0) {

            List<Bidding> biddings = biddingDao.selectByBiddingIds(biddingIdList);
            for (BidChange change : changes) {
                for (Bidding bidding : biddings) {
                    if(change.getBiddingIdList()!=null&&change.getBiddingIdList().indexOf(bidding.getBiddingId()) > -1){

                        change.getBiddingRelations().add(bidding);
                    }

                }
            }

        }
    }

    @Override
    public BidChange getBidChange(String bidChangeId) throws Exception {
        BidChange change = bidChangeDao.selectById(bidChangeId);
        ArrayList changes = new ArrayList();
        changes.add(change);
        setBiddingRelations(changes);
        return change;
    }

    @Override
    public int delete(String bidChangeId) throws Exception {

        return bidChangeDao.delete(bidChangeId);
    }

    @Override
    public BidChange save(BidChange bidChange) throws Exception {
        if (StringUtils.isBlank(bidChange.getBidChangeId()))
            bidChangeDao.insert(bidChange);
        else
            bidChangeDao.update(bidChange);
        return bidChange;
    }

    @Override
    public List<BidChange> getList() throws Exception {
        return bidChangeDao.selectAll();
    }

}
