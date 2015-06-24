
  /**
  * 文件名：IGenerateFile.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;

import org.apache.poi.ss.usermodel.Workbook;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;


  
  /**
  * 项目名称：Example
  * 类名称：IGenerateFile
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:12:12
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public interface IGenerateFile {
    
    public boolean getOutputStram(String inputFilePath, Map map, String outputFilePath, FileEnum fileEnum) throws Exception;

    public Workbook export(InputStream input, Map map) throws Exception;
}
