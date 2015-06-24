package com.wonders.stpt.bid.dao;

import java.util.List;
import java.util.Map;

import com.wonders.stpt.bid.domain.BidCompany;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidPlan;
/**
 * 投标计划
 * @author shanweifeng2014-7-10
 *
 */
public interface BidPlanDao extends GenericDAO<BidPlan>{

	/**
	 * 根据条件分页查询
	 * @param bidPlan
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidPlan> select(@Param("bidPlan")BidPlan bidPlan,@Param("company")BidCompany company,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;
	/**
	 * 根据条件分页查询与更新时间排序
	 * @param bidPlan
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<BidPlan> selectPlan(@Param("bidPlan")BidPlan bidPlan,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;


    /**
     * 删除关联表记录
     * @param executeId   执行计划id
     * @return
     * @throws Exception
     */
    public int deleteRelation(@Param("executeId")String executeId)throws Exception;

    /**
     * 新增关联记录
     * @param executedId    执行计划id
     * @param planId         招标计划id
     * @return
     * @throws Exception
     */
    public int insertRelation(@Param("executeId")String executedId,@Param("planId")String planId)throws Exception;
    
    
	/**
	 * 根据开标时间  查询统计表
	 * @param bidPlan
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> getDistributionPlan(@Param("bidPlan")BidPlan bidPlan)throws Exception;

}
