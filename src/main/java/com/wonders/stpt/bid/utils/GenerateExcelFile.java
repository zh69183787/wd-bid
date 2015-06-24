
  /**
  * 文件名：GenerateExcelFile.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.ss.usermodel.Workbook;


  /**
  * 项目名称：Example
  * 类名称：GenerateExcelFile
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:19:42
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public class GenerateExcelFile implements IGenerateFile {

    @Override
    public boolean getOutputStram(String inputFilePath, Map map, String outputFilePath, FileEnum fileEnum) throws Exception {
	
	
	XLSTransformer transformer = new XLSTransformer();
	transformer.transformXLS(inputFilePath, map, outputFilePath);
	//generate success then check is the file exists (if true then read as FileOutputStream if false then return null)
	if(FileUtil.checkFileExists(outputFilePath))
	    return true;
	else
	    return false;
	
    }

      @Override
      public Workbook export(InputStream input, Map map) throws Exception {
          XLSTransformer transformer = new XLSTransformer();
          return transformer.transformXLS(input,map);
      }

  }
