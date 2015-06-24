
  /**
  * 文件名：Context.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;

import org.apache.poi.ss.usermodel.Workbook;

import javax.wsdl.Output;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;


  
  /**
  * 项目名称：Example
  * 类名称：Context
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:41:15
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public class Context {
    private IGenerateFile iGenerateFile;

    public IGenerateFile getiGenerateFile() {
        return iGenerateFile;
    }

    public void setiGenerateFile(IGenerateFile iGenerateFile) {
        this.iGenerateFile = iGenerateFile;
    }
    
    public boolean getOutputStram(String inputFilePath, Map map, String outputFilePath, Integer type)throws Exception{
	
	iGenerateFile= GenerateFileFactory.getInstance().creator(type);
	return iGenerateFile.getOutputStram(inputFilePath, map, outputFilePath, FileEnum.valueOf(type));
	
    }

    public Workbook output(InputStream input,Map map) throws Exception{
        iGenerateFile= GenerateFileFactory.getInstance().creator(2);
        return iGenerateFile.export(input,map);
    }
    
}
