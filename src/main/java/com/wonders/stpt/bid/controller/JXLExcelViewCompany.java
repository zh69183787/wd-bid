package com.wonders.stpt.bid.controller;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class JXLExcelViewCompany extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String excelName = (String) model.get("title") + ".xls";
		// 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename="
                + URLEncoder.encode(excelName, "UTF-8"));
        OutputStream os = response.getOutputStream();
        
        POIFSFileSystem fs = new POIFSFileSystem(this.getClass().getResourceAsStream("/templateCompany.xls"));
        workbook = new HSSFWorkbook(fs);
        
        
        workbook.write(os);
        os.flush();
        os.close();
	}

}
