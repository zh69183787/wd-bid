package com.wonders.stpt.bid.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2014/11/1.
 */
public class Dictionary  {
    private String dictId;
    private String dictNo;
    private String dictName;
    private String dictType;
    private String dictCode;
    private String dictFullCode;
    private String dictFullName;
    private Integer dictOrder;
    private String parentNo;
    
    
    private List<Dictionary> children;
    
    
    
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

    public String getDictId() {
        return dictId;
    }

    public void setDictId(String dictId) {
        this.dictId = dictId;
    }

    public String getDictNo() {
        return dictNo;
    }

    public void setDictNo(String dictNo) {
        this.dictNo = dictNo;
    }

    public String getDictName() {
        return dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }

    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType;
    }

    public Integer getDictOrder() {
        return dictOrder;
    }

    public void setDictOrder(Integer dictOrder) {
        this.dictOrder = dictOrder;
    }

    public String getParentNo() {
        return parentNo;
    }

    public void setParentNo(String parentNo) {
        this.parentNo = parentNo;
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

	public String getDictCode() {
		return dictCode;
	}

	public void setDictCode(String dictCode) {
		this.dictCode = dictCode;
	}

	public String getDictFullCode() {
		return dictFullCode;
	}

	public void setDictFullCode(String dictFullCode) {
		this.dictFullCode = dictFullCode;
	}

	public String getDictFullName() {
		return dictFullName;
	}

	public void setDictFullName(String dictFullName) {
		this.dictFullName = dictFullName;
	}

	public List<Dictionary> getChildren() {
		//if(children==null) return new ArrayList<Dictionary>();
		return children;
	}

	public void setChildren(List<Dictionary> children) {
		this.children = children;
	}
    
    
}
