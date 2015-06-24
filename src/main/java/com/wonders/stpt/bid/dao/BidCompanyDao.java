package com.wonders.stpt.bid.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidCompany;
/**
 * 投标单位
 * @author shanweifeng2014-7-10
 *
 */
public interface BidCompanyDao extends GenericDAO<BidCompany> {
	/**
	 * 根据条件分页查询
	 * @param param
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidCompany> select(@Param("company")BidCompany company,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;

//    List<String> selectGroups();


//    public List<BidCompany> selectAllCompany(@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;
}
