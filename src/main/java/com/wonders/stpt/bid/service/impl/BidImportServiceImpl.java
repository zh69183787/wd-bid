package com.wonders.stpt.bid.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wonders.stpt.bid.dao.AttachmentDao;
import com.wonders.stpt.bid.dao.BidImportDao;
import com.wonders.stpt.bid.dao.BidImportMainDao;
import com.wonders.stpt.bid.dao.BiddingDao;
import com.wonders.stpt.bid.dao.RouteDao;
import com.wonders.stpt.bid.domain.Attachment;
import com.wonders.stpt.bid.domain.BidChange;
import com.wonders.stpt.bid.domain.BidImport;
import com.wonders.stpt.bid.domain.BidImportMain;
import com.wonders.stpt.bid.domain.Bidding;
import com.wonders.stpt.bid.domain.Dictionary;
import com.wonders.stpt.bid.domain.Route;
import com.wonders.stpt.bid.domain.vo.BidImportState;
import com.wonders.stpt.bid.service.IAttachmentService;
import com.wonders.stpt.bid.service.IBidChangeService;
import com.wonders.stpt.bid.service.IBidImportService;
import com.wonders.stpt.bid.service.IBiddingService;
import com.wonders.stpt.bid.service.IDictionaryService;
import com.wonders.stpt.bid.utils.DateUtils;
import com.wonders.stpt.bid.utils.ReadExcel;
@Service
public class BidImportServiceImpl implements IBidImportService {

	@Autowired
	private BidImportDao bidImportDao;
	@Autowired
	private BidImportMainDao bidImportMainDao;
	
	@Autowired
	private BiddingDao biddingDao;
	@Autowired
	private RouteDao routeDao;
	@Autowired
	private IDictionaryService dictionaryService;
	
	@Autowired
	private IBidChangeService bidChangeService;
	@Autowired
	private IBiddingService biddingService;
	
	

	
	
	
	
	@Override
	public List<BidImport> getBidImports(BidImport bidImport, int pageIndex,
			int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return bidImportDao.select(bidImport, pageIndex, pageSize);
	}

	@Override
	public BidImport getBidImport(String BiddingId) throws Exception {
		BidImport bid = bidImportDao.selectById(BiddingId);
		if(bid==null) return bid;
		//验证type
		if(bid.getUbiddingTypeId()==null||bid.getUbiddingTypeId().equals("")){
			Dictionary dic = dictionaryService.selectAllByFullName("bidTypes",bid.getFullTypeName());
			if(dic!=null){
				bid.setUbiddingTypeId(dic.getDictFullCode());
				bidImportDao.update(bid);
			}
		}
		return bid;
	}

	@Override
	public int delete(String biddingId) throws Exception {
		// TODO Auto-generated method stub
		return bidImportDao.delete(biddingId);
	}

	@Override
	public BidImport save(BidImport bidImport) throws Exception {
		
		List<Route> routes = routeDao.selectAll();
		
		//获取所有 招标类型的  全名对应的对象集合
		Map<String,Dictionary> dictsMap = dictionaryService.selectNameMapAllByType("bidTypes");
		// 验证数据线路是否正确  根据名字获取id
		Map<String,String> routesMap = new HashMap<String,String>();
		for(Route route:routes){
			routesMap.put(route.getRouteName(), route.getRouteId());
		}
		
		String routeName = bidImport.getRouteName();
		String routeId =null;
		if(routesMap.get(routeName)!=null){
			routeId = routesMap.get(routeName);
		}
		bidImport.setUrouteId(routeId);
		
		if(dictsMap.get(bidImport.getFullTypeName())!=null){//验证招标类型
			bidImport.setUbiddingTypeId(dictsMap.get(bidImport.getFullTypeName()).getDictFullCode());
		}else{
			bidImport.setUbiddingTypeId(null);
		}
		
		
		// TODO Auto-generated method stub
		if(StringUtils.isBlank(bidImport.getBiddingId())){//新增
			bidImportDao.insert(bidImport);
		}else{
			bidImportDao.update(bidImport);
		}
		return bidImport;
	}

	@Override
	public List<BidImport> selectfuzzy(BidImport bidImport) throws Exception {
		// TODO Auto-generated method stub
		return bidImportDao.selectfuzzy(bidImport);
	}

