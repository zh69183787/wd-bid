 package com.wonders.stpt.bid.controller;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wonders.stpt.bid.domain.Attachment;
import com.wonders.stpt.bid.domain.BidCompany;
import com.wonders.stpt.bid.domain.BidImport;
import com.wonders.stpt.bid.domain.BidImportMain;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.domain.vo.BidImportState;
import com.wonders.stpt.bid.service.IAttachmentService;
import com.wonders.stpt.bid.service.IBidCompanyService;
import com.wonders.stpt.bid.service.IBidImportMainService;
import com.wonders.stpt.bid.service.IBidImportService;
import com.wonders.stpt.bid.service.IRouteService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;


@Controller
@RequestMapping("/bidimportmain")
public class BidImportMainController extends BaseController {

    private final Logger logger = Logger.getLogger(BidImportMainController.class);

    @Autowired
    private IBidImportMainService bidImportMainService;
    @Autowired
    private IBidImportService bidImportService;
    @Autowired
    private IBidCompanyService bidCompanyService;
    
    @Autowired
    private IRouteService routeService;
    
	@Autowired
    private IAttachmentService attachmentService;

    @RequestMapping(method = RequestMethod.GET, value = "/form")
    public String input(BidImportMain bidImportMain, Model model) throws Exception {

        bidImportMain.setCreateTime(new Date());
        bidImportMain.setMainId(UUID.randomUUID().toString().replaceAll("-", ""));
        List<BidCompany> companys = bidCompanyService.getCompanies(new BidCompany(), 1, Integer.MAX_VALUE);
        model.addAttribute("companys",companys);
        model.addAttribute("bidImportMain",bidImportMain);
        model.addAttribute("today",new Date());
        return "bidimport/bidimport_main_save";
    }
    
    /**
     * 查看 及 处理导入计划
     * @param bidImportMain
     * @param model
     * @param mainId
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/plan")
    public String view(BidImportMain bidImportMain, Model model,@RequestParam(required = false, value = "mainId") String mainId) throws Exception {
    	bidImportMain = bidImportMainService.getBo(mainId);
        model.addAttribute("bidImportMain",bidImportMain);
        return "bidimport/bidimport_plan";
    }
    
    
    /**
     * 招标计划文件导入数据库
     * @param bidImportMain
     * @param model
     * @param mainId
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/importData")
    public void importData(BidImportMain bidImportMain, Model model,@RequestParam(required = true, value = "mainId") String mainId,
    		@RequestParam(required = false, value = "filePath") String filePath,HttpServletRequest request) throws Exception {
    	long startTime=System.currentTimeMillis();
    	bidImportMain = bidImportMainService.getBo(mainId);
    	Map<String,Object> map = new HashMap<String,Object>();
    	List<Route> routes = routeService.getList();//.getRoutes(new Route(), 1, Integer.MAX_VALUE);
    	Attachment attachment  = attachmentService.getAttachment(bidImportMain.getFilePath());
    	if(attachment==null){
    		map.put("error", "请上传需要导入数据库的文件！");
    		model.addAttribute("map", map);
    		return;
    	}
    	
		File file =new File(request.getSession().getServletContext().getRealPath("/WEB-INF/upload/" + attachment.getAttachmentId()+"."+attachment.getAttachExtName()));
		
    	map = bidImportService.importExcel(bidImportMain,routes,file,map);
    	
    	long endTime=System.currentTimeMillis();
    	Object  num = map.get("totalNum")==null?"0":map.get("totalNum");
    	long time = (endTime-startTime)/1000l;
    	map.put("ok"," 成功导入:"+num+"条记录,共耗时:"+time+"s !");
    	//List<BidImport> bidImports = new ArrayList<BidImport>();
    	model.addAttribute("map", map);
        //return "redirect:/bidimport/plan?mainId=" + mainId;
    }

   /* *//**
     * 获取所有的线路
     *
     * @param route
     * @param model
     * @return
     * @throws Exception
     *//*
    @RequestMapping(method = RequestMethod.GET, value = "/routeList")
    public void routeList(Route route, Model model) throws Exception {
        List<Route> routes = routeService.getRoutes(route, 1, Integer.MAX_VALUE);
        model.addAttribute("route", routes);
        //return "bidImportMain/bidding_save";
    }*/

