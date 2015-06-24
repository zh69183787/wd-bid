
  /**
  * 文件名：FileUtil.java
  *
  * 版本信息：
  * 日期：2014-7-10
  * Copyright ZZDIC Corporation 2014 
  * 版权所有
  *
  */
  
package com.wonders.stpt.bid.utils;

import java.io.File;




  
  /**
  * 项目名称：Example
  * 类名称：FileUtil
  * 类描述：
  * 创建人：JAMES LAU
  * 创建时间：2014-7-10 下午2:59:22
  * 修改人：
  * 修改时间：
  * 修改备注：
  * @version v1.0 
  */

public class FileUtil {
    
    
       /**
         * 方法名称：
         * 参数名称：fullPath 文件全路劲，包含文件名 如:d:\\TEST.doc
         * 返回值：NoN
         * 方法描述： 删除文件
         * 创建时间：2014-7-10 下午3:01:44
        */
	public static void delFile(String fullPath) {
		try {
			File file = new File(fullPath);
			
			if(checkFileExists(fullPath))
			    file.delete();
			else
			    System.out.println("文件不存在");
		} catch (Exception e) {
		    
		    System.out.println("异常"+e);
			
		}
	}
	
	/**
	  * 方法名称：checkFileExists 判断文件是否存在 
	  * 参数名称：fullPath 文件全路劲，包含文件名 如:d:\\TEST.doc
	  * 返回值： boolean
	  * 方法描述：
	  * 创建时间：2014-7-10 下午3:40:14
	 */
	public static boolean checkFileExists (String fullPath){
	    
	    File file = new File(fullPath);
	    
	    return file.exists()?true:false;
	}
	
	
	/**
	  * 方法名称：delAllFile
	  * 参数名称： path 文件夹路径 如D:\\Dir
	  * 返回值：字符串
	  * 方法描述：删除文件夹里的文件  定时器 每天夜里定时执行
	  * 创建时间：2014-7-10 下午3:42:38
	 */
	public void delAllFile(String path)throws Exception {
		File file = new File(path);
		if (!file.exists()) {
			return;
		}
		if (!file.isDirectory()) {
			return;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delFolder(path + File.separatorChar + tempList[i]);// 再删除空文件夹
			}
		}
		
	}
	
	
	/**
	 * 删除文件夹
	 */
	public void delFolder(String folderPath) {
		try {
			delAllFile(folderPath); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			new File(filePath).delete();
			
		} catch (Exception e) {
			System.out.println("error"+e);
		}
	}

}
