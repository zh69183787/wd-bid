package com.wonders.stpt.bid.controller;


import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wonders.stpt.bid.domain.BidChange;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.service.IBidChangeService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;

@Controller
@RequestMapping("/bidding/change")
public class BidChangeController extends BaseController{
	@Autowired
    private IBidChangeService bidChangeService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/changings")
    public void changings(BidChange bidChange,
            @RequestParam(required = false, defaultValue = "1") int pageIndex,
            @RequestParam(required = false, defaultValue = "15") int pageSize, Model model) throws Exception {

		if(!hasAdminRole()){
			bidChange.setCreator(getUserInfo().getUserId());
        }
    	List<BidChange> bidChanges =  bidChangeService.getBidChanges(bidChange,pageIndex,pageSize);
        model.addAttribute("bidChanges", bidChanges);
        model.addAttribute("biddingId", bidChange.getBidding().getBiddingId());
        model.addAttribute("pageInfo", ((PageList) bidChanges).getPageInfo());
    }
    
	@RequestMapping(method = RequestMethod.GET, value = "/form")
    public String inputChange(BidChange bidChange, Model model) throws Exception {
        //model.addAttribute("route", routeService.getRoutes(route, 1, Integer.MAX_VALUE));
        return "bidding/bidding_change";
    }
    
    /**
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/{changeId}/delete")
    public String delete(@PathVariable String changeId,String hideHeader) throws Exception {
        BidChange change = bidChangeService.getBidChange(changeId);
        if(change!=null){
        	change.setRemoved("1");
            bidChangeService.save(change);
        }

        return "redirect:/bidding/change/changings?bidding.biddingId="+change.getBidding().getBiddingId()+"&hideHeader="+hideHeader;
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/save")
    public String save(BidChange bidChange,String hideHeader) throws Exception {
    	bidChangeService.save(bidChange);
    	return "redirect:/bidding/change/changings?bidding.biddingId="+bidChange.getBidding().getBiddingId()+"&hideHeader="+hideHeader;
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/{changeId}")
    public void bidChange(@PathVariable String changeId,Model model) throws Exception{
    	BidChange bidChange = bidChangeService.getBidChange(changeId);
    	model.addAttribute("change",bidChange);
    }
}