    /**
     * 查询
     *
     * @param bidImportMain
     * @param model
     */
    @RequestMapping(method = RequestMethod.GET, value = "/bidImportMains")
    public String bidImportMains(BidImportMain bidImportMain, @RequestParam(required = false, value = "companyIds[]") String[] companyIds,
                         @RequestParam(required = false, defaultValue = "1") int pageIndex,
                         @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (companyIds != null && companyIds.length == 1) {
            bidImportMain.setCompanyId(companyIds[0]);
        }

       /* if (!hasAdminRole()) {
            if (bidImportMain.getRoute() == null)
                bidImportMain.setRoute(new Route());

            bidImportMain.getRoute().setCreator(getUserInfo().getUserId());
        }*/

        List<BidImportMain> bidImportMains = bidImportMainService.getBos(bidImportMain, pageIndex, pageSize);
        model.addAttribute("bidImportMains", bidImportMains);
        model.addAttribute("pageInfo", ((PageList) bidImportMains).getPageInfo());
        return "bidimport/bidimport_mains";
    }

   
    /**
     * 保存
     *
     * @param bidImportMain
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/save")
    public String save(BidImportMain bidImportMain, @RequestParam(required = false, defaultValue = "1") int pageIndex, @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {
        if (StringUtils.isBlank(bidImportMain.getMainId())) {
            bidImportMain.setUpdateTime(new Date());
            bidImportMain.setRemoved("0");
            bidImportMain.setUpdater(getUserInfo().getUserId());
            bidImportMain.setCreator(getUserInfo().getUserId());
            bidImportMainService.save(bidImportMain);

        } else {
            BidImportMain b = bidImportMainService.getBo(bidImportMain.getMainId());
            if(b==null){
            	bidImportMain.setUpdateTime(new Date());
                bidImportMain.setRemoved("0");
                bidImportMain.setUpdater(getUserInfo().getUserId());
                bidImportMain.setCreator(getUserInfo().getUserId());
                bidImportMainService.insertWithMainId(bidImportMain);
            }else{
            	 b.setUpdater(getUserInfo().getUserId());
                 BeanUtils.copyProperties(bidImportMain, b, "updater");
                 bidImportMainService.save(b);
            }
//            access(b.getRouteId());
           
            return "redirect:/bidimportmain/bidImportMains?pageIndex=" + pageIndex + "&pageSize=" + pageSize;
        }

        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("bidImportMain", bidImportMain);
        return "redirect:/bidimportmain/bidImportMains?pageIndex=" + 1 + "&pageSize=" + 15;
    }



    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/delete")
    public String delete(@PathVariable String biddingId) throws Exception {

        return "redirect:/bidimportmain/bidImportMains?pageIndex=" + 1 + "&pageSize=" + 15;
    }
    
    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/deleteAtta")
    public void deleteAtta(@RequestParam(required = false) String mainId, Model model) throws Exception {
    	int i =  bidImportMainService.deleteAttachment(mainId);
    	
    	if(i >= 0){
    		
    		model.addAttribute("msg", "ok");
    		model.addAttribute("len", i);
    	}else{
    		model.addAttribute("msg", "error");
    		model.addAttribute("len", i);
    	}
        
    }

    /**
     * 根据biddingId查找记录
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{mainId}")
    public String bidImportMain(@PathVariable String mainId, Model model, @RequestParam(required = false, defaultValue = "1") int pageIndex,
                          @RequestParam(required = false, defaultValue = "15") int pageSize) throws Exception {
        BidImportMain bidImportMain = bidImportMainService.getBo(mainId);
        model.addAttribute("bidImportMain", bidImportMain);
//        access(bidImportMain.getRouteId());
        model.addAttribute("pageIndex", pageIndex);
        model.addAttribute("pageSize", pageSize);
        return "bidimport/bidimport_main_save";
    }


}
