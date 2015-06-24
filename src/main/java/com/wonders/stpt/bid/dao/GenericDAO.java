package com.wonders.stpt.bid.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
/**
 * Created by Administrator on 2014/7/8.
 */
public interface GenericDAO<T> {
	/**
	 * 新增实体
	 * @param entity
	 * @return
	 * @throws Exception
	 */
    public int insert(T entity) throws Exception;
    /**
     * 更新实体
     * @param entity
     * @return
     * @throws Exception
     */
    public int update(T entity)throws Exception;
    /**
     * 根据实体主键删除
     * @param entityId
     * @return
     * @throws Exception
     */
    public int delete(@Param("id") String entityId) throws Exception;
    /**
     * 根据实体主键查找
     * @param entityId
     * @return
     * @throws Exception
     */
    public T selectById(@Param("id")String entityId)throws Exception;
    /**
     * 查询所有未删除的实体
     * @return
     * @throws Exception
     */
    public List<T> selectAll()throws Exception;
}