	/* 
	 * excel数据导入数据库
	 * (non-Javadoc)
	 * @see com.wonders.stpt.bid.service.IBidImportService#importExcel(javax.servlet.http.HttpSession, com.wonders.stpt.bid.domain.BidImportMain, java.util.List)
	 */
	@Override
	public Map<String,Object> importExcel(BidImportMain bidImportMain,List<Route> routes,File file,Map<String,Object> map) throws Exception {
		
		//删除mainid 所有数据
		bidImportDao.deleteByMainId(bidImportMain.getMainId());
		
		// 验证数据线路是否正确  根据名字获取id
		Map<String,String> routesMap = new HashMap<String,String>();
		for(Route route:routes){
			routesMap.put(route.getRouteName(), route.getRouteId());
		}
//		List<BidImport> bidImports =new ArrayList<BidImport>();
		
		
		
		
		try {
			Workbook workbook = WorkbookFactory.create(new FileInputStream(file));
			Sheet sheet = workbook.getSheetAt(0);
			
			
			//"序号","线路","子目","类别","专业","标段","标段名","招标方式","标段编码","招标文件完成时间","评标日期"
			Row rowFist = sheet.getRow(0);
			String titleNames[]={"序号","线路","子目","类别","专业","标段","标段名","招标方式","标段编码","招标文件完成时间","评标日期"};
			if(!ReadExcel.correctFormat(titleNames,rowFist)){
				//map.put("error", "导入数据库错误，请检查上传文件格式或内容后重新上传文件！");
				//return map;
			}
			
			
			int startRowNum = sheet.getFirstRowNum()+1;
			int endRowNum = sheet.getLastRowNum();
			int totalImportNum =0;
			
			for (int rowNum = startRowNum; rowNum <= endRowNum; rowNum++) {
				Row row = sheet.getRow(rowNum);
				if (row == null){
					continue;
				}
				int startCellNum = row.getFirstCellNum();
				int endCellNum = row.getLastCellNum();
				String routeName = ReadExcel.getCellStringValue(row.getCell(1));
				if(routeName==null||"".equals(routeName.trim())){
					continue;
				}
				String routeId =null;
				if(routesMap.get(routeName)!=null){
					routeId = routesMap.get(routeName);
				}
				
				String biddingName = ReadExcel.getCellStringValue(row.getCell(6));
				if(biddingName==null||"".equals(biddingName.trim())){
					continue;
				}
				
				String biddingNo = ReadExcel.getCellStringValue(row.getCell(8));
				if(biddingNo==null||"".equals(biddingNo.trim())){
					continue;
				}
				
				BidImport bidImport = new BidImport();
				String sno = ReadExcel.getCellStringValue(row.getCell(0));
				if(sno!=null&&!"".equals(sno.trim())){
					if(sno.indexOf(".")>=0){
						sno = sno.split(".")[0];
					}
				}
				bidImport.setSerialNo(sno);
				bidImport.setRouteName(routeName);
				
				bidImport.setTypeOne(ReadExcel.getCellStringValue(row.getCell(2)));
				bidImport.setTypeTwo(ReadExcel.getCellStringValue(row.getCell(3)));
				bidImport.setTypeThree(ReadExcel.getCellStringValue(row.getCell(4)));
				bidImport.setTypeFour(ReadExcel.getCellStringValue(row.getCell(5)));
				bidImport.setUrouteId(routeId);
				bidImport.setBiddingName(biddingName);
				bidImport.setBidType(ReadExcel.getCellStringValue(row.getCell(7)));
				bidImport.setBiddingNo(biddingNo);
				
				if(row.getCell(9)!=null)
				bidImport.setFileEndDate(DateUtils.parse(ReadExcel.getCellStringValue(row.getCell(9)),DateUtils.FORMAT_SHORT));
				if(row.getCell(10)!=null)
				bidImport.setAppraiseDate(DateUtils.parse(ReadExcel.getCellStringValue(row.getCell(10)),DateUtils.FORMAT_SHORT));
				bidImport.setMainId(bidImportMain.getMainId());
				bidImport.setIsUpdate("0");
				bidImportDao.insert(bidImport);
				totalImportNum ++;
//				bidImports.add(bidImport);
				
			}
			
			
			bidImportMain.setIsUpdate("1"); // 更新状态为  已入库为对比 状态
			bidImportMainDao.update(bidImportMain);
			map.put("totalNum", totalImportNum);
			map.put("ok", "导入数据库成功！");
			// ReadExcel2.readExcel("C:\\Users\\javaloveiphone\\Desktop\\templateyou.xls");
		} catch (InvalidFormatException e) {
			map.put("error", "导入数据库错误，请检查上传文件格式或内容后重新上传文件！");
			e.printStackTrace();
			return map;
		} catch (FileNotFoundException e) {
			map.put("error", "导入数据库错误，请检查上传文件格式或内容后重新上传文件！");
			e.printStackTrace();
			return map;
		} catch (IOException e) {
			map.put("error", "导入数据库错误，请检查上传文件格式或内容后重新上传文件！");
			e.printStackTrace();
			return map;
		}
		return map;
	}

