package com.wonders.stpt.bid.controller;

import com.wonders.stpt.bid.domain.BidImport;
import com.wonders.stpt.bid.domain.Dictionary;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.service.IDictionaryService;
import com.wonders.stpt.bid.utils.CacheMap;
import com.wonders.stpt.bid.utils.DateUtils;
import com.wonders.stpt.bid.utils.ReadExcel;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;

import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2014/11/1.
 */
@Controller
@RequestMapping("/dictionary")
public class DictionaryController extends BaseController {
    private final Logger logger = Logger.getLogger(DictionaryController.class);

    @Autowired
    private IDictionaryService dictionaryService;

    @RequestMapping(method = RequestMethod.GET, value = "/{dictType}/{dictId}")
    public String dictionary(@PathVariable String dictId, @PathVariable String dictType, Model model) throws Exception {
        dictionaryService.getDictionary(dictId);
        return "dictionary/dictionaries";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/index")
    public String index(Dictionary dictionary, Model model, String id) throws Exception {
        return "/dictionary/dictionaries";
    }
    
    /**
     * 导入excel中数据  写死的方法暂不参考使用
     * 该方法停用  保留 20150203
     * @param dictionary
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/importExcel")
    public String importExcel(Dictionary dictionary, Model model) throws Exception {
    	try {
			Workbook workbook = WorkbookFactory.create(new FileInputStream(new File("D:\\96.xlsx")));
			Sheet sheet = workbook.getSheetAt(0);
			int startRowNum = sheet.getFirstRowNum();
			int endRowNum = sheet.getLastRowNum();
			int maxr = dictionaryService.getMaxDictNo();
			Dictionary cellast1 = new Dictionary();cellast1.setDictName("0");cellast1.setDictOrder(0);
			Dictionary cellast2 = new Dictionary();cellast2.setDictName("0");cellast2.setDictOrder(0);
			Dictionary cellast3 = new Dictionary();cellast3.setDictName("0");cellast3.setDictOrder(0);
			Dictionary cellast4 = new Dictionary();cellast4.setDictName("0");cellast4.setDictOrder(0);
			int index1 =1;int index2 =1;int index4 =1;int index3 =1;
			for (int rowNum = startRowNum; rowNum <= endRowNum; rowNum++) {
				Row row = sheet.getRow(rowNum);
				if (row == null){
					continue;
				}
				int startCellNum = row.getFirstCellNum();
				int endCellNum = row.getLastCellNum();
				String type1 = ReadExcel.getCellStringValue(row.getCell(0));
				String type2 = ReadExcel.getCellStringValue(row.getCell(1));
				String type3 = ReadExcel.getCellStringValue(row.getCell(2));
				String type4 = ReadExcel.getCellStringValue(row.getCell(3));
				String code = ReadExcel.getCellStringValue(row.getCell(4));
				Dictionary d1 = new Dictionary();
				Dictionary d2 = new Dictionary();
				Dictionary d3 = new Dictionary();
				Dictionary d4 = new Dictionary();
				
				if(type1!=null&&!"".equals(type1)&&!cellast1.getDictName().equals(type1)){
					d1.setDictName(type1);
					d1.setDictType("bidTypes");
					d1.setParentNo("80");
					d1.setDictCode(code.substring(0,1));
					d1.setDictFullCode(code.substring(0,1));
					d1.setDictFullName(type1);
					d1.setDictOrder(cellast1.getDictOrder()+1);
					maxr++;
					d1.setDictNo(maxr+"");
					dictionaryService.save(d1);
					index1++;
					index2 =1; index4 =1; index3 =1;
					cellast1 = d1;
					cellast2 = new Dictionary();cellast2.setDictOrder(0);cellast2.setDictName("0");
					cellast3 = new Dictionary();cellast3.setDictOrder(0);cellast3.setDictName("0");
					cellast4 = new Dictionary();cellast4.setDictOrder(0);cellast4.setDictName("0");
				}
				
				if(type2!=null&&!"".equals(type2)&&!cellast2.getDictName().equals(type2)){
					d2.setDictName(type2);
					d2.setDictType("bidTypes");
					d2.setParentNo(cellast1.getDictId());
					d2.setDictCode(code.substring(1,2));
					d2.setDictFullCode(code.substring(0,2));
					d2.setDictFullName(cellast1.getDictFullName()+"-"+type2);
					d2.setDictOrder(cellast2.getDictOrder()+1);
					maxr++;
					d2.setDictNo(maxr+"");
					dictionaryService.save(d2);
					index2++;
					index4 =1; index3 =1;
					cellast2 = d2;
					cellast3 = new Dictionary();cellast3.setDictOrder(0);cellast3.setDictName("0");
					cellast4 = new Dictionary();cellast4.setDictOrder(0);cellast4.setDictName("0");
				}
				
				if(type3!=null&&!"".equals(type3)&&!cellast3.getDictName().equals(type3)){
					d3.setDictName(type3);
					d3.setDictType("bidTypes");
					d3.setParentNo(cellast2.getDictId());
					d3.setDictCode(code.substring(2,3));
					d3.setDictFullCode(code.substring(0,3));
					d3.setDictFullName(cellast2.getDictFullName()+"-"+type3);
					d3.setDictOrder(cellast3.getDictOrder()+1);
					maxr++;
					d3.setDictNo(maxr+"");
					dictionaryService.save(d3);
					index3++;
					index4 =1; 
					cellast3 = d3;
					cellast4 = new Dictionary();cellast4.setDictOrder(0);cellast4.setDictName("0");
				}
				
				if(type4!=null&&!"".equals(type4)&&!cellast4.getDictName().equals(type4)){
					d4.setDictName(type4);
					d4.setDictType("bidTypes");
					d4.setParentNo(cellast3.getDictId());
					d4.setDictCode(code.substring(3,4));
					d4.setDictFullCode(code.substring(0,4));
					d4.setDictFullName(cellast3.getDictFullName()+"-"+type4);
					d4.setDictOrder(cellast4.getDictOrder()+1);
					maxr++;
					d4.setDictNo(maxr+"");
					dictionaryService.save(d4);
					index4++;
					cellast4 = d4;
				}
				
			}
			
			
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	return "redirect:/dictionary/index";
    }


    @RequestMapping(method = RequestMethod.GET, value = "/dictionaries")
    public void dictionaries(Dictionary dictionary, Model model, String id) throws Exception {
        dictionary.setParentNo(id);
        List<Dictionary> dictionaries = dictionaryService.getDictionaries(dictionary);

        List list = new ArrayList();
        for (Dictionary dict : dictionaries) {
            Map map = new HashMap();
            map.put("id", dict.getDictId());
            map.put("name", dict.getDictName());
            map.put("dictType", dict.getDictType());
            map.put("dictNo", dict.getDictNo());
            map.put("dictOrder", dict.getDictOrder());
            if (dict.getParentNo() == null)
                map.put("isParent", true);
            else
                map.put("isParent", false);
            list.add(map);
        }
        model.addAttribute("root", list);
        model.addAttribute("maxNo", dictionaryService.getMaxDictNo());
    }
    

    @RequestMapping(method = RequestMethod.GET, value = "/{dictType}/dictionaries")
    public void dictionaries(Dictionary dictionary, @PathVariable String dictType,
                             @RequestParam(required = false, defaultValue = "1") int pageIndex,
                             @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if ("routeType".equals(dictType))
            dictionary.setParentNo("6");
        if ("trade".equals(dictType))
            dictionary.setParentNo("7");
        if ("groups".equals(dictType))
            dictionary.setParentNo("5");

        dictionary.setDictType(dictType);
        List<Dictionary> dictionaries = dictionaryService.getDictionaries(dictionary);
        model.addAttribute("dictionaries", dictionaries);
    }
    
    @SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/{dictType}/dicts")
    public void dictionaries(Dictionary dictionary, @PathVariable String dictType,
                              Model model) throws Exception {
    	if(dictType==null){
    		model.addAttribute("msg", "Error!");
    		return;
    	}
    	//CacheMap.putCache(dictType+"_dictree", null);
    	Object obj = CacheMap.getCache(dictType+"_dictree");
    	List<Dictionary> dictree = null;
    	if(obj==null){
    		List<Dictionary> dictionaries = dictionaryService.selectAllByType(dictType);//.getDictionaries(dictionary);
    		 dictree = new ArrayList<Dictionary>();
    		
    		for(Dictionary node1 : dictionaries){
				boolean mark = false;
				for(Dictionary node2 : dictionaries){
					if(node1.getParentNo()!=null && node1.getParentNo().equals(node2.getDictId())){
						mark = true;
						if(node2.getChildren() == null)
							node2.setChildren(new ArrayList<Dictionary>());
						node2.getChildren().add(node1); 
						break;
					}
				}
				if(!mark){
					dictree.add(node1); 
				}
			}
	        
	        CacheMap.putCache(dictType+"_dictree", dictree);
    	}else{
    		dictree = (List<Dictionary>) obj;
    	}
       
        model.addAttribute("msg", "Ok!");
        model.addAttribute("dictionaries", dictree);
    }

    @RequestMapping(method = RequestMethod.POST)
    public String save(Dictionary dictionary, Model model) throws Exception {
        dictionaryService.save(dictionary);
        model.addAttribute("dictionary", dictionary);
        return null;
    }

    @RequestMapping(method = RequestMethod.DELETE)
    public String delete(Dictionary dictionary, Model model) throws Exception {
        dictionaryService.delete(dictionary.getDictId());
        return null;
    }
}
