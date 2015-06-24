
  /**
  * 文件名：FileEnum.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;


  
  /**
  * 项目名称：Example
  * 类名称：FileEnum
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:26:05
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public enum FileEnum {
    
    DOC_TYPE(1, "WORD格式"),
    
    EXCEL_TYPE(2, "EXCEL格式");
    
    private int value;

    private String description;

   

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    private FileEnum(int value, String description){
	
	this.value= value;
	this.description= description;
	
    }
    
    
    public static FileEnum valueOf(int value) {

        for(FileEnum type : FileEnum.values()) {

            if(type.value == value) {

                return type;

            }

        }

        return null;

    }


	
	


}
