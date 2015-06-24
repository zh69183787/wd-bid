package com.wonders.stpt.bid.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidChange;
import com.wonders.stpt.bid.domain.Route;

public interface BidChangeDao extends GenericDAO<BidChange> {
	/**
	 * 根据条件分页查询
	 * @param route
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
    public List<BidChange> select(@Param("bidChange")BidChange bidChange,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize)throws Exception;
}
