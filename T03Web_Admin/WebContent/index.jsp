<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="net.project.platedetection.dao.CarDAO" %>
<%@ page import="net.project.platedetection.model.Place" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
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
	<style>
		
		table, td, th
		  {
		  
		  border:1px;
		  border-width:1px;
		  border-style:dashed;
		  padding:5px 5px 5px 5px;
		  border-color:#808080 ;
		  }
		.carbox 
		{
			
			width: 100%;
            height: 45px;
			text-align:center;
			line-height:45px;
		}
		th
		  {
		  background-color:green;
		  color:white;
		  }
	
	</style>
</head>
<body data-spy="scroll">
<div id="content">
    <div class="container">
        <ul id="gn-menu" class="gn-menu-main">
            <li class="gn-trigger">
                <a class="gn-icon gn-icon-menu"><span>Menu</span></a>
                <nav class="gn-menu-wrapper">
                    <div class="gn-scroller">
                        <ul class="gn-menu">
                            
                            <li>
                                <a href="#carpark" class="gn-icon gn-icon-download">Parking Info</a>
                            </li>
                            <li>
                                <a href="#imgstream" class="gn-icon gn-icon-download">About Us</a>
                            </li>
                            
                            <li><a href="#service" class="gn-icon gn-icon-cog">Service</a></li>
                            
                            <li>
                                <a href="#contact" class="gn-icon gn-icon-archive">Contact</a>
                            </li>
                            <li>
                                <a href="login_signup.jsp" class="gn-icon gn-icon-cog">Admin_Login</a>
                            </li>
                        </ul>
                    </div>
                    <!-- /gn-scroller -->
                </nav>
            </li>
            <li><a href="index.jsp">ParLink</a></li>
            <li>
                <ul class="company-social">
                    <li class="social-facebook"><a href="#" target="_blank"><i class="fa fa-facebook"></i></a></li>
                    <li class="social-twitter"><a href="#" target="_blank"><i class="fa fa-twitter"></i></a></li>
                    <li class="social-dribble"><a href="#" target="_blank"><i class="fa fa-dribbble"></i></a></li>
                    <li class="social-google"><a href="#" target="_blank"><i class="fa fa-google-plus"></i></a></li>
                </ul>
            </li>
        </ul>
    </div>

    <!-- Section: intro -->
    <section id="intro" class="intro" style="background:url('images/img-bg.jpg') no-repeat center center; background-size: cover;">
        <div class="slogan" >
            <h1 style="color: white; text-shadow: black 0.1em 0.1em 0.2em" >Parking Link</h1>
            <p style="color: white; text-shadow: black 0.1em 0.1em 0.2em"> 停放情況查詢 / Line小幫手回傳 / 空位查詢 / 停車實況 </p>
            <a href="#carpark" class="btn btn-skin scroll">Learn more</a>
        </div>
    </section>
    <!-- /Section: intro -->
    
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
				request.getSession().setAttribute("listPlace"+i, "<img src='images/zone/car.jpg' alt='' class='img-responsive' width='100%' style='border:2px darkorange dashed;'/>");
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
                            
                            <form action="PlaceSearch" method="post">
							　請輸入車號：<input type="text" name="CarPlate">
							　<input type="submit" value="查詢">
							</form>
                            <% 
								String userPlace = (String)session.getAttribute("userPlace") ;
                            	System.out.print(userPlace);
                            	if(userPlace == null){
                            		out.print("<h5>請輸入車牌號碼</h5>");
                            	}
                            	else{
                            		out.print("<h5>"+userPlace+"</h5>");
                            	}
									
							%>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="container">

            <div class="row">
             <!-- ZONE 1  -->
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-1</h5>
                            <% out.print("<p class='subtitle'>目前有"+session.getAttribute("conEmpty")+"空位 </p> <br> "); %>
                            <!-- 停車表格 -->
                            	<table width='100%'>
									<%
										String []place = null;
										int placeSize = (int)session.getAttribute("placeSize");
										int con = 0 ;
										String pic = "<img src='images/zone/car.jpg' alt='' width='100%' class='img-responsive' />";
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
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-2</h5>
                            <p class="subtitle">目前有 3 空位</p>
                            <!-- 停車表格 -->
                            <table width='100%'>
								　<tr >
								　<td><img src="images/zone/car.jpg" width="100%" alt="" class="img-responsive" /></td>
								　<td><div class='carbox'>Zone2-0002</div></td>
								　</tr>
								　<tr>
								　<td><img src="images/zone/car.jpg" width="100%" alt="" class="img-responsive" /></td>
								　<td><div class='carbox'>Zone1-0004</div></td>
								　</tr>
								 <tr>
								 <td><div class='carbox'>Zone1-0005</div></td>
								　<td><img src="images/zone/car.jpg" width="100%" alt="" class="img-responsive" /></td>
								　</tr>
								
							</table>
                        </div>
                    </div>

                </div>
                <!-- ZONE 3  -->
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-3</h5>
                            <p class="subtitle">目前有 3 空位</p>
                            <!-- 停車表格 -->
                            	<table width='100%'>
                            	 
								　<tr >
								　<td> <div class='carbox'> Zone3-0001 </div> </td>
								 <td> <div class='carbox'> Zone3-0002 </div> </td>
								　</tr>
								　<tr>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　</tr>
								 <tr>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　<td><div class='carbox'> Zone3-0006 </div></td>
								　</tr>
								 
							</table>
                        </div>
                    </div>

                </div>
               <!-- ZONE 4  -->
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Park Zone-4</h5>
                            <p class="subtitle">目前有 1 空位</p>
                            <!-- 停車表格 -->
                            	<table width='100%'>
								　<tr >
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　</tr>
								　<tr>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　<td><div class='carbox'>Zone4-0004</div></td>
								　</tr>
								 <tr>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　<td><img src="images/zone/car.jpg" width='100%' alt="" class="img-responsive" /></td>
								　</tr>
								
							</table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!-- /Section: 空位情況回傳 -->
    
	<!-- Section: 影像回傳 -->
    <section id="imgstream" class="home-section text-center">
        <div class="heading-about marginbot-50">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">

                        <div class="section-heading">
                            <h2>About us</h2>
                            <p>Lorem ipsum dolor sit amet, no nisl mentitum recusabo per, vim at blandit qualisque dissentiunt. Diam efficiantur conclusionemque ut has</p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="container">

            <div class="row">
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>ParLink Taipei</h5>
                            <p class="subtitle">總車位 32 </p>
                            <div class="avatar">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14459.211052759543!2d121.54841739864888!3d25.04076676875571!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442abd379a5ec97%3A0xedc006d25a9e35df!2z6LOH562W5pyDIOaVuOS9jeaVmeiCsueglOeptuaJgCDmlbjkvY3kurrmiY3ln7nogrLkuK3lv4M!5e0!3m2!1szh-TW!2stw!4v1570514757967!5m2!1szh-TW!2stw" width="100%" height="223" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>ParLink Taoyuan</h5>
                            <p class="subtitle">總車位 50 </p>
                            <div class="avatar">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3616.952024735981!2d121.1895113153779!3d24.9677468470973!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346823ea50c732a5%3A0x1b5e6ee66e9fec49!2zVGliYU1lIHgg6LOH562W5pyD5Lit5aOi5Lit5b-D!5e0!3m2!1szh-TW!2stw!4v1570515759751!5m2!1szh-TW!2stw" width="100%" height="223" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>ParLink Taichung</h5>
                            <p class="subtitle">總車位 65 </p>
                            <div class="avatar">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3640.604292585092!2d120.64881961536763!3d24.150531079288637!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34693d9650422ae1%3A0x8ddb31f44cc87fce!2z6LOH562W5pyDLeaVuOS9jeaVmeiCsueglOeptuaJgC3kuK3ljYDoqJPnt7TkuK3lv4M!5e0!3m2!1szh-TW!2stw!4v1570515855134!5m2!1szh-TW!2stw" width="100%" height="223" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>ParLink Kaohsiung</h5>
                            <p class="subtitle">總車位  70</p>
                            <div class="avatar">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3682.685060736147!2d120.29084831534952!3d22.62823293662797!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346e047cb59c5ef1%3A0xeb0d3d3bee586e78!2z6LOH562W5pyDLeaVuOS9jeaVmeiCsueglOeptuaJgC3ljZfljYDoqJPnt7TkuK3lv4Mo6auY6ZuEKQ!5e0!3m2!1szh-TW!2stw!4v1570515919814!5m2!1szh-TW!2stw" width="100%" height="223" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!-- /Section: 影像回傳 -->



    <!-- Section: services -->
    <section id="service" class="home-section text-center bg-gray">

        <div class="heading-about marginbot-50">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">

                        <div class="section-heading">
                            <h2>Our Services</h2>
                            <p>You can use Line to asking us about ParLink anything</p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-sm-3 col-md-3">

                    <div class="service-box">
                        <div class="service-icon">
                            <i class="fa fa-code fa-3x"></i>
                        </div>
                        <div class="service-desc">
                            <h5>Line</h5>
                            <p>ID:@223btxfz You can use Line to asking us about ParLink anything.</p>
                        </div>
                    </div>

                </div>
                <div class="col-sm-3 col-md-3">

                    <div class="service-box">
                        <div class="service-icon">
                            <i class="fa fa-suitcase fa-3x"></i>
                        </div>
                        <div class="service-desc">
                            <h5>Web Design</h5>
                            <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                        </div>
                    </div>

                </div>
                <div class="col-sm-3 col-md-3">

                    <div class="service-box">
                        <div class="service-icon">
                            <i class="fa fa-cog fa-3x"></i>
                        </div>
                        <div class="service-desc">
                            <h5>Photography</h5>
                            <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                        </div>
                    </div>

                </div>
                <div class="col-sm-3 col-md-3">

                    <div class="service-box">
                        <div class="service-icon">
                            <i class="fa fa-rocket fa-3x"></i>
                        </div>
                        <div class="service-desc">
                            <h5>Cloud System</h5>
                            <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!-- /Section: services -->




    <!-- Section: contact -->
    <section id="contact" class="home-section text-center " >
        <div class="heading-contact marginbot-50">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">

                        <div class="section-heading">
                            <h2>Get in touch</h2>
                            <p></p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-offset-2">
                   

                    <div class="widget-contact row">
                        <div class="col-lg-6">
                            <address>
                                <strong>Ninestars Ltd.</strong><br>
                                Big Villa 334 Awesome, Beautiful Suite 1200<br>
                                San Francisco, CA 94107<br>
                                <abbr title="Phone">P:</abbr>
                                (123) 456-7890
                            </address>
                        </div>

                        <div class="col-lg-6">
                            <address>
                                <strong>Email</strong><br>
                                <a href="mailto:parlink@park.com?subject=[ParLink客戶意見]%20意見回報&body=意見描述：%0A%0A姓名:%20：%0A==========================%0A電話%20方便致電時間:">parlink@park.com</a><br />
                                <a href="mailto:#">parlink_complain@park.com</a>
                            </address>

                        </div>
                    </div>
                </div>

            </div>

        </div>
    </section>
</div>
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

</body>
</html>
    