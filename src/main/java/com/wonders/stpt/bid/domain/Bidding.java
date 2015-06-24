package com.wonders.stpt.bid.domain;

import java.util.Date;

/**
 * Created by Administrator on 2014/7/8.标段
 */
public class Bidding {

    public static final String NORMAL_STATE ="1";
    public static final String CANCEL_STATE="2";

	/**
	 * 标段主键
	 */
	private String biddingId;
	/**
	 * 标段名称
	 */
	private String biddingName;
	/**
	 * 类型名 
	 */
	private String biddingType;
	/**
	 * 标段类型
	 */
	private String biddingTypeId;
	
	private Dictionary dictBiddingType;
	
	
	/**
	 * 线路主键
	 */
	private String routeId;
	/**
	 * 线路实体
	 */
	private Route route;
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

    private String bidType;
    private String biddingNo;
    private Date appraiseDate;
    private Date fileEndDate;
//    private Date planBeginDate;
//    private Date planEndDate;
    private String serialNo;
    private String isCompleted;
    private Date completeDate;
    private String bidState;

    private Date createTimeBegin;
    private Date createTimeEnd;
    private Date completeDateBegin;
    private Date completeDateEnd;
    private Date updateTimeBegin;
    private Date updateTimeEnd;
    private Date appraiseDateBegin;
    private Date appraiseDateEnd;
    private String sortBy;
    private String isExculdeRepeatedInExecutePlan;
    private String color;
    private Integer planNum;

    public Integer getPlanNum() {
        return planNum;
    }

    public void setPlanNum(Integer planNum) {
        this.planNum = planNum;
    }

    public String getIsExculdeRepeatedInExecutePlan() {
        return isExculdeRepeatedInExecutePlan;
    }

    public void setIsExculdeRepeatedInExecutePlan(String isExculdeRepeatedInExecutePlan) {
        this.isExculdeRepeatedInExecutePlan = isExculdeRepeatedInExecutePlan;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public Bidding(){
        this.bidState = NORMAL_STATE;
    }

    public Date getAppraiseDateBegin() {
        return appraiseDateBegin;
    }

    public void setAppraiseDateBegin(Date appraiseDateBegin) {
        this.appraiseDateBegin = appraiseDateBegin;
    }

    public Date getAppraiseDateEnd() {
        return appraiseDateEnd;
    }

    public void setAppraiseDateEnd(Date appraiseDateEnd) {
        this.appraiseDateEnd = appraiseDateEnd;
    }

    public Date getCreateTimeBegin() {
        return createTimeBegin;
    }

    public void setCreateTimeBegin(Date createTimeBegin) {
        this.createTimeBegin = createTimeBegin;
    }

    public Date getCreateTimeEnd() {
        return createTimeEnd;
    }

    public void setCreateTimeEnd(Date createTimeEnd) {
        this.createTimeEnd = createTimeEnd;
    }

    public Date getCompleteDateBegin() {
        return completeDateBegin;
    }

    public void setCompleteDateBegin(Date completeDateBegin) {
        this.completeDateBegin = completeDateBegin;
    }

    public Date getCompleteDateEnd() {
        return completeDateEnd;
    }

    public void setCompleteDateEnd(Date completeDateEnd) {
        this.completeDateEnd = completeDateEnd;
    }

    public Date getUpdateTimeBegin() {
        return updateTimeBegin;
    }

    public void setUpdateTimeBegin(Date updateTimeBegin) {
        this.updateTimeBegin = updateTimeBegin;
    }

    public Date getUpdateTimeEnd() {
        return updateTimeEnd;
    }

    public void setUpdateTimeEnd(Date updateTimeEnd) {
        this.updateTimeEnd = updateTimeEnd;
    }

    public String getBidState() {
        return bidState;
    }

    public void setBidState(String bidState) {
        this.bidState = bidState;
    }

    public String getIsCompleted() {
        return isCompleted;
    }

    public void setIsCompleted(String isCompleted) {
        this.isCompleted = isCompleted;
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public Date getAppraiseDate() {
        return appraiseDate;
    }

    public void setAppraiseDate(Date appraiseDate) {
        this.appraiseDate = appraiseDate;
    }

    public String getBidType() {
        return bidType;
    }

    public void setBidType(String bidType) {
        this.bidType = bidType;
    }

    public String getBiddingNo() {
        return biddingNo;
    }

    public void setBiddingNo(String biddingNo) {
        this.biddingNo = biddingNo;
    }

    public Date getFileEndDate() {
        return fileEndDate;
    }

    public void setFileEndDate(Date fileEndDate) {
        this.fileEndDate = fileEndDate;
    }
    
    

//    public Date getPlanBeginDate() {
//        return planBeginDate;
//    }
//
//    public void setPlanBeginDate(Date planBeginDate) {
//        this.planBeginDate = planBeginDate;
//    }
//
//    public Date getPlanEndDate() {
//        return planEndDate;
//    }
//
//    public void setPlanEndDate(Date planEndDate) {
//        this.planEndDate = planEndDate;
//    }

    public Dictionary getDictBiddingType() {
		return dictBiddingType;
	}

	public void setDictBiddingType(Dictionary dictBiddingType) {
		this.dictBiddingType = dictBiddingType;
	}

	public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
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

    public String getBiddingId() {
		return biddingId;
	}
	public void setBiddingId(String biddingId) {
		this.biddingId = biddingId;
	}
	public String getBiddingName() {
		return biddingName;
	}
	public void setBiddingName(String biddingName) {
		this.biddingName = biddingName;
	}
	public String getBiddingTypeId() {
		return biddingTypeId;
	}
	public void setBiddingTypeId(String biddingTypeId) {
		this.biddingTypeId = biddingTypeId;
	}
	public String getRouteId() {
		return routeId;
	}
	public void setRouteId(String routeId) {
		this.routeId = routeId;
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
	public String getBiddingType() {
		return biddingType;
	}
	public void setBiddingType(String biddingType) {
		this.biddingType = biddingType;
	}
	public Route getRoute() {
		return route;
	}
	public void setRoute(Route route) {
		this.route = route;
	}


}
