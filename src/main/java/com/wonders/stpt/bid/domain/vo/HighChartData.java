package com.wonders.stpt.bid.domain.vo;

public class HighChartData {
	
	private String name ;
	private Double[] data;
	
	public HighChartData(){
		
	}
	
	public HighChartData(String name,int length){
		this.name = name;
		this.data =  new Double[length];
		for(int i=0;i<length;i++){
			this.data[i]= 0d;
		}
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double[] getData() {
		return data;
	}
	public void setData(Double[] data) {
		this.data = data;
	}

}
