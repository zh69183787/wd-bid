package com.wonders.stpt.bid.service;

import com.wonders.stpt.bid.domain.Dictionary;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2014/11/1.
 */
public interface IDictionaryService {
    List<Dictionary> getDictionaries(Dictionary dictionary)throws Exception;

    Dictionary getDictionary(String dictionaryId)throws Exception;

    int delete(String dictionaryId)throws Exception;

    Dictionary save(Dictionary dictionary)throws Exception;

    Integer getMaxDictNo()throws Exception;
    
    
    public List<Dictionary> selectAllByType( String dictType)throws Exception;
    
    public Dictionary selectAllByFullName(String dictType, String dictFullName)throws Exception;


	Map<String, Dictionary> selectNameMapAllByType(String dictType)
			throws Exception;

	Dictionary getDictionary(String dictFullCode, String dictType)
			throws Exception;
	
	
	 public List<Dictionary> selectAllByParentNo( String parentNo)throws Exception;
}
