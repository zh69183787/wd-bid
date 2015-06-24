package com.wonders.stpt.bid.service;

import java.util.List;

import com.wonders.stpt.bid.domain.BidImportMain;

public interface IBidImportMainService {

	
	List<BidImportMain> getBos(BidImportMain bidImportMain,int pageIndex,int pageSize)throws Exception;

	BidImportMain getBo(String bidImportMainId)throws Exception;

    int delete(String bidImportMainId)throws Exception;

    BidImportMain save(BidImportMain bidImportMain)throws Exception;
    
    /**
	 * 新增实体  自己生成uid
	 * @param entity
	 * @return
	 * @throws Exception
	 */
    public int insertWithMainId(BidImportMain bidImportMain) throws Exception;

	int deleteAttachment(String mainId) throws Exception;
}
