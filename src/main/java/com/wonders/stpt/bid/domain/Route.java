package com.wonders.stpt.bid.domain;

import java.util.Date;

/**
 * Created by Administrator on 2014/7/8.
 */
public class Route {
	/**
	 * 线路主键
	 */
    private String routeId;
    /**
     * 线路名称
     */
    private String routeName;
    /**
     * 单位名称
     */
    private String company;
    /**
     * 线路类型
     */
    private String routeType;
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

    private String sortByRouteName;



    private User user;

    public String getSortByRouteName() {
        return sortByRouteName;
    }

    public void setSortByRouteName(String sortByRouteName) {
        this.sortByRouteName = sortByRouteName;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getRouteId() {
        return routeId;
    }

    public void setRouteId(String routeId) {
        this.routeId = routeId;
    }

    public String getRouteName() {
        return routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public String getRouteType() {
        return routeType;
    }

    public void setRouteType(String routeType) {
        this.routeType = routeType;
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

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }
}
