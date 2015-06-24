package com.wonders.stpt.bid.domain;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2014/7/8.投标结果
 */
public class BidResult {
	/**
	 * 投标结果主键
	 */
	private String bidResultId;
	/**
	 * 预审
	 */
	private BigDecimal prePrice;
	/**
	 * 结果
	 */
	private BigDecimal finalPrice;
	/**
	 * 投标单位主键
	 */
	private String companyId;
	
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
    /**
     * 投标计划主键
     */
    private String biddingPlanId;

    private String isApplicant;
    /**
     * 投资公司
     */
    private BidCompany company;

    private BidPlan bidPlan;

    private String creator;

    private String updater;

    private BigDecimal totalPrice;

    private String multiBiddingPrice;

    private String biddingId;

    public String getBiddingId() {
        return biddingId;
    }

    public void setBiddingId(String biddingId) {
        this.biddingId = biddingId;
    }

    public String getMultiBiddingPrice() {
        return multiBiddingPrice;
    }

    public void setMultiBiddingPrice(String multiBiddingPrice) {
        this.multiBiddingPrice = multiBiddingPrice;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
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

    public BidPlan getBidPlan() {
        return bidPlan;
    }

    public void setBidPlan(BidPlan bidPlan) {
        this.bidPlan = bidPlan;
    }

    public BidCompany getCompany() {
        return company;
    }

    public void setCompany(BidCompany company) {
        this.company = company;
    }

    public String getBidResultId() {
        return bidResultId;
    }

    public void setBidResultId(String bidResultId) {
        this.bidResultId = bidResultId;
    }

    public BigDecimal getPrePrice() {
        return prePrice;
    }

    public void setPrePrice(BigDecimal prePrice) {
        this.prePrice = prePrice;
    }

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
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

    public String getBiddingPlanId() {
        return biddingPlanId;
    }

    public void setBiddingPlanId(String biddingPlanId) {
        this.biddingPlanId = biddingPlanId;
    }

    public String getIsApplicant() {
        return isApplicant;
    }

    public void setIsApplicant(String isApplicant) {
        this.isApplicant = isApplicant;
    }
}
