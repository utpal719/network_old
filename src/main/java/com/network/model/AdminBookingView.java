package com.network.model;

public class AdminBookingView {

	private Booking booking;
	private String bookedUser;
	
	public Booking getBooking() {
		return booking;
	}
	public void setBooking(Booking booking) {
		this.booking = booking;
	}
	public String getBookedUser() {
		return bookedUser;
	}
	public void setBookedUser(String bookedUser) {
		this.bookedUser = bookedUser;
	}
	
	
}
