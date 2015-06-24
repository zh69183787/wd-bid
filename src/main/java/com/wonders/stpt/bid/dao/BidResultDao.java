package com.wonders.stpt.bid.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.BidResult;
/**
 * 投标结果
 * @author shanweifeng2014-7-10
 *
 */
public interface BidResultDao extends GenericDAO<BidResult> {
    /**
     * 根据计划分页查询
     * @param bidResult
     * @param biddingPlanIds
     * @return
     * @throws Exception
     */
	public List<BidResult> select(@Param("bidResult")BidResult bidResult,@Param("biddingPlanIds")String[] biddingPlanIds,
                                  @Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;

    public List<Map> countByPlanId(@Param("bidResult")BidResult bidResult,@Param("biddingPlanIds")String[] biddingPlanIds)throws Exception;

    public List<BidResult> selectResults(@Param("bidResult")BidResult bidResult);
    /**
     * 分组查询
     * @return
     */
    public List<BidResult> selectByGroupC(@Param("bidResult")BidResult bidResult);
    /**
     * 统计总数
     * @return
     */
    public List<Map> countAll(@Param("bidResult")BidResult bidResult);
    /**
     * 分组统计(companyName)
     * @param type
     * @return
     */
    public List<Map> countGroup(@Param("bidResult")BidResult bidResult);
    /**
     * 分组统计（groups）
     * @return
     */
    public List<Map> countGroups(@Param("bidResult")BidResult bidResult);
}
