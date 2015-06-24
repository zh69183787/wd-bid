package com.wonders.stpt.bid.controller;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.service.IBidCompanyService;
import com.wonders.stpt.bid.utils.Context;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;

/**
 * Created by Administrator on 2014/7/11.
 */
@Controller
@RequestMapping("/company")
public class CompanyController extends  BaseController{
    @Autowired
    private IBidCompanyService companyService;
    
    
	
	@RequestMapping(method=RequestMethod.GET,value="/form")
    public String input(){
    	
    	return "company/company_save";
    }
    /**
     * 保存单位
     * @param bidCompany
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method=RequestMethod.POST,value="/save")
    public String save(BidCompany bidCompany,@RequestParam(required=false)int pageIndex,Model model)throws Exception{
//    	if(StringUtils.isNotBlank(bidCompany.getCompanyName()))
//    		bidCompany.setCompanyName(new String(bidCompany.getCompanyName().getBytes("utf-8"),"iso-8859-1"));
        if("请选择".equals(bidCompany.getGroups())){
            bidCompany.setGroups("");
        }
    	if(validate(bidCompany)||"1".equals(bidCompany.getRemoved()))
    	if(StringUtils.isBlank(bidCompany.getCompanyId())){//新增
    		bidCompany.setCreateTime(new Date());
    		bidCompany.setUpdateTime(new Date());
    		bidCompany.setRemoved("0");
            bidCompany.setCreator(getUserInfo().getUserId());
            bidCompany.setUpdater(getUserInfo().getUserId());
    		companyService.save(bidCompany);
    	}else{
    		BidCompany nbidCompany=companyService.getBidCompany(bidCompany.getCompanyId());
    		BeanUtils.copyProperties(bidCompany, nbidCompany, "updater");
            nbidCompany.setUpdater(getUserInfo().getUserId());
    		companyService.save(nbidCompany);
    	}
    	return "redirect:/company/company_list?pageIndex="+pageIndex;
    }
    
    /**
     * 分页查询
     * @param bidCompany
     * @param pageIndex
     * @param pageSize
     * @param model
     * @throws Exception
     */
    @RequestMapping(method=RequestMethod.GET,value="/company_list")
    public void companyList(BidCompany bidCompany,@RequestParam(required = false, defaultValue = "1") int pageIndex,
            @RequestParam(required = false, defaultValue = "15") int pageSize, Model model)throws Exception{
//        if(hasAdminRole()){
//            bidCompany.setCreator(getUserInfo().getUserId());
//        }
        if("请选择".equals(bidCompany.getGroups())){
            bidCompany.setGroups("");
        }
        if("请选择".equals(bidCompany.getTrade())){
            bidCompany.setTrade("");
        }
    	List companies=companyService.getCompanies(bidCompany, pageIndex, pageSize);

    	model.addAttribute("bidCompany", bidCompany);
		model.addAttribute("companies", companies);
    	model.addAttribute("pageInfo", ((PageList) companies).getPageInfo());
    }
    /**
     * 去重判断
     * @param bidCompany
     * @param model
     */
    @RequestMapping(method=RequestMethod.POST,value="/compare")
    public void compare(BidCompany bidCompany,Model model)throws Exception{
    	if(validate(bidCompany)){
    		model.addAttribute("msg", "yes");
    	}else{
    		model.addAttribute("msg", "no");
    	}
    }
    
    private Boolean validate(BidCompany bidCompany)throws Exception{
//    	if(StringUtils.isNotBlank(bidCompany.getCompanyName()))
//    		bidCompany.setCompanyName(new String(bidCompany.getCompanyName().getBytes("iso-8859-1"),"utf-8"));
    	if(StringUtils.isBlank(bidCompany.getCompanyId())){//新增
    		List list=companyService.getCompanies(bidCompany, 1, Integer.MAX_VALUE);
    		if(list.size()>0){
    			return false;
    		}
    	}else{
    		String companyId=bidCompany.getCompanyId();
    		bidCompany.setCompanyId(null);
    		List list=companyService.getCompanies(bidCompany, 1, Integer.MAX_VALUE);
    		bidCompany.setCompanyId(companyId);
    		if(list.size()>1){
    			return false;
    		}else if(list.size()==1&&!companyId.equals(((BidCompany)list.get(0)).getCompanyId()))
    			return false;
    	}
    	
    	return true;
    }
    
    /**
     *根据中主键查询记录
     * @param companyId
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method=RequestMethod.GET,value="/{companyId}")
    public String company(@PathVariable String companyId,Model model)throws Exception{
    	model.addAttribute("company", companyService.getBidCompany(companyId));
    	return "company/company_save";
    }
    /**
     *根据中主键查询记录
     * @param companyId
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method=RequestMethod.GET,value="/companyEdit")
    public String companyEdit(@RequestParam(required=true)String companyId,@RequestParam(required=false,defaultValue = "1")int pageIndex,@RequestParam(required=false,defaultValue = "15")int pageSize,Model model)throws Exception{
    	model.addAttribute("company", companyService.getBidCompany(companyId));
    	model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("pageSize", pageSize);
    	return "company/company_save";
    }
    /**
     * 投标单位导出
     * @param bidCompany
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method=RequestMethod.GET,value="/export")
    public void export(BidCompany bidCompany,Model model,HttpServletResponse response)throws Exception{

    	List companyList=companyService.getCompanies(bidCompany, 1, Integer.MAX_VALUE);
    	model.addAttribute("company", companyList);
    	HashMap map=new HashMap();
    	map.put("company", companyList);
    	
		// 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename="
                + URLEncoder.encode("投标单位"+".xls", "UTF-8"));
        OutputStream os = response.getOutputStream();
        Context context = new Context();
        org.apache.poi.ss.usermodel.Workbook wb = context.output(this.getClass().getResourceAsStream("/templateCompany.xls"), map);
        wb.write(os);
        os.flush();
        os.close();
        //return "company/company_list";
    }


    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{companyId}/delete")
    public String delete(@PathVariable String companyId) throws Exception {
        BidCompany company = companyService.getBidCompany(companyId);
        if(company!=null){
            company.setRemoved("1");
            companyService.save(company);
        }

        return "redirect:/company/company_list";
    }
    
}
