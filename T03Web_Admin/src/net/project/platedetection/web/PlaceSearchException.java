package net.project.platedetection.web;

public class PlaceSearchException extends Exception {
	public PlaceSearchException() {
		super();
	}
	public void showMessage() {
		System.out.println("無此車牌/或是格是錯誤 輸入範例: ABC-1234");
	}
	
}
