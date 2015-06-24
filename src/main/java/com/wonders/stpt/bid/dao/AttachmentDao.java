package com.wonders.stpt.bid.dao;

import java.util.List;

import com.wonders.stpt.bid.domain.Attachment;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;

import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2014/8/29.
 */
public interface AttachmentDao extends GenericDAO<Attachment>  {
    /**
     * 查询所有未删除的实体
     * @return
     * @throws Exception
     */
    public PageList<Attachment> select(@Param("attachment") Attachment entity,@Param("pageIndex")Integer pageIndex,@Param("pageSize")Integer pageSize)throws Exception;

    /**
     * 更新实体
     * @param entity
     * @return
     * @throws Exception
     */
    public int update(@Param("entity")Attachment entity,@Param("isDynamic")boolean isDynamic)throws Exception;
    
}
