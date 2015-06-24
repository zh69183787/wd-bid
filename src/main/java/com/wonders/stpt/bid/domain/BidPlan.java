package com.wonders.stpt.bid.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2014/7/8.投标计划
 */
public class BidPlan {

    public BidPlan() {
        removed = "0";
    }

    /**
     * 投标计划主键
     */
    private String biddingPlanId;
    /**
     * 上网报名日期
     */
    private Date applyDate;
    /**
     * 发标开始
     */
    private Date bidBegin;
    /**
     * 发标截至
     */
    private Date bidEnd;
    /**
     * 技术开标
     */
    private Date tecOpenDate;

    private Date beginOpenDate;

    private Date endOpenDate;


    private Date beginApplyDate;

    private Date endApplyDate;

    private Date beginBidBeginDate;

    private Date endBidBeginDate;


    private Date beginCheckDate;

    private Date endCheckDate;


    private Date beginBizDate;

    private Date endBizDate;


    private Date beginBidEndDate;

    private Date endBidEndDate;

    private Date beginTecAppraiseDate;
    private Date endTecAppraiseDate;

    /**
     * 资格预审
     */
    private Date checkDate;
    /**
     * 商务评标
     */
    private Date bizAppraiseDate;
    /**
     * 技术评标
     */
    private Date tecAppraiseDate;
    /**
     * 商务开标
     */
    private Date bizOpenDate;
    /**
     * 限价
     */
    private BigDecimal limitPrice;
    /**
     * 标段主键
     */
    private String biddingId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 更新时间
     */
    private Date updateTime;
    /**
     * 删除
     */
    private String removed;


    private String creator;

    private String updater;


    private String hasLimit;
    private String hasCheck;

    private Bidding bidding;
    private String routeName;
    private String biddingName;
    private String bidType;
    private String biddingTypeId;
    private String biddingType;
    private List<BidResult> bidResultList;

    private List<Bidding> biddingList;
    private String hasBidded;

    public String getHasBidded() {
        return hasBidded;
    }

    public void setHasBidded(String hasBidded) {
        this.hasBidded = hasBidded;
    }

    public Date getBeginTecAppraiseDate() {
        return beginTecAppraiseDate;
    }

    public void setBeginTecAppraiseDate(Date beginTecAppraiseDate) {
        this.beginTecAppraiseDate = beginTecAppraiseDate;
    }

    public Date getEndTecAppraiseDate() {
        return endTecAppraiseDate;
    }

    public void setEndTecAppraiseDate(Date endTecAppraiseDate) {
        this.endTecAppraiseDate = endTecAppraiseDate;
    }

    public String getBiddingTypeId() {
        return biddingTypeId;
    }

    public String getBiddingType() {
        return biddingType;
    }

    public void setBiddingType(String biddingType) {
        this.biddingType = biddingType;
    }

    public void setBiddingTypeId(String biddingTypeId) {
        this.biddingTypeId = biddingTypeId;
    }

    public String getBidType() {
        return bidType;
    }

    public void setBidType(String bidType) {
        this.bidType = bidType;
    }

