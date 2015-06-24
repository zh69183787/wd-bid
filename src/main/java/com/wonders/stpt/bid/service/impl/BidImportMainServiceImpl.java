package com.wonders.stpt.bid.service.impl;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wonders.stpt.bid.dao.BidImportDao;
import com.wonders.stpt.bid.dao.BidImportMainDao;
import com.wonders.stpt.bid.domain.Attachment;
import com.wonders.stpt.bid.domain.BidImportMain;
import com.wonders.stpt.bid.service.IAttachmentService;
import com.wonders.stpt.bid.service.IBidImportMainService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;
@Service
public class BidImportMainServiceImpl implements IBidImportMainService {

	@Autowired
	private BidImportMainDao bidImportMainDao;
	
	@Autowired
    private IAttachmentService attachmentService;
	
	@Autowired
	private BidImportDao bidImportDao;
	
	@Override
	public List<BidImportMain> getBos(BidImportMain bidImportMain, int pageIndex,
			int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return bidImportMainDao.select(bidImportMain, pageIndex, pageSize);
	}

	@Override
	public BidImportMain getBo(String bidImportMainId) throws Exception {
		// TODO Auto-generated method stub
		return bidImportMainDao.selectById(bidImportMainId);
	}

	@Override
	public int delete(String bidImportMainId) throws Exception {
		// TODO Auto-generated method stub
		return bidImportMainDao.delete(bidImportMainId);
	}

	@Override
	public BidImportMain save(BidImportMain bidImportMain) throws Exception {
		// TODO Auto-generated method stub
		
		Attachment attachment = attachmentService.getAttachment(bidImportMain.getFilePath());
		if(attachment!=null&&attachment.getRemoved()!=null&&attachment.getRemoved().equals("1")){
			bidImportMain.setFilePath(attachment.getAttachmentId());
			bidImportMain.setFileName(attachment.getAttachName());
		}else{
			bidImportMain.setFilePath(null);
			bidImportMain.setFileName(null);
		}
		
		
		
		if(StringUtils.isBlank(bidImportMain.getMainId())){//新增
			bidImportMainDao.insert(bidImportMain);
		}else{
			bidImportMainDao.update(bidImportMain);
		}
		return bidImportMain;
	}

	@Override
	public int insertWithMainId(BidImportMain bidImportMain) throws Exception {
		bidImportMainDao.insertWithMainId(bidImportMain);
		return 0;
	}

	
	@Override
	public int deleteAttachment(String mainId) throws Exception {
		if(mainId==null) return -1;
		BidImportMain bidImportMain = bidImportMainDao.selectById(mainId);
		if(bidImportMain==null||bidImportMain.getFilePath()==null||bidImportMain.getFilePath().equals("")) return -1;
		
		attachmentService.delete(bidImportMain.getFilePath());
		bidImportMain.setFilePath(null);
		bidImportMain.setFileName(null);
		bidImportMain.setIsUpdate("0");
		bidImportMainDao.update(bidImportMain);
		bidImportDao.deleteByMainId(mainId);
		return 1;
	}


}
