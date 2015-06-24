package com.wonders.stpt.bid.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidImport;
/**
 * 标段Dao
 * @author shanweifeng2014-7-10
 *
 */
public interface BidImportDao extends GenericDAO<BidImport> {

	/**
	 * 根据条件分页查询
	 * @param bidImport
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidImport> select(@Param("bidImportMap")BidImport bidImport,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;

	/**
	 * 根据条件模糊查询
	 * @param bidImport
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidImport> selectfuzzy(@Param("bidImportMap")BidImport bidImport)throws Exception;
	/**
	 * 根据MainId查找
	 * @param bidImport
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidImport> selectByMainId(@Param("mainId")String mainId)throws Exception;
	
	public int deleteByMainId(@Param("mainId")String mainId)throws Exception;
}