    public String getRouteName() {
        return routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public String getBiddingName() {
        return biddingName;
    }

    public void setBiddingName(String biddingName) {
        this.biddingName = biddingName;
    }

    public List<Bidding> getBiddingList() {
        if (biddingList == null)
            biddingList = new ArrayList<Bidding>();
        return biddingList;
    }

    public void setBiddingList(List<Bidding> biddingList) {
        this.biddingList = biddingList;
    }

    public String getHasCheck() {
        return hasCheck;
    }

    public void setHasCheck(String hasCheck) {
        this.hasCheck = hasCheck;
    }

    public String getHasLimit() {
        return hasLimit;
    }

    public void setHasLimit(String hasLimit) {
        this.hasLimit = hasLimit;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getUpdater() {
        return updater;
    }

    public void setUpdater(String updater) {
        this.updater = updater;
    }

    public List<BidResult> getBidResultList() {
        return bidResultList;
    }

    public void setBidResultList(List<BidResult> bidResultList) {
        this.bidResultList = bidResultList;
    }

    public String getBiddingPlanId() {
        return biddingPlanId;
    }

    public void setBiddingPlanId(String biddingPlanId) {
        this.biddingPlanId = biddingPlanId;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public Date getBidBegin() {
        return bidBegin;
    }

    public void setBidBegin(Date bidBegin) {
        this.bidBegin = bidBegin;
    }

    public Date getBidEnd() {
        return bidEnd;
    }

    public void setBidEnd(Date bidEnd) {
        this.bidEnd = bidEnd;
    }

    public Date getTecOpenDate() {
        return tecOpenDate;
    }

    public void setTecOpenDate(Date tecOpenDate) {
        this.tecOpenDate = tecOpenDate;
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public Date getBizAppraiseDate() {
        return bizAppraiseDate;
    }

    public void setBizAppraiseDate(Date bizAppraiseDate) {
        this.bizAppraiseDate = bizAppraiseDate;
    }

    public Date getTecAppraiseDate() {
        return tecAppraiseDate;
    }

    public void setTecAppraiseDate(Date tecAppraiseDate) {
        this.tecAppraiseDate = tecAppraiseDate;
    }

    public Date getBizOpenDate() {
        return bizOpenDate;
    }

    public void setBizOpenDate(Date bizOpenDate) {
        this.bizOpenDate = bizOpenDate;
    }

    public BigDecimal getLimitPrice() {
        return limitPrice;
    }

    public void setLimitPrice(BigDecimal limitPrice) {
        this.limitPrice = limitPrice;
    }

    public String getBiddingId() {
        return biddingId;
    }

    public void setBiddingId(String biddingId) {
        this.biddingId = biddingId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getRemoved() {
        return removed;
    }

    public void setRemoved(String removed) {
        this.removed = removed;
    }

    public Bidding getBidding() {
        return bidding;
    }

    public void setBidding(Bidding bidding) {
        this.bidding = bidding;
    }

    public Date getBeginOpenDate() {
        return beginOpenDate;
    }

    public void setBeginOpenDate(Date beginOpenDate) {
        this.beginOpenDate = beginOpenDate;
    }

    public Date getEndOpenDate() {
        return endOpenDate;
    }

    public void setEndOpenDate(Date endOpenDate) {
        this.endOpenDate = endOpenDate;
    }

    public Date getBeginApplyDate() {
        return beginApplyDate;
    }

    public void setBeginApplyDate(Date beginApplyDate) {
        this.beginApplyDate = beginApplyDate;
    }

    public Date getEndApplyDate() {
        return endApplyDate;
    }

    public void setEndApplyDate(Date endApplyDate) {
        this.endApplyDate = endApplyDate;
    }

    public Date getBeginBidBeginDate() {
        return beginBidBeginDate;
    }

    public void setBeginBidBeginDate(Date beginBidBeginDate) {
        this.beginBidBeginDate = beginBidBeginDate;
    }

    public Date getEndBidBeginDate() {
        return endBidBeginDate;
    }

    public void setEndBidBeginDate(Date endBidBeginDate) {
        this.endBidBeginDate = endBidBeginDate;
    }

    public Date getBeginCheckDate() {
        return beginCheckDate;
    }

    public void setBeginCheckDate(Date beginCheckDate) {
        this.beginCheckDate = beginCheckDate;
    }

    public Date getEndCheckDate() {
        return endCheckDate;
    }

    public void setEndCheckDate(Date endCheckDate) {
        this.endCheckDate = endCheckDate;
    }

    public Date getBeginBizDate() {
        return beginBizDate;
    }

    public void setBeginBizDate(Date beginBizDate) {
        this.beginBizDate = beginBizDate;
    }

    public Date getEndBizDate() {
        return endBizDate;
    }

    public void setEndBizDate(Date endBizDate) {
        this.endBizDate = endBizDate;
    }

    public Date getBeginBidEndDate() {
        return beginBidEndDate;
    }

    public void setBeginBidEndDate(Date beginBidEndDate) {
        this.beginBidEndDate = beginBidEndDate;
    }

    public Date getEndBidEndDate() {
        return endBidEndDate;
    }

    public void setEndBidEndDate(Date endBidEndDate) {
        this.endBidEndDate = endBidEndDate;
    }
}
