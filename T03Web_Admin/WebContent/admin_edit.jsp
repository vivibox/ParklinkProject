<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="utils.service.client.Detect" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.service.client.Client" %>    
<%@ page import="net.project.platedetection.dao.CarDAO" %>
<%@ page import="net.project.platedetection.model.Place" %>
<%@ page import="java.util.*" %>
    
<!DOCTYPE html>
<html lang="zh-ch">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>T03 Project</title>

    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css" />
	<link href="css/nivo-lightbox.css" rel="stylesheet" />
	<link href="css/nivo-lightbox-theme/default/default.css" rel="stylesheet" type="text/css" />
	<link href="css/animate.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet">
	<link href="css/default.css" rel="stylesheet">

</head>
<body data-spy="scroll">

<div id="tableHolder"></div>
    <div class="container">
        <ul id="gn-menu" class="gn-menu-main">
            <li class="gn-trigger">
                <a class="gn-icon gn-icon-menu"><span>Menu</span></a>
                <nav class="gn-menu-wrapper">
                    <div class="gn-scroller">
                        <ul class="gn-menu">
                           
                            <li>
                                <a href="admin_stream.jsp" class="gn-icon gn-icon-download">ImgStream</a>
                            </li>
                            <li>
                                <a href="#carpark" class="gn-icon gn-icon-download">Edit</a>
                            </li>
                            
                            
                            <li>
                                <a href="Logout" class="gn-icon gn-icon-archive">Logout</a>
                            </li>
                        </ul>
                    </div>
                    <!-- /gn-scroller -->
                </nav>
            </li>
             <li><a href="admin_stream.jsp">ParLink Admin</a></li>
            <li>
                <ul class="company-social">
                    
                </ul>
            </li>
        </ul>
    </div>    
    
     <!-- DB資料抓取 -->
    <% 
    	
    	CarDAO carDAO = new CarDAO();
		List<Place> listPlace = carDAO.selectAll();
		String isUserPlace = (String)session.getAttribute("isUserPlace") ;
		int conEmpty = 0 ;
		for(int i = 0 ;i<listPlace.size();i++) {
			String place_name = listPlace.get(i).getPlace_name();
			Boolean isEmpty = listPlace.get(i).isEmpty();
			if(place_name.equals(isUserPlace)) {
				request.getSession().setAttribute("listPlace"+i, "<img src='images/zone/car.jpg' alt='' class='img-responsive' style='border:2px darkorange dashed;'/>");
			}
			else if(isEmpty == true) {
				conEmpty+=1 ;
				request.getSession().setAttribute("listPlace"+i, place_name);
			}
			else {
				request.getSession().setAttribute("listPlace"+i, "notEmpty");
			}
		}
		request.getSession().setAttribute("placeSize", listPlace.size());
		request.getSession().setAttribute("conEmpty", conEmpty);
		%>
		<!-- DB資料抓取 -->
    
    
    <!-- Section: 空位情況回傳 -->
    <section id="carpark" class="home-section text-center bg-gray">
        <div class="heading-about marginbot-50">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">

                        <div class="section-heading">
                            <h2>Parking Info </h2>
                            
                            <form action="AdminPlaceSearch" method="post">
							　請輸入車號：<input type="text" name="CarPlate">
							　<input type="submit" value="查詢">
							</form>
                            <% 
								String userPlace = (String)session.getAttribute("userPlace") ;
								out.print("<h5>"+userPlace+"</h5>");	
							%>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="container">

            <div class="row">
             <!-- ZONE 1  -->
                <div class="col-xs-6 col-sm-3 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-1</h5>
                            <% out.print("<p class='subtitle'>目前有"+session.getAttribute("conEmpty")+"空位 </p> <br> "); %>
                            <!-- 停車表格 -->
                            	<table >
									<%
										String []place = null;
										int placeSize = (int)session.getAttribute("placeSize");
										int con = 0 ;
										String pic = "<img src='images/zone/car.jpg' alt='' class='img-responsive' />";
										for(int i=0 ; i<3 ;i++){
											out.print("<tr>\r\n");
											for(int j=0 ;j<2 ;j++){
												if(session.getAttribute("listPlace"+con).equals("notEmpty")){
													out.print("<td>"+pic+"</td>\r\n");
												}
												else{
													out.print("<td><div class='carbox'>"+session.getAttribute("listPlace"+con)+"</div></td>\r\n");
												}	
												con += 1 ;
											}
											out.print("</tr>\r\n");
										}
										
									%>
							</table>
                        </div>
                    </div>

                </div>
                <!-- ZONE 2  -->
                <div class="col-xs-6 col-sm-3 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-2</h5>
                            <p class="subtitle">目前有 3 空位</p>
                            <!-- 停車表格 -->
                            <table >
								　<tr >
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><div class='carbox'>Zone2-0002</div></td>
								　</tr>
								　<tr>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><div class='carbox'>Zone1-0004</div></td>
								　</tr>
								 <tr>
								 <td><div class='carbox'>Zone1-0005</div></td>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　</tr>
								
							</table>
                        </div>
                    </div>

                </div>
                <!-- ZONE 3  -->
                <div class="col-xs-6 col-sm-3 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-3</h5>
                            <p class="subtitle">目前有 3 空位</p>
                            <!-- 停車表格 -->
                            	<table >
                            	 
								　<tr >
								　<td> <div class='carbox'> Zone3-0001 </div> </td>
								 <td> <div class='carbox'> Zone3-0002 </div> </td>
								　</tr>
								　<tr>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　</tr>
								 <tr>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><div class='carbox'> Zone3-0006 </div></td>
								　</tr>
								 
							</table>
                        </div>
                    </div>

                </div>
               <!-- ZONE 4  -->
                <div class="col-xs-6 col-sm-3 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-4</h5>
                            <p class="subtitle">目前有 1 空位</p>
                            <!-- 停車表格 -->
                            	<table >
								　<tr >
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　</tr>
								　<tr>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><div class='carbox'>Zone4-0004</div></td>
								　</tr>
								 <tr>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　<td><img src="images/zone/car.jpg" alt="" class="img-responsive" /></td>
								　</tr>
								
							</table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!-- /Section: 空位情況回傳 -->




    <!-- Core JavaScript Files -->
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/classie.js"></script>
    <script src="js/gnmenu.js"></script>
    <script src="js/jquery.scrollTo.js"></script>
    <script src="js/nivo-lightbox.min.js"></script>
    <script src="js/stellar.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/custom.js"></script>
    <script src="js/ajax.js"></script>

</body>
</html>
    