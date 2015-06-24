
  /**
  * 文件名：GenerateFileFactory.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;

import java.util.HashMap;
import java.util.Map;


  
  /**
  * 项目名称：Example
  * 类名称：GenerateFileFactory
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:23:13
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public class GenerateFileFactory {
    
    private static GenerateFileFactory  factory = new GenerateFileFactory();
    
    private GenerateFileFactory(){
	
    }
    
    private static Map strategyMap = new HashMap();
    
    static {
	strategyMap.put(FileEnum.EXCEL_TYPE.getValue(), new GenerateExcelFile());
	strategyMap.put(FileEnum.DOC_TYPE.getValue(), new GenerateWordFile());
    }

    public IGenerateFile creator(Integer type){
	return (IGenerateFile) strategyMap.get(type);
    }
    
    public static GenerateFileFactory getInstance(){
	
	return factory;
    }
    

}
