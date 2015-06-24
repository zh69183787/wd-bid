package com.wonders.stpt.bid.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/1/28.
 */
public class BidChange {
	private String bidChangeId;
	private String version;
	private String type;
	private String content;
	private Date createTime;
	private Date updateTime;
	private String removed;
	private String creator;
	private String updater;
	private String biddingIdList;
	private Bidding bidding;

    private List<Bidding> biddingRelations;

    public List<Bidding> getBiddingRelations() {
        if(biddingRelations ==null)
            biddingRelations = new ArrayList<Bidding>();
        return biddingRelations;
    }

    public void setBiddingRelations(List<Bidding> biddingRelations) {
        this.biddingRelations = biddingRelations;
    }

    public Bidding getBidding() {
		return bidding;
	}
	public void setBidding(Bidding bidding) {
		this.bidding = bidding;
	}
	
	public String getBidChangeId() {
		return bidChangeId;
	}
	public void setBidChangeId(String bidChangeId) {
		this.bidChangeId = bidChangeId;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getBiddingIdList() {
		return biddingIdList;
	}
	public void setBiddingIdList(String biddingIdList) {
		this.biddingIdList = biddingIdList;
	}
	
	
}
