package com.wonders.stpt.bid.dao;

import com.wonders.stpt.bid.domain.Dictionary;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2014/11/1.
 */
public interface DictionaryDao extends GenericDAO<Dictionary> {

    public List<Dictionary> select(@Param("dictionary")Dictionary dictionary)throws Exception;

    public Integer selectMaxDictNo();
    
    public List<Dictionary> selectAllByTypeCode(@Param("dictType") String dictType)throws Exception;
    
    public List<Dictionary> selectAllByFullName(@Param("dictFullName") String dictFullName)throws Exception;

	public Dictionary selectByFullCodeAndDictType(@Param("dictFullCode")String dictFullCode,
			@Param("dictType")String dictType);

	public List<Dictionary> selectAllByParentNo(@Param("parentNo")String parentNo);
}
