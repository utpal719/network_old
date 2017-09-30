package com.network.model;

import java.util.ArrayList;

public class MiddleDestination {

	private int midId;
	private int busId;
	private int fromCityId;
	private int toCityId;
	private double fare;
	private ArrayList seatlist;
	private String startTime;
	private String endTime;
	private String fromCity;
	private String toCity;
	
	
	
	public String getFromCity() {
		return fromCity;
	}
	public void setFromCity(String fromCity) {
		this.fromCity = fromCity;
	}
	public String getToCity() {
		return toCity;
	}
	public void setToCity(String toCity) {
		this.toCity = toCity;
	}
	public int getBusId() {
		return busId;
	}
	public void setBusId(int busId) {
		this.busId = busId;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getMidId() {
		return midId;
	}
	public void setMidId(int midId) {
		this.midId = midId;
	}
	public int getFromCityId() {
		return fromCityId;
	}
	public void setFromCityId(int fromCityId) {
		this.fromCityId = fromCityId;
	}
	public int getToCityId() {
		return toCityId;
	}
	public void setToCityId(int toCityId) {
		this.toCityId = toCityId;
	}
	public double getFare() {
		return fare;
	}
	public void setFare(double fare) {
		this.fare = fare;
	}
	public ArrayList getSeatlist() {
		return seatlist;
	}
	public void setSeatlist(ArrayList seatlist) {
		this.seatlist = seatlist;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	
	
	
}
