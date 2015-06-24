package com.wonders.stpt.bid.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidImportMain;
/**
 *  招标计划导入 主表
 * @author
 *
 */
public interface BidImportMainDao extends GenericDAO<BidImportMain> {

	/**
	 * 根据条件分页查询
	 * @param bidding
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidImportMain> select(@Param("bidImportMain")BidImportMain bidImportMain,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;
	/**
	 * 新增实体  自己生成uid
	 * @param entity
	 * @return
	 * @throws Exception
	 */
    public int insertWithMainId(BidImportMain bidImportMain) throws Exception;
}
