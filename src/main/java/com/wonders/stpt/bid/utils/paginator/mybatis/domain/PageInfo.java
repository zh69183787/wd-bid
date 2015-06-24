package com.wonders.stpt.bid.utils.paginator.mybatis.domain;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: pc
 * Date: 13-9-2
 * Time: 下午4:36
 * To change this template use File | Settings | File Templates.
 */
public class PageInfo<T> {

    private int pageSize;

    private int pageIndex;

    private int totalRows;

    private int totalPages;

    public PageInfo(int pageIndex, int pageSize) {
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
    }
    
    public PageInfo(){
	
    }


    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

  

   

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
    }
}

