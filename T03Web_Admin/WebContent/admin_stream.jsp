<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="utils.service.client.Detect" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.service.client.Client" %>    
    
    
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
                                <a href="#imgstream" class="gn-icon gn-icon-download">ImgStream</a>
                            </li>
                            <li>
                                <a href="admin_edit.jsp" class="gn-icon gn-icon-download">Edit</a>
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
    <!-- Section: 影像回傳 -->
    <section id="imgstream" class="home-section text-center bg-gray">
        <div class="heading-about marginbot-50">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">

                        <div class="section-heading">
                            <h2>ParLink管理中心</h2>
                            <p>影像回傳</p>
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
                            <h5>入口</h5>
                        
                            <div id="enterUrl" class="avatar">
                                
                            </div>
                            <center><table width="100%" align='center' valign="middle" id="enter_table"></table></center>
                        </div>
                    </div>

                </div>
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey w-100 p-3">
                        <div class="inner">
                            <h5>Zone1</h5>
                            
                           
                            <div class="avatar">
                            	<img src="http://192.168.140.82:8000/video_feed" width="100%" >
                                <!--  <img src="images/db/1.jpg" width="100%"> -->
                            </div>
                            <p class="subtitle" id="con">空位0個 </p>
                        </div>

                    </div>
                </div>
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey">
                        <div class="inner">
                            <h5>Zone2</h5>
                            
                           
                            <div id="enterUrl" class="avatar">
                              <img src="http://192.168.140.57:8000/video_feed" width="100%" >
                                <!--  <img src="images/db/1.jpg" width="100%"> -->
                            </div>
                            <p class="subtitle" >空位3個 </p>
                        </div>
                    </div>

                </div>
                <div class="col-xs-6 col-md-3">

                    <div class="team boxed-grey ">
                        <div class="inner">
                            <h5>出口</h5>
                       
                            
                            <div id="exitUrl" class="avatar">
                            	  
                            </div>
                            <center><table width="100%" align='center' valign="middle" id="exit_table"></table></center>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!-- /Section: 影像回傳 -->



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
    