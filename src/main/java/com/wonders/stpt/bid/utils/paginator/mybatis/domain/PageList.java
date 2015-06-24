package com.wonders.stpt.bid.utils.paginator.mybatis.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * 包含“分页”信息的List
 * <p/>
 * <p>要得到总页数请使用 toPaginator().getTotalPages();</p>
 *
 * @author badqiu
 * @author miemiedev
 */
public class PageList<E> extends ArrayList<E> implements Serializable {

    private static final long serialVersionUID = 1412759446332294208L;

    private Paginator paginator;
    
    private PageInfo pageInfo;

    private int pageSize;

    private int pageIndex;

    private int totalRows;

    private int totalPages;

    public PageList() {
    }

    public PageList(Collection<? extends E> c) {
        super(c);
    }


    public PageList(Collection<? extends E> c, Paginator p) {
        super(c);
        this.paginator = p;
    }

    public PageList(Paginator p) {
        this.paginator = p;
    }


    protected Paginator getPaginator() {
	return paginator;
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

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }
    
    public PageInfo<E> getPageInfo(){
    	System.out.println("TotalRows="+this.getTotalPages()+"      PageIndex="+this.getPageIndex());
    	PageInfo<E> pageObj= new PageInfo<E>();
    	pageObj.setPageIndex(this.getPageIndex());
       	pageObj.setPageSize(this.getPageSize());
       	pageObj.setTotalPages(this.getTotalPages());
       	pageObj.setTotalRows(this.getTotalRows());
       	return pageObj;
   }

}
