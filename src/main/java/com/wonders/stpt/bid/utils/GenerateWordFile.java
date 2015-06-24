
  /**
  * 文件名：GenerateWordFile.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;

import org.apache.poi.ss.usermodel.Workbook;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Map;


  
  /**
  * 项目名称：Example
  * 类名称：GenerateWordFile
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:56:40
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public class GenerateWordFile implements IGenerateFile {

    /* (non-Javadoc)
     * @see main.IGenerateFile#getOutputStram(java.lang.String, java.util.Map, java.lang.String, main.FileEnum)
    
     */
    @Override
    public boolean getOutputStram(String inputFilePath, Map map,
	    String outputFilePath, FileEnum fileEnum) throws Exception {
	
	return false;
    }

      @Override
      public Workbook export(InputStream input, Map map) throws Exception {
          return null;
      }
  }