	/** 
	 * 数据对比
	 * 本次对比仅批量对比数据是否 biding表中已经存在
	 **/
	@Override
	public Map<String,Object> completeData(BidImport bidImport) throws Exception {
		
		List<Route> routes = routeDao.selectAll();
		
		//获取所有 招标类型的  全名对应的对象集合
		Map<String,Dictionary> dictsMap = dictionaryService.selectNameMapAllByType("bidTypes");
		// 验证数据线路是否正确  根据名字获取id
		Map<String,String> routesMap = new HashMap<String,String>();
		for(Route route:routes){
			routesMap.put(route.getRouteName(), route.getRouteId());
		}
		
		List<BidImport> list = bidImportDao.selectByMainId(bidImport.getMainId());//.selectfuzzy(bidImport);
		
		List<Bidding> bids = biddingDao.selectAll();
//		List<Bidding> biddels = new ArrayList<Bidding>();  //记录本次数据对比  bidding 表中没有对比过的数据
//		biddels.addAll(bids);
		for(BidImport bi:list){
			
			String routeName = bi.getRouteName();
			if(routeName!=null&&routesMap.get(routeName)!=null){//线路不存在的  不进行对比
				bi.setUrouteId(routesMap.get(routeName));
			}else{
				continue;
			}
			
			if(dictsMap.get(bi.getFullTypeName())!=null){//验证招标类型
				bi.setUbiddingTypeId(dictsMap.get(bi.getFullTypeName()).getDictFullCode());
			}
			
			for(Bidding bid : bids){ //验证原数据库中已经存在
				if(StringUtils.isNotBlank(bi.getBiddingName())&&StringUtils.isNotBlank(bi.getBiddingNo())&&StringUtils.isNotBlank(bi.getUrouteId())&&
				StringUtils.isNotBlank(bid.getBiddingName())&&StringUtils.isNotBlank(bid.getBiddingNo())&&StringUtils.isNotBlank(bid.getRouteId())&&
				//bi.getBiddingName().equals(bid.getBiddingName())&&
				bi.getBiddingNo().equals(bid.getBiddingNo())&&bi.getUrouteId().equals(bid.getRouteId())){
					bi.setUbiddingId(bid.getBiddingId());	// 本次导入数据中不是新增数据 的关联  bidding表主键
//					biddels.remove(bid);
					
					//继续比对  清除数据中没有变化的数据
					if(completeOldPlan(bid,bi)){
						bi.setState("1");//没有变化的数据设置查询为状态为1
					}
					break;
				}
			}
			bidImportDao.update(bi);
		}
		
		
		BidImportMain bidImportMain = bidImportMainDao.selectById(bidImport.getMainId());
		if(list!=null&&list.size()>0){
			bidImportMain.setIsUpdate("2");
			bidImportMainDao.update(bidImportMain);
		}
		
		
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("bidImports", list);
		data.put("biddels", null);
		data.put("bidImportMain", bidImportMain);
		
		return data;
	}
	
	/**
	 * //继续比对  清除数据中没有变化的数据
	 * @param bidding
	 * @param bidImport
	 * @return
	 */
	public boolean completeOldPlan(Bidding bidding,BidImport bidImport){
		if(!bidding.getBiddingTypeId().equals(bidImport.getUbiddingTypeId())){ //招标计划发生变更
			return false;
		}
		
		if(!bidding.getBiddingName().equals(bidImport.getBiddingName())){ //标段名称发生变更
			return false;
		}
		if(!bidding.getBidType().equals(bidImport.getBidTypeCode())){ //标段名称发生变更
			return false;
		}
		
		if(!bidding.getFileEndDate().equals(bidImport.getFileEndDate())){ //标段名称发生变更
			return false;
		}
		if(!bidding.getAppraiseDate().equals(bidImport.getAppraiseDate())){ //标段名称发生变更
			return false;
		}
		return true;
	}

