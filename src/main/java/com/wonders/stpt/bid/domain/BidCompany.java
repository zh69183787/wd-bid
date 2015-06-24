package com.wonders.stpt.bid.domain;

import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2014/7/8.投标单位
 */
public class BidCompany {
	/**
	 * 投标单位主键
	 */
	private String companyId;
	/**
	 * 投标单位名称
	 */
	private String companyName;
	/**
	 * 所属集团
	 */
	private String groups;
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
    private String trade;
    private List<BidResult> bidResultList;
    private String creator;

    private String updater;

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
    public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getGroups() {
		return groups;
	}
	public void setGroups(String groups) {
		this.groups = groups;
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

    public String getTrade() {
        return trade;
    }

    public void setTrade(String trade) {
        this.trade = trade;
    }
}
