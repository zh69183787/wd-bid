package com.wonders.stpt.bid.domain.vo;

import java.util.ArrayList;
import java.util.List;

public class BidImportState {
	private int rownum =0;
	private int totlerum =0;
	private int state =0;  //0 进行中   1 完成
	private List<String> msgs = new ArrayList<String>();
	private String changeContent;
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getTotlerum() {
		return totlerum;
	}
	public void setTotlerum(int totlerum) {
		this.totlerum = totlerum;
	}
	public String getChangeContent() {
		return changeContent;
	}
	public void setChangeContent(String changeContent) {
		this.changeContent = changeContent;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public List<String> getMsgs() {
		return msgs;
	}
	public void setMsgs(List<String> msgs) {
		this.msgs = msgs;
	}
	
	
}
