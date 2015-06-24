package com.wonders.stpt.bid.controller;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.wonders.stpt.bid.domain.BidPlan;
import com.wonders.stpt.bid.domain.BidResult;

/**
 * Created by Administrator on 2014/7/17.
 */
public class JXLExcelView extends AbstractExcelView {

    private XSSFWorkbook workbook;
    private String excelName = "开标汇总表";

    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
        excelName = (String) model.get("title") + ".xlsx";
        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename="
                + URLEncoder.encode(excelName, "UTF-8"));
        OutputStream os = response.getOutputStream();

//        POIFSFileSystem fs = new POIFSFileSystem(this.getClass().getResourceAsStream("/template.xls"));
        this.workbook = new XSSFWorkbook();
        List<BidPlan> bidPlanList = (List<BidPlan>) model.get("plans");
        List<BidResult> bidResultList = (List<BidResult>) model.get("bidResults");
        List<Map> statistics = (List<Map>) model.get("statistics");

        int pageSize = model.containsKey("sheetSize") ? (Integer) model.get("sheetSize") : Integer.MAX_VALUE;
        int page = bidPlanList.size() / pageSize + 1;
        for (int i = 0; i < page; i++) {
            int fromIndex = 0, endIndex = 0;
            fromIndex = i * pageSize;
            if ((i + 1) < page) {
                endIndex = (i + 1) * pageSize;
            } else {
                endIndex = bidPlanList.size();
            }

            addSheet(bidPlanList.subList(fromIndex, endIndex), bidResultList, statistics);

        }
        this.workbook.write(os);
        os.flush();
        os.close();
    }

    private void addSheet(List<BidPlan> bidPlanList, List<BidResult> bidResultList, List<Map> statistics) {

//

        XSSFSheet sheet = workbook.createSheet();

//
//
        HashMap<String, Integer> mapPlanCell = new HashMap<String, Integer>();
        HashMap<String, Integer> mapCompanyRow = new HashMap<String, Integer>();
        addSheetTitle(sheet, StringUtils.substringBeforeLast(excelName, "."));
        addTitle(sheet, "线路", 1, 0);
        addTitle(sheet, "标段名称", 2, 0);
        addTitle(sheet, "上网报名", 3, 0);
        addTitle(sheet, "资格预审", 4, 0);
        addTitle(sheet, "发标开始", 5, 0);
        addTitle(sheet, "发标截止", 6, 0);
        addTitle(sheet, "限价（万元）", 7, 0);
        addTitle(sheet, "开标", 8, 0);
        addTitle(sheet, "技术评标", 9, 0);
        addTitle(sheet, "商务标开标", 10, 0);
        addTitle(sheet, "商务评标", 11, 0);
        addTitle(sheet, "投标单位", 12, 0);


        for (int c = 0; c < bidPlanList.size(); c++) {
            int cIndex = c * 4 + 2;
            mapPlanCell.put(bidPlanList.get(c).getBiddingPlanId(), cIndex);
            if (bidPlanList.get(c).getRouteName() != null) {
                sheet.getRow(1).createCell(cIndex).setCellValue(judged(bidPlanList.get(c).getRouteName()));

            } else {
                sheet.getRow(1).createCell(cIndex).setCellValue("");
            }
            sheet.getRow(2).setHeight((short) 1000);
            if (bidPlanList.get(c).getBiddingName() != null) {
                if("1".equals(bidPlanList.get(c).getBidType()))
                sheet.getRow(2).createCell(cIndex).setCellValue(judged(bidPlanList.get(c).getBiddingName()));
                else
                    sheet.getRow(2).createCell(cIndex).setCellValue(judged("集中采购"));
            } else {
                sheet.getRow(2).createCell(cIndex).setCellValue("");
            }
            if (bidPlanList.get(c).getApplyDate() != null)
                sheet.getRow(3).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getApplyDate(), "yyyy年MM月dd日")));
            else
                sheet.getRow(3).createCell(cIndex).setCellValue("");

            if ("1".equals(bidPlanList.get(c).getHasCheck())) {
                if (bidPlanList.get(c).getCheckDate() != null)
                    sheet.getRow(4).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getCheckDate(), "yyyy年MM月dd日")));
                else
                    sheet.getRow(4).createCell(cIndex).setCellValue("");
            } else
                sheet.getRow(4).createCell(cIndex).setCellValue("无资格预审");
            if (bidPlanList.get(c).getBidBegin() != null)
                sheet.getRow(5).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getBidBegin(), "yyyy年MM月dd日")));
            else
                sheet.getRow(5).createCell(cIndex).setCellValue("");
            if (bidPlanList.get(c).getBidEnd() != null)
                sheet.getRow(6).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getBidEnd(), "yyyy年MM月dd日")));
            else
                sheet.getRow(6).createCell(cIndex).setCellValue("");
            if (bidPlanList.get(c).getLimitPrice() != null)
                sheet.getRow(7).createCell(cIndex).setCellValue(bidPlanList.get(c).getLimitPrice().doubleValue());

            if (bidPlanList.get(c).getHasLimit() == null || "0".equals(bidPlanList.get(c).getHasLimit()))
                sheet.getRow(7).createCell(cIndex).setCellValue(judged("无限价"));
            else {
                if (bidPlanList.get(c).getLimitPrice() != null)
                    sheet.getRow(7).createCell(cIndex).setCellValue(bidPlanList.get(c).getLimitPrice().doubleValue());
                else
                    sheet.getRow(7).createCell(cIndex).setCellValue(judged(""));
            }

            if (bidPlanList.get(c).getTecOpenDate() != null)
                sheet.getRow(8).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getTecOpenDate(), "yyyy年MM月dd日")));
            else
                sheet.getRow(8).createCell(cIndex).setCellValue("");
            if (bidPlanList.get(c).getTecAppraiseDate() != null)
                sheet.getRow(9).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getTecAppraiseDate(), "yyyy年MM月dd日")));
            else
                sheet.getRow(9).createCell(cIndex).setCellValue("");
            if (bidPlanList.get(c).getBizOpenDate() != null)
                sheet.getRow(10).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getBizOpenDate(), "yyyy年MM月dd日")));
            else
                sheet.getRow(10).createCell(cIndex).setCellValue("");
            if (bidPlanList.get(c).getBizAppraiseDate() != null)
                sheet.getRow(11).createCell(cIndex).setCellValue(judged(DateFormatUtils.format(bidPlanList.get(c).getBizAppraiseDate(), "yyyy年MM月dd日")));
            else
                sheet.getRow(11).createCell(cIndex).setCellValue("");
            for (int x = 0; x < 4; x++) {
                sheet.getRow(12).createCell(cIndex).setCellValue("报名");
                sheet.getRow(12).createCell(cIndex + 1).setCellValue("资审");
                sheet.getRow(12).createCell(cIndex + 2).setCellValue("投标价");
                sheet.getRow(12).createCell(cIndex + 3).setCellValue("中标价");

                sheet.getRow(12).getCell(cIndex).setCellStyle(getDefaultCellStyle(workbook));
                sheet.getRow(12).getCell(cIndex + 1).setCellStyle(getDefaultCellStyle(workbook));
                sheet.getRow(12).getCell(cIndex + 2).setCellStyle(getDefaultCellStyle(workbook));
                sheet.getRow(12).getCell(cIndex + 3).setCellStyle(getDefaultCellStyle(workbook));

            }

            for (int rIndex = 1; rIndex < 12; rIndex++) {
                CellRangeAddress range = new CellRangeAddress(rIndex, rIndex, cIndex, cIndex + 3);
                sheet.addMergedRegion(range);
            }

            for (int i = 1; i < 12; i++) {
                sheet.getRow(i).getCell(cIndex).setCellStyle(getDefaultCellStyle(workbook));
            }
        }

        for (BidResult result : bidResultList) {
            if (!mapPlanCell.containsKey(result.getBiddingPlanId())) {
                continue;
            }

            Integer cIndex = mapPlanCell.get(result.getBiddingPlanId());
            Integer rIndex = 0;

            if (mapCompanyRow.containsKey(result.getCompanyId())) {
                rIndex = mapCompanyRow.get(result.getCompanyId());
            } else {
                mapCompanyRow.put(result.getCompanyId(), sheet.getLastRowNum() + 1);
                rIndex = sheet.getLastRowNum() + 1;
                XSSFRow row = sheet.createRow(sheet.getLastRowNum() + 1);
                row.setHeight((short) 500);
                if (result.getCompany() != null) {
                    row.createCell(0).setCellValue(judged(result.getCompany().getGroups()));
                    row.createCell(1).setCellValue(judged(result.getCompany().getCompanyName()));
                } else {
                    row.createCell(0).setCellValue("");
                    row.createCell(1).setCellValue("");
                }
                row.getCell(0).setCellStyle(getLeftCellStyle(workbook));
                row.getCell(1).setCellStyle(getLeftCellStyle(workbook));

                sheet.autoSizeColumn(0);
                sheet.autoSizeColumn(1);
            }

            if (cIndex != null && rIndex != null) {
                sheet.getRow(rIndex).createCell(cIndex).setCellValue("报名");
                sheet.getRow(rIndex).getCell(cIndex).setCellStyle(getDefaultCellStyle(workbook));

                if (result.getPrePrice() != null && result.getPrePrice().doubleValue() > 0) {
                    sheet.getRow(rIndex).createCell(cIndex + 2).setCellValue(result.getPrePrice().doubleValue());
                } else
                    sheet.getRow(rIndex).createCell(cIndex + 2).setCellValue("");
                sheet.getRow(rIndex).getCell(cIndex + 2).setCellStyle(getNumbericCellStyle(workbook));

                if (StringUtils.isNotBlank(result.getIsApplicant()))
                    sheet.getRow(rIndex).createCell(cIndex + 1).setCellValue(result.getIsApplicant());
                else
                    sheet.getRow(rIndex).createCell(cIndex + 1).setCellValue("");

                sheet.getRow(rIndex).getCell(cIndex + 1).setCellStyle(getDefaultCellStyle(workbook));
                if (result.getFinalPrice() != null && result.getFinalPrice().doubleValue() > 0) {
                    sheet.getRow(rIndex).createCell(cIndex + 3).setCellValue(result.getFinalPrice().doubleValue());
                } else
                    sheet.getRow(rIndex).createCell(cIndex + 3).setCellValue("");

                sheet.getRow(rIndex).getCell(cIndex + 3).setCellStyle(getNumbericCellStyle(workbook));
            }
        }


        XSSFRow statisticsRow = sheet.createRow(sheet.getLastRowNum() + 1);
        statisticsRow.setHeight((short) 500);
        statisticsRow.createCell(1).setCellValue("小计");
        statisticsRow.getCell(1).setCellStyle(getTitleStyle(workbook));

        for (Map result : statistics) {


            if (!mapPlanCell.containsKey(result.get("biddingPlanId"))) {
                continue;
            }

            Integer cIndex = mapPlanCell.get(result.get("biddingPlanId"));
            statisticsRow.createCell(cIndex).setCellValue(((BigDecimal) result.get("applyNum")).intValue());

            statisticsRow.getCell(cIndex).setCellStyle(getDefaultCellStyle(workbook));


            if (((BigDecimal) result.get("isApplicant")) != null)
                statisticsRow.createCell(cIndex + 1).setCellValue(((BigDecimal) result.get("isApplicant")).longValue());
            else
                statisticsRow.createCell(cIndex + 1).setCellValue("");

            statisticsRow.getCell(cIndex + 1).setCellStyle(getDefaultCellStyle(workbook));

            if (((BigDecimal) result.get("prePrice")) != null)
                statisticsRow.createCell(cIndex + 2).setCellValue(((BigDecimal) result.get("prePrice")).doubleValue());
            else
                statisticsRow.createCell(cIndex + 2).setCellValue("");

            statisticsRow.getCell(cIndex + 2).setCellStyle(getNumbericCellStyle(workbook));


            if (((BigDecimal) result.get("finalPrice")) != null)
                statisticsRow.createCell(cIndex + 3).setCellValue(((BigDecimal) result.get("finalPrice")).doubleValue());
            else
                statisticsRow.createCell(cIndex + 3).setCellValue("");
            statisticsRow.getCell(cIndex + 3).setCellStyle(getNumbericCellStyle(workbook));
        }
    }

    private void addSheetTitle(XSSFSheet sheet, String title) {
        CellStyle css = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short) 12);
        font.setFontName("宋体");
        font.setColor(HSSFColor.BLACK.index);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        css.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        css.setFont(font); //调用字体样式对象

        css.setWrapText(true);
        sheet.createRow(0).createCell(0).setCellStyle(css);
        sheet.getRow(0).getCell(0).setCellValue(title);
        sheet.getRow(0).setHeight((short) 500);
        CellRangeAddress range = new CellRangeAddress(0, 0, 0, 255);
        sheet.addMergedRegion(range);
    }

    private void addTitle(XSSFSheet sheet, String title, int row, int cell) {
        sheet.createRow(row).createCell(cell).setCellStyle(getTitleStyle(workbook));
        sheet.getRow(row).getCell(cell).setCellValue(title);
        sheet.getRow(row).setHeight((short) 500);
        CellRangeAddress range = new CellRangeAddress(row, row, cell, cell + 1);
        sheet.addMergedRegion(range);
    }

    private String judged(String str) {
        if (str == null) {
            return "";
        }
        return str;
    }

    private XSSFCellStyle defaultCss;
    private XSSFCellStyle titleCss;
    private XSSFCellStyle numbericCss;
    private XSSFCellStyle leftCss;

    private XSSFCellStyle getLeftCellStyle(XSSFWorkbook workbook) {
        if (leftCss == null) {
            leftCss = workbook.createCellStyle();
            XSSFFont font = workbook.createFont();
            font.setFontHeightInPoints((short) 9);
            font.setFontName("宋体");
            font.setColor(HSSFColor.BLACK.index);
            font.setBoldweight((short) 0.8);
            leftCss.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            leftCss.setFont(font); //调用字体样式对象

            leftCss.setWrapText(true);
        }


        return leftCss;

    }

    private XSSFCellStyle getNumbericCellStyle(XSSFWorkbook workbook) {
        if (numbericCss == null) {
            numbericCss = workbook.createCellStyle();
            XSSFFont font = workbook.createFont();
            font.setFontHeightInPoints((short) 9);
            font.setFontName("宋体");
            font.setColor(HSSFColor.BLACK.index);
            font.setBoldweight((short) 0.8);
            numbericCss.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
            numbericCss.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            numbericCss.setFont(font); //调用字体样式对象

            numbericCss.setWrapText(true);
            XSSFDataFormat format = workbook.createDataFormat();
            numbericCss.setDataFormat(format.getFormat("#,##0.0000"));
        }


        return numbericCss;

    }

    private XSSFCellStyle getDefaultCellStyle(XSSFWorkbook workbook) {

        if (defaultCss == null) {
            defaultCss = workbook.createCellStyle();
            XSSFFont font = workbook.createFont();
            font.setFontHeightInPoints((short) 9);
            font.setFontName("宋体");
            font.setColor(HSSFColor.BLACK.index);
            font.setBoldweight((short) 0.8);
            defaultCss.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            defaultCss.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            defaultCss.setFont(font); //调用字体样式对象

            defaultCss.setWrapText(true);
        }


        return defaultCss;
    }

    private XSSFCellStyle getTitleStyle(XSSFWorkbook workbook) {

        if (titleCss == null) {
            titleCss = workbook.createCellStyle();
            XSSFFont font = workbook.createFont();
            font.setFontHeightInPoints((short) 9);
            font.setFontName("宋体");
            font.setColor(HSSFColor.BLACK.index);
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleCss.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            titleCss.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleCss.setFont(font); //调用字体样式对象

            titleCss.setWrapText(true);
        }


        return titleCss;
    }

}
