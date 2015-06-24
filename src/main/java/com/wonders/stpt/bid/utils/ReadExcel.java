package com.wonders.stpt.bid.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.wonders.stpt.bid.domain.BidImport;

public class ReadExcel {
	public LinkedList<Map<String, Object>> readExcel(String excelPath)
			throws InvalidFormatException, FileNotFoundException, IOException {
		Workbook workbook = WorkbookFactory.create(new FileInputStream(new File(excelPath)));
		Sheet sheet = workbook.getSheetAt(0);
		int startRowNum = sheet.getFirstRowNum();
		int endRowNum = sheet.getLastRowNum();
		for (int rowNum = startRowNum; rowNum <= endRowNum; rowNum++) {
			Row row = sheet.getRow(rowNum);
			if (row == null)
				continue;
			int startCellNum = row.getFirstCellNum();
			int endCellNum = row.getLastCellNum();
			
			if(row.getCell(1).getStringCellValue().equals("人力资源")){
				continue;
			}
			
			for (int cellNum = startCellNum; cellNum < endCellNum; cellNum++) {
				Cell cell = row.getCell(cellNum);
				if(cellNum==1){continue;}
				if (cell == null)
					continue;
				int type = cell.getCellType();
				switch (type) {
				case Cell.CELL_TYPE_NUMERIC:// 数值、日期类型
					double d = cell.getNumericCellValue();
					if (HSSFDateUtil.isCellDateFormatted(cell)) {// 日期类型
						// Date date = cell.getDateCellValue();
						Date date = HSSFDateUtil.getJavaDate(d);
						System.out.print(" "
								+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(date) + " ");
					} else {// 数值类型
						System.out.print(" " + d + " ");
					}
					break;
				case Cell.CELL_TYPE_BLANK:// 空白单元格
					System.out.print(" null ");
					break;
				case Cell.CELL_TYPE_STRING:// 字符类型
					System.out.print(" " + cell.getStringCellValue() + " ");
					break;
				case Cell.CELL_TYPE_BOOLEAN:// 布尔类型
					System.out.println(cell.getBooleanCellValue());
					break;
				case HSSFCell.CELL_TYPE_ERROR: // 故障
					System.err.println("非法字符");// 非法字符;
					break;
				default:
					System.err.println("error");// 未知类型
					break;
				}
			}
			System.out.println();
		}
		return null;
	}

