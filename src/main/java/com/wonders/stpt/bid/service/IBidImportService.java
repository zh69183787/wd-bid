package com.wonders.stpt.bid.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.wonders.stpt.bid.domain.BidImport;
import com.wonders.stpt.bid.domain.BidImportMain;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.domain.Route;

public interface IBidImportService {

	
	List<BidImport> getBidImports(BidImport bidding,int pageIndex,int pageSize)throws Exception;

    BidImport getBidImport(String biddingId)throws Exception;

    int delete(String biddingId)throws Exception;

    BidImport save(BidImport bidding)throws Exception;
    
    Map<String,Object> saveComplete(BidImport bidImport,Bidding didding)throws Exception;
    /**
     * 模糊查询
     * @param bidding
     * @return
     * @throws Exception
     */
    List<BidImport> selectfuzzy(BidImport bidding)throws Exception;
    
    

    Map<String,Object> importExcel(BidImportMain bidImportMain, List<Route> routes,File file,Map<String,Object> map)throws Exception;
	
	
	Map<String,Object> completeData(BidImport bidImport)throws Exception;
	
}