	@Override
	public Map<String, Object> saveComplete(BidImport bidImport, Bidding bidding)
			throws Exception {
		bidImport.setIsUpdate("1");
		if(bidding!=null&&bidding.getBiddingId()!=null&&!"".equals(bidding.getBiddingId())){//更新操作
			BidChange bidChange = new BidChange();
			String content ="";
			if(!bidding.getBiddingTypeId().equals(bidImport.getUbiddingTypeId())){ //招标计划发生变更
				String oldtypname = bidding.getDictBiddingType()==null?bidding.getBiddingType():bidding.getDictBiddingType().getDictFullName();
				
				content+="标段类型从["+oldtypname+"]变成 ["+bidImport.getFullTypeName()+"];";
				bidding.setBiddingType(bidImport.getLastTypeName());
				bidding.setBiddingTypeId(bidImport.getUbiddingTypeId());
				
				bidChange.setType("1");
			}
			
			if(!bidding.getBiddingName().equals(bidImport.getBiddingName())){ //标段名称发生变更
				content+="标段名称从["+bidding.getBiddingName()+"]变成 ["+bidImport.getBiddingName()+"];";
				bidding.setBiddingName(bidImport.getBiddingName());
				
				bidChange.setType("1");
			}
			if(!bidding.getBidType().equals(bidImport.getBidTypeCode())){ //标段名称发生变更
				
				String typename = "";
				if(bidding.getBidType()!=null&&bidding.getBidType().equals("1")){
					typename ="单线";
				}else if(bidding.getBidType()!=null&&bidding.getBidType().equals("2")){
					typename ="集中";
				}
				content+="招标方式从["+typename+"]变成 ["+bidImport.getBidType()+"];";
				bidding.setBidType(bidImport.getBidTypeCode());
				bidChange.setType("1");
			}
			
			
			String bidfdate = (bidding.getFileEndDate()!=null&&!bidding.getFileEndDate().equals(""))?DateUtils.format(bidding.getFileEndDate(),"yyyy-MM-dd"):"";
			String bidimfdate = (bidImport.getFileEndDate()!=null&&!bidImport.getFileEndDate().equals(""))?DateUtils.format(bidImport.getFileEndDate(),"yyyy-MM-dd"):"";
			if(!bidfdate.equals(bidimfdate)){ //文件完成日期发生变更
				/*String biddate = "";
				String bidImportD = "";
				if(bidding.getFileEndDate()!=null&&!bidding.getFileEndDate().equals("")){
					biddate = DateUtils.format(bidding.getFileEndDate(),"yyyy-MM-dd");
				}
				
				if(bidImport.getFileEndDate()!=null&&!bidImport.getFileEndDate().equals("")){
					bidImportD = DateUtils.format(bidImport.getFileEndDate(),"yyyy-MM-dd");
				}*/
				content+="文件完成日期从["+bidfdate+"]变成 ["+bidimfdate+"];";
				bidding.setFileEndDate(bidImport.getFileEndDate());
				bidChange.setType("4");
			}
			
			String bidadate = (bidding.getAppraiseDate()!=null&&!bidding.getAppraiseDate().equals(""))?DateUtils.format(bidding.getAppraiseDate(),"yyyy-MM-dd"):"";
			String bidimadate = (bidImport.getAppraiseDate()!=null&&!bidImport.getAppraiseDate().equals(""))?DateUtils.format(bidImport.getAppraiseDate(),"yyyy-MM-dd"):"";
			
			if(!bidadate.equals(bidimadate)){ //评标日期发生变更
				
				/*String biddate = "";
				String bidImportD = "";
				if(bidding.getAppraiseDate()!=null&&!bidding.getAppraiseDate().equals("")){
					biddate = DateUtils.format(bidding.getAppraiseDate(),"yyyy-MM-dd");
				}
				
				if(bidImport.getAppraiseDate()!=null&&!bidImport.getAppraiseDate().equals("")){
					bidImportD = DateUtils.format(bidImport.getAppraiseDate(),"yyyy-MM-dd");
				}*/
				
				content+="评标日期从["+bidadate+"]变成 ["+bidimadate+"];";
				bidding.setAppraiseDate(bidImport.getAppraiseDate());
				bidChange.setType("4");
			}
			
			if(!"".equals(content)){
				bidding.setRemoved("0");
				bidding.setUpdateTime(new Date());
				biddingDao.update(bidding);
				bidChange.setBidding(bidding);
				bidChange.setContent(content);
				bidChange.setUpdateTime(new Date());
				bidChangeService.save(bidChange);
			}
			bidImport.setState("1");
			
		}else{//新增操作
			bidding = new Bidding();
			bidding.setRouteId(bidImport.getUrouteId());
			bidding.setBiddingType(bidImport.getLastTypeName());
			bidding.setBiddingTypeId(bidImport.getUbiddingTypeId());
			bidding.setBiddingName(bidImport.getBiddingName());
			bidding.setBiddingNo(bidImport.getBiddingNo());
			bidding.setBidType(bidImport.getBidTypeCode());
			bidding.setAppraiseDate(bidImport.getAppraiseDate());
			bidding.setFileEndDate(bidImport.getFileEndDate());
			bidding.setBidState("1");
			bidding.setRemoved("0");
			bidding.setCreateTime(new Date());
			bidding.setUpdateTime(new Date());
			biddingDao.insert(bidding);
			bidImport.setUbiddingId(bidding.getBiddingId());
			bidImport.setState("1");
		}
		bidImportDao.update(bidImport);
		
		return null;
	}


}