	public static void main(String[] args) {
		int max=359;
        int min=1;
        Random random = new Random();

        
        for(int i=0;i<10;i++){
        	int s = random.nextInt(max)%(max-min+1) + min;
            System.out.println(s);
            
        }
        
        int s = random.nextInt(max)%(max-min+1) + min;
        System.out.println(s);
		/*ReadExcel ReadExcel2 = new ReadExcel();
		try {
			//ReadExcel2.readExcelForBidImport("D:\\Work\\3-ST-BID\\招标计划.xlsx");
			 ReadExcel2.readExcel("D:\\cj.xlsx");
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
	}
	
	public List<BidImport> readExcelForBidImport(String excelPath)
			throws InvalidFormatException, FileNotFoundException, IOException {
		Workbook workbook = WorkbookFactory.create(new FileInputStream(new File(excelPath)));
		Sheet sheet = workbook.getSheetAt(0);
		int startRowNum = sheet.getFirstRowNum()+1;
		int endRowNum = sheet.getLastRowNum();
		
		List<BidImport> bidImports =new ArrayList<BidImport>();
		
		for (int rowNum = startRowNum; rowNum <= endRowNum; rowNum++) {
			Row row = sheet.getRow(rowNum);
			if (row == null)
				continue;
			int startCellNum = row.getFirstCellNum();
			int endCellNum = row.getLastCellNum();
			
			BidImport bidImport = new BidImport();
			bidImport.setRouteName(getCellStringValue(row.getCell(1)));
			bidImport.setTypeOne(getCellStringValue(row.getCell(2)));
			bidImport.setTypeTwo(getCellStringValue(row.getCell(3)));
			bidImport.setTypeThree(getCellStringValue(row.getCell(4)));
			bidImport.setTypeFour(getCellStringValue(row.getCell(5)));
			bidImport.setBiddingName(getCellStringValue(row.getCell(6)));
			bidImport.setBidType(getCellStringValue(row.getCell(7)));
			bidImport.setBiddingNo(getCellStringValue(row.getCell(8)));
			bidImport.setFileEndDate(DateUtils.parse(getCellStringValue(row.getCell(9)),DateUtils.FORMAT_SHORT));
			bidImport.setAppraiseDate(DateUtils.parse(getCellStringValue(row.getCell(10)),DateUtils.FORMAT_SHORT));
			
		}
		return bidImports;
	}
	
	public static String getCellDateStringValue(Cell cell){
		String val=null;
		if(cell==null){return val;}
		
		int type = cell.getCellType();
		switch (type) {
		case Cell.CELL_TYPE_NUMERIC:// 数值、日期类型
			double d = cell.getNumericCellValue();
			if (HSSFDateUtil.isCellDateFormatted(cell)) {// 日期类型
				// Date date = cell.getDateCellValue();
				Date date = HSSFDateUtil.getJavaDate(d);
				System.out.print(" "
						+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.format(date) + " ");
				val = new SimpleDateFormat(DateUtils.FORMAT_SHORT).format(date);
			} else {// 数值类型
				String ddd2 =cell.getCellFormula();
				short ddd = HSSFDataFormat.getBuiltinFormat("yyyy年MM月dd");
				short format = cell.getCellStyle().getDataFormat();  
				
				int fm = format;
			    SimpleDateFormat sdf = null;  
			    if(fm>=178 || fm<=184 || fm==194|| fm==14|| fm==47  ){  //178 -184  194 14 47
			        //日期  
			        sdf = new SimpleDateFormat("yyyy-MM-dd");  
			        double value = cell.getNumericCellValue();  
				    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);  
				    val = sdf.format(date);  
			    }else if (format == 20 || format == 32) {  
			        //时间  
			        sdf = new SimpleDateFormat("HH:mm");  
			        double value = cell.getNumericCellValue();  
				    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);  
				    val = sdf.format(date);  
			    }else{
			    	System.out.print(" " + d + " ");
					DecimalFormat format2 = new DecimalFormat("#");
					val = format2.format(d);
			    }
				//val = d+"";
			}
			break;
		case Cell.CELL_TYPE_BLANK:// 空白单元格
			System.out.print(" null ");
			val = null;
			break;
		case Cell.CELL_TYPE_STRING:// 字符类型
			System.out.print(" " + cell.getStringCellValue() + " ");
			val = cell.getStringCellValue();
			if(val!=null) val = val.trim();
			break;
		case Cell.CELL_TYPE_BOOLEAN:// 布尔类型
			System.out.println(cell.getBooleanCellValue());
			val = String.valueOf(cell.getBooleanCellValue());
			break;
		case HSSFCell.CELL_TYPE_ERROR: // 故障
			System.err.println("非法字符");// 非法字符;
			val = null;
			break;
		default:
			System.err.println("error");// 未知类型
			val = null;
			break;
		}
		return val;
		
	}
	
	public static String getCellStringValue(Cell cell){
		String val=null;
		if(cell==null){return val;}
		
		int type = cell.getCellType();
		switch (type) {
		case Cell.CELL_TYPE_NUMERIC:// 数值、日期类型
			double d = cell.getNumericCellValue();
			if (HSSFDateUtil.isCellDateFormatted(cell)) {// 日期类型
				// Date date = cell.getDateCellValue();
				Date date = HSSFDateUtil.getJavaDate(d);
				System.out.print(" "
						+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.format(date) + " ");
				val = new SimpleDateFormat(DateUtils.FORMAT_SHORT).format(date);
			} else {// 数值类型
				short format = cell.getCellStyle().getDataFormat();  
			    SimpleDateFormat sdf = null;  
			    if((format>=176 && format<=194) || format==14|| format==47  || format == 57 || format == 58){  
			        //日期  
			        sdf = new SimpleDateFormat("yyyy-MM-dd");  
			        double value = cell.getNumericCellValue();  
				    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);  
				    val = sdf.format(date);  
			    }else if (format == 20 || format == 32) {  
			        //时间  
			        sdf = new SimpleDateFormat("HH:mm");  
			        double value = cell.getNumericCellValue();  
				    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);  
				    val = sdf.format(date);  
			    }else{
			    	System.out.print(" " + d + " ");
					DecimalFormat format2 = new DecimalFormat("#");
					val = format2.format(d);
			    }
			   
			    
			    
			    
			    
				
				//val = d+"";
			}
			break;
		case Cell.CELL_TYPE_BLANK:// 空白单元格
			System.out.print(" null ");
			val = null;
			break;
		case Cell.CELL_TYPE_STRING:// 字符类型
			System.out.print(" " + cell.getStringCellValue() + " ");
			val = cell.getStringCellValue();
			if(val!=null) val = val.trim();
			break;
		case Cell.CELL_TYPE_BOOLEAN:// 布尔类型
			System.out.println(cell.getBooleanCellValue());
			val = String.valueOf(cell.getBooleanCellValue());
			break;
		case HSSFCell.CELL_TYPE_ERROR: // 故障
			System.err.println("非法字符");// 非法字符;
			val = null;
			break;
		default:
			System.err.println("error");// 未知类型
			val = null;
			break;
		}
		return val;
	}
	
	/**
	 * execl 第一行  是否是模板定义的
	 * @param titleNames
	 * @param titleRow
	 * @return
	 */
	public static boolean correctFormat(String[] titleNames,Row titleRow){
		boolean res = false;
		for(int i=0;i<titleNames.length;i++){
			String cellVal = ReadExcel.getCellStringValue(titleRow.getCell(i));
			if(cellVal==null||!cellVal.equals(titleNames[i])){
				return false;
			}else{
				res = true;
			}
		}
		
		return res;
	}
}
