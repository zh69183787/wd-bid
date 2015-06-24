package com.wonders.stpt.bid.domain;

import java.util.Date;

import org.springframework.util.StringUtils;

import com.wonders.stpt.bid.utils.DateUtils;

/**
 * Created by Administrator on 2014/7/8.标段
 */
public class BidImportMain {

	/**
	 * 标段主键
	 */
	private String mainId;
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
     * 创建人
     */
    private String creator;
    /**
     * 更新人
     */
    private String updater;
    /**
     * 流水号
     */
    private String serialNo;
    /**
     * 是否已经更新是否已经更新0 未导入1 已导入未对比2已对比未更新3已更新
     */
    private String isUpdate ="0";
    private String isUpdateStr="未导入";
    /**
     * 所属年月
     */
    private Date belongDate = new Date();
    private String belongDateYear;
    private String belongDateMonth;
    /**
     * 上传导入文件路径
     */
    private String filePath;
    /**
     * 附件群组
     */
    private String fileGroup;
    /**
     * 上传导入文件名
     */
    private String fileName;
    
    /**
     * 上报单位
     */
    private String companyId;
    /**
     * 上报单位实体
     */
    private Dictionary dictCompany;
    
    private Attachment attachment;
    
    private Date createTimeBegin;
    private Date createTimeEnd;
    private Date completeDateBegin;
    private Date completeDateEnd;
    private Date updateTimeBegin;
    private Date updateTimeEnd;
    private Date belongDateBegin;
    private Date belongDateEnd;
    
    private String sortBy;
    
    
    

    public String getIsUpdateStr() {
    	
    	if(getIsUpdate().equals("0")){
    		return "未导入";
    	}else if(getIsUpdate().equals("1")){
    		return "已导入未对比";
    	}else if(getIsUpdate().equals("2")){
    		return "已对比未更新";
    	}else if(getIsUpdate().equals("3")){
    		return "已更新";
    	}
    	
		return isUpdateStr;
	}
    
    public String getBelongDateYear(){
    	return DateUtils.getYear(belongDate);
    }
    


	public String getBelongDateMonth() {
		return DateUtils.getMonth(belongDate);
	}

	public String getSortBy() {
		return sortBy;
	}

	public void setSortBy(String sortBy) {
		this.sortBy = sortBy;
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

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
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

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileGroup() {
		return fileGroup;
	}

	public void setFileGroup(String fileGroup) {
		this.fileGroup = fileGroup;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}



	public Dictionary getDictCompany() {
		return dictCompany;
	}

	public void setDictCompany(Dictionary dictCompany) {
		this.dictCompany = dictCompany;
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

	public Date getBelongDateBegin() {
		return belongDateBegin;
	}

	public void setBelongDateBegin(Date belongDateBegin) {
		this.belongDateBegin = belongDateBegin;
	}

	public Date getBelongDateEnd() {
		return belongDateEnd;
	}

	public void setBelongDateEnd(Date belongDateEnd) {
		this.belongDateEnd = belongDateEnd;
	}

	public Attachment getAttachment() {
		return attachment;
	}

	public void setAttachment(Attachment attachment) {
		this.attachment = attachment;
	}

	


}
