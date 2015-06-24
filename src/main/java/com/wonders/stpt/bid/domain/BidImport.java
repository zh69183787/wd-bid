package com.wonders.stpt.bid.domain;

import java.util.Date;

/**
 * Created by Administrator on 2014/7/8.标段
 */
public class BidImport {

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
	 * 线路名称
	 */
	private String routeName;
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
    private String removed ="0";
    /**
     * 状态
     */
    private String state ="0";
    /**
     * 创建人
     */
    private String creator;
    /**
     * 更新人
     */
    private String updater;
    /**
     * 招标方式
     */
    private String bidType;
    /**
     * 招标方式 对应号码 1单线  2集中 
     */
    private String bidTypeCode;
    /**
     * 标段编号
     */
    private String biddingNo;
    /**
     * 评标日期
     */
    private Date appraiseDate;
    /**
     * 招标文件完成日期
     */
    private Date fileEndDate;
    /**
     * 流水号
     */
    private String serialNo;
    /**
     * 是否已经更新0 未更新1 已更新 2忽略
     */
    private String isUpdate;
    /**
     * 是否已经更新0 未更新1 已更新 2忽略
     */
    private String isUpdateStr;
    /**
     * 更新BIDDING表主键
     */
    private String ubiddingId;
    /**
     * 更新BIDDING表RouteId
     */
    private String urouteId;
    /**
     * 更新BIDDING表BiddingTypeId
     */
    private String ubiddingTypeId;
    /**
     * 所属年月
     */
    private Date belongDate;
    /**
     * 1级类型-子目
     */
    private String typeOne;
    /**
     * 2级类型-类别
     */
    private String typeTwo;
    /**
     * 3级类型-专业
     */
    private String typeThree;
    /**
     * 4级类型-标段
     */
    private String typeFour;
    
    private String fullTypeName;
    /**
     * 导入主表主键
     */
    private String mainId;
    /**
     * 评比日期的时间段选择
     */
    private Date appraiseDateBegin;
    private Date appraiseDateEnd;
    
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
	
	public Route getRoute() {
		return route;
	}
	public void setRoute(Route route) {
		this.route = route;
	}

	public String getRouteName() {
		return routeName;
	}

	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}

	public String getIsUpdate() {
		
		return isUpdate;
	}

	public void setIsUpdate(String isUpdate) {
		this.isUpdate = isUpdate;
	}


	public Date getBelongDate() {
		return belongDate;
	}

	public void setBelongDate(Date belongDate) {
		this.belongDate = belongDate;
	}

	public String getTypeOne() {
		return typeOne;
	}

	public void setTypeOne(String typeOne) {
		this.typeOne = typeOne;
	}

	public String getTypeTwo() {
		return typeTwo;
	}

	public void setTypeTwo(String typeTwo) {
		this.typeTwo = typeTwo;
	}

	public String getTypeThree() {
		return typeThree;
	}

	public void setTypeThree(String typeThree) {
		this.typeThree = typeThree;
	}

	public String getTypeFour() {
		return typeFour;
	}

	public void setTypeFour(String typeFour) {
		this.typeFour = typeFour;
	}
	
	public void setFullTypeName(String fullTypeName) {
		setTypeOne(null);
		setTypeTwo(null);
		setTypeThree(null);
		setTypeFour(null);
		if(fullTypeName!=null&&!fullTypeName.trim().equals("")){
			String[] fs = fullTypeName.split("-");
			if(fs.length==1){
				setTypeOne(fs[0]);
			}else if(fs.length==2){
				setTypeOne(fs[0]);
				setTypeTwo(fs[1]);
			}else if(fs.length==3){
				setTypeOne(fs[0]);
				setTypeTwo(fs[1]);
				setTypeThree(fs[2]);
			}else if(fs.length==4){
				setTypeOne(fs[0]);
				setTypeTwo(fs[1]);
				setTypeThree(fs[2]);
				setTypeFour(fs[3]);
			}
		}
		
		this.fullTypeName = fullTypeName;
	}
	
	

	public String getFullTypeName(){
		String fn="";
		if(getTypeOne()!=null&&!"".equals(getTypeOne().trim())){
			fn+=getTypeOne().trim();
			if(getTypeTwo()!=null&&!"".equals(getTypeTwo().trim())){
				fn+="-"+getTypeTwo().trim();
				if(getTypeThree()!=null&&!"".equals(getTypeThree().trim())){
					fn+="-"+getTypeThree().trim();
					if(getTypeFour()!=null&&!"".equals(getTypeFour().trim())){
						fn+="-"+getTypeFour().trim();
						return fn;
					}else{return fn;}
				}else{return fn;}
			}else{return fn;}
		}else{return fn;}
	}
	public String getLastTypeName(){
		if(getTypeFour()!=null&&!"".equals(getTypeFour().trim())){
			return getTypeFour();
		}else if(getTypeThree()!=null&&!"".equals(getTypeThree().trim())){
			return getTypeThree();
		}else if(getTypeTwo()!=null&&!"".equals(getTypeTwo().trim())){
			return getTypeTwo();
		}else{
			return getTypeOne();
		}
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public String getUbiddingId() {
		return ubiddingId;
	}

	public void setUbiddingId(String ubiddingId) {
		this.ubiddingId = ubiddingId;
	}

	public String getUrouteId() {
		return urouteId;
	}

	public void setUrouteId(String urouteId) {
		this.urouteId = urouteId;
	}

	public String getUbiddingTypeId() {
		return ubiddingTypeId;
	}

	public void setUbiddingTypeId(String ubiddingTypeId) {
		this.ubiddingTypeId = ubiddingTypeId;
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
	public String getBidTypeCode() {
		if(getBidType()!=null){
			if("单线".equals(getBidType())){
				return "1";
			}else if("集中".equals(getBidType())){
				return "2";
			}
		}
		return bidTypeCode;
	}

	public String getIsUpdateStr() {
		if(getIsUpdate()!=null&&"1".equals(getIsUpdate())){
			return "已更新";
		}else if(getIsUpdate()!=null&&"2".equals(getIsUpdate())){
			return "已忽略";
		}
		return "未更新";
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}




}
