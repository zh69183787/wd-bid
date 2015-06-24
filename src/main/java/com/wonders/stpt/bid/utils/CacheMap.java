package com.wonders.stpt.bid.utils;

import java.util.HashMap;
import java.util.Map;

public class CacheMap {
	
	public static Map<String,Object> mapCache = new HashMap<String,Object>();
	
	public static Object getCache(String key){
		return CacheMap.mapCache.get(key);
	}
	
	public static void putCache(String key,Object val){
		CacheMap.mapCache.put(key,val);
	}
	
	public static void clearCache(String key){
		CacheMap.mapCache.put(key,null);
	}

}
