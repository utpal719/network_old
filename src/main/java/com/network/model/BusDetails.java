package com.network.model;

import java.util.ArrayList;

public class BusDetails {
	
	private Bus bus;
	private int busId;
	private ArrayList occupiedSeat;
	private String journeyDate;


	public Bus getBus() {
		return bus;
	}
	public void setBus(Bus bus) {
		this.bus = bus;
	}
	public int getBusId() {
		return busId;
	}
	public void setBusId(int busId) {
		this.busId = busId;
	}
	public ArrayList getOccupiedSeat() {
		return occupiedSeat;
	}
	public void setOccupiedSeat(ArrayList occupiedSeat) {
		this.occupiedSeat = occupiedSeat;
	}
	public String getJourneyDate() {
		return journeyDate;
	}
	public void setJourneyDate(String journeyDate) {
		this.journeyDate = journeyDate;
	}
	
	
	

}
