<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.project.platedetection.dao.CarPlateDAO" %>
<%@ page import="net.project.platedetection.model.Car" %>
<%@ page import="java.util.*" %>

<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>


<%
	CarPlateDAO carPlateDAO = new CarPlateDAO();
	List<Car> listCar = carPlateDAO.selectAllCars();
	int conCar = 0 ;
	int pre_enter_time = 0 ;	
	String enterPlate;
	String enterEnter;
	String enterUrl;
	enterPlate = listCar.get(0).getCar_plate();
	enterEnter = listCar.get(0).getEnter_time();
	enterUrl = listCar.get(0).getUrl();
	session.setAttribute("enterPlate", enterPlate);
	session.setAttribute("enterEnter", enterEnter);
	
	//*********** enter URL
	if(enterUrl.equals("")){
		session.setAttribute("enterUrl", "enter1.jpg");
	}else{
		session.setAttribute("enterUrl", enterUrl);
	}
	
	//*********** enter URL
	
	for(int i = 0 ;i<listCar.size();i++) {
		String car_plate = listCar.get(i).getCar_plate();
		String enter_time = listCar.get(i).getEnter_time();
		String exit_time = listCar.get(i).getExit_time();
		
		//*********** enter URL
		
		
		//*********** enter URL
		
		//*********** String & Date transform
		String str = "yyyy-MM-dd hh:mm:ss" ;
		SimpleDateFormat format = new SimpleDateFormat(str) ;
		//*********** String & Date transform
		
		String url = listCar.get(i).getUrl();
		Boolean isExit = listCar.get(i).getIsExit();
		if(isExit == true) {
			session.setAttribute("exitPlate", car_plate);
			//session.setAttribute("exitEnter", enter_time);
			//session.setAttribute("exitExit", exit_time);
			//*********** String & Date transform
			Date enterDate =  format.parse(enter_time);
			Date exitDate =  format.parse(exit_time);
			// 停車時間-以毫秒計儲存
			long diffInMillies = exitDate.getTime() -enterDate.getTime() ;
			// 將毫秒轉為以分鐘計 >> Long轉為字串
			String parkingTime = Long.toString(TimeUnit.MINUTES.convert(diffInMillies, TimeUnit.MILLISECONDS)) ;
			
			//*********** String & Date transform
			session.setAttribute("parkingTime", parkingTime);
			session.setAttribute("exitUrl", url);
		}
		if(isExit != true) {
			session.setAttribute("exitPlate", "目前無車經過");
			//*********** String & Date transform
			session.setAttribute("parkingTime", "0");
			session.setAttribute("exitUrl", "exit1.jpg");
		}
		if(car_plate != "NONE"){
			conCar += 1 ;
		}
	}
	int conEmpty = 3-conCar ;
	session.setAttribute("conEmpty", conEmpty);
	
	//System.out.print(request.getRealPath());
	
%>
<json:object>
	<json:array name="enterCar" >
	    <json:object>
	      <json:property name="enterPlate" value="${enterPlate}"/>
	      <json:property name="enterEnter" value="${enterEnter}"/>
	      <json:property name="enterUrl" value="${enterUrl}"/>
	    </json:object>
  	</json:array>
  	<json:array name="exitCar" >
	    <json:object>
	      <json:property name="exitPlate" value="${exitPlate}"/>
	      <json:property name="parkingTime" value="${parkingTime}"/>
	      <json:property name="exitUrl" value="${exitUrl}"/>
	    </json:object>
  	</json:array>
  	<json:array name="conEmpty" >
	    <json:object>
	      <json:property name="conEmpty" value="${conEmpty}"/>
	    </json:object>
  	</json:array>
</json:object>
