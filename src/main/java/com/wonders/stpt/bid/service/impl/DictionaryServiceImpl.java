package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.DictionaryDao;
import com.wonders.stpt.bid.domain.Dictionary;
import com.wonders.stpt.bid.service.IDictionaryService;
import com.wonders.stpt.bid.utils.CacheMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2014/11/1.
 */
@Service
public class DictionaryServiceImpl implements IDictionaryService {

    @Autowired
    private DictionaryDao dictionaryDao;

    @Override
    public List<Dictionary> getDictionaries(Dictionary dictionary) throws Exception {
        return dictionaryDao.select(dictionary);
    }

    @Override
    public Dictionary getDictionary(String dictionaryId) throws Exception {
        return dictionaryDao.selectById(dictionaryId);
    }
    
    @Override
    public Dictionary getDictionary(String dictFullCode ,String dictType) throws Exception {
        return dictionaryDao.selectByFullCodeAndDictType(dictFullCode,dictType);
    }

    @Override
    public int delete(String dictionaryId) throws Exception {
        return dictionaryDao.delete(dictionaryId);
    }

    @Override
    public Dictionary save(Dictionary dictionary) throws Exception {
    	String code ="";
    	String fullCode="";
    	String fullName="";
        if("null".equals(dictionary.getParentNo())){
            dictionary.setParentNo(null);
        }else{
        	Dictionary parent = dictionaryDao.selectById(dictionary.getParentNo());
        	
        }
        
        if(StringUtils.isEmpty(dictionary.getDictId()) ){
        	dictionaryDao.insert(dictionary);
        }else{
        	dictionaryDao.update(dictionary);
        }
        return dictionary;
    }

    @Override
    public Integer getMaxDictNo() throws Exception {
        return dictionaryDao.selectMaxDictNo();
    }

	@SuppressWarnings("unchecked")
	@Override
	public List<Dictionary> selectAllByType(String dictType) throws Exception {
		Object objds = CacheMap.getCache(dictType+"_dictionaries");
		List<Dictionary> dictionaries =null;
		if(objds==null){
			dictionaries = dictionaryDao.selectAllByTypeCode(dictType);//.getDictionaries(dictionary);
			CacheMap.putCache(dictType+"_dictionaries", dictionaries);
		}else{
			dictionaries = (List<Dictionary>) objds;
		}
		return dictionaries;
	}
	@Override
	public Map<String,Dictionary> selectNameMapAllByType(String dictType) throws Exception {
		 List<Dictionary>  ds = selectAllByType(dictType);
		 Map<String,Dictionary> map = new HashMap<String,Dictionary>();
		 for(Dictionary d:ds){
			 map.put(d.getDictFullName(), d);
		 }
		return map;
	}
	@Override
	public Dictionary selectAllByFullName(String dictType,String dictFullName)
			throws Exception {
		Map<String,Dictionary> map = selectNameMapAllByType(dictType);
		
		
		return map.get(dictFullName);
	}

	@Override
	public List<Dictionary> selectAllByParentNo(String parentNo)
			throws Exception {
		// TODO Auto-generated method stub
		return dictionaryDao.selectAllByParentNo(parentNo);
	}
}
