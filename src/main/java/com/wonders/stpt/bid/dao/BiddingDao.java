package com.wonders.stpt.bid.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wonders.stpt.bid.domain.Bidding;
/**
 * 标段Dao
 * @author shanweifeng2014-7-10
 *
 */
public interface BiddingDao extends GenericDAO<Bidding> {

    void updateCompleteTimeNull();
    void updateCompleteTime();

	/**
	 * 根据条件分页查询
	 * @param bidding
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<Bidding> select(@Param("bidding")Bidding bidding,@Param("pageIndex")int pageIndex,@Param("pageSize")int pageSize)throws Exception;

	/**
	 * 根据条件模糊查询
	 * @param bidding
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public List<Bidding> selectfuzzy(@Param("bidding")Bidding bidding)throws Exception;
	
	/**
	 * 查询biddingId和biddingName，排除本身
	 * @param bidding
	 * @return
	 */
	public List<Bidding> selectIdNameWithoutSelf(@Param("bidding")Bidding bidding,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize);

    List<Bidding> selectByBiddingIds(@Param("biddingIdList")String[] biddingIdList);
    
    List<Bidding> selectByMainIdIsDels(@Param("bidding")Bidding bidding,@Param("mainId")String mainId,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize);

    int countBiddingId(@Param("biddingId")String biddingId);
    
    
    /**
     * 根据年份查询统计报表
     * @param year
     * @return
     * @throws Exception
     */
    List<Map<String,Object>>  countForSeason(@Param("year")String year)throws Exception;
    
    /**
     * 根据线路查询统计报表
     * @param year
     * @return
     * @throws Exception
     */
    List<Map<String,Object>>  countForRoute(@Param("year")String year)throws Exception;
    
}
