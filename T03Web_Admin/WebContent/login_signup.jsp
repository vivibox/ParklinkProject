<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/login.css" rel="stylesheet">

</head>
<body>

<div class="cotn_principal">
<div class="cont_centrar">

<input class="btn_sign_up" type="button" value="Back to ParLink" onclick="location.href='index.jsp'">

  <div class="cont_login">
<div class="cont_info_log_sign_up">
      <div class="col_md_login">
<div class="cont_ba_opcitiy">
        
        <h2>LOGIN</h2>  
  <p>Administrator only.</p> 
  <button class="btn_login" onclick="cambiar_login()">LOGIN</button>
  </div>
  </div>
<div class="col_md_sign_up">
<div class="cont_ba_opcitiy">
  <h2>SIGN UP</h2>

  
  <p>Get the pass code from HR.</p>

  <button class="btn_sign_up" onclick="cambiar_sign_up()">SIGN UP</button>
</div>
  </div>
       </div>

    
    <div class="cont_back_info">
       <div class="cont_img_back_grey">
       <img src="images/img-bg.jpg" alt="" />
       </div>
       
    </div>
<div class="cont_forms" >
    <div class="cont_img_back_">
       <img src="images/img-bg.jpg" alt="" />
       </div>
 <div class="cont_form_login">
<a href="#" onclick="ocultar_login_sign_up()" ><i class="material-icons">&#xE5C4;</i></a>
   <h2>LOGIN</h2>
   <br><br>
	 <form action="Login" class="rightForm" method="post">
		<input type="text" name="UserName" placeholder="UserName" required="required" /><br>
		<input type="password" name="pwd" placeholder="Password" required="required"/><br>
		<button type="submit" class="btn_login" onclick="cambiar_login()">LOGIN</button>
	</form>
	
  </div>
  
   <div class="cont_form_sign_up">
<a href="#" onclick="ocultar_login_sign_up()"><i class="material-icons">&#xE5C4;</i></a>
     <h2>SIGN UP</h2>
     
     <br>
		<form action="SignupServlet" class="rightForm" method="post" align="right">
          <input type="text" required name="UserName" class="cent" placeholder="UserName" ><br>
          <input type="password" required name="pwd" placeholder="Password" class="cent" maxlength="8"><br>
          <input type="password" required name="conform" placeholder="Password again"   class="cent" maxlength="8"><br>
          <input type="email" name="email" required placeholder="E-mail" ><br>
          <input type="text" name="code" class="cent" required placeholder="Pass Code" ><br><br>
          
          
          <img alt="驗證碼" src="<%=request.getContextPath() %>/ValidateColorServlet" required><br>
          <input type="text" name="checkcode" placeholder="Verification code"><br>     
          <button type="submit"  class="btn_sign_up" onclick="cambiar_sign_up()">SIGN UP</button><br>
          <br>
          
		</form>
  </div>

    </div>
    
  </div>
 </div>
</div>


<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script>
function cambiar_login() {
	  document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_login";  
	document.querySelector('.cont_form_login').style.display = "block";
	document.querySelector('.cont_form_sign_up').style.opacity = "0";               

	setTimeout(function(){  document.querySelector('.cont_form_login').style.opacity = "1"; },400);  
	  
	setTimeout(function(){    
	document.querySelector('.cont_form_sign_up').style.display = "none";
	},200);  
	  }

	function cambiar_sign_up(at) {
	  document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_sign_up";
	  document.querySelector('.cont_form_sign_up').style.display = "block";
	document.querySelector('.cont_form_login').style.opacity = "0";
	  
	setTimeout(function(){  document.querySelector('.cont_form_sign_up').style.opacity = "1";
	},100);  

	setTimeout(function(){   document.querySelector('.cont_form_login').style.display = "none";
	},400);  


	}    



	function ocultar_login_sign_up() {

	document.querySelector('.cont_forms').className = "cont_forms";  
	document.querySelector('.cont_form_sign_up').style.opacity = "0";               
	document.querySelector('.cont_form_login').style.opacity = "0"; 

	setTimeout(function(){
	document.querySelector('.cont_form_sign_up').style.display = "none";
	document.querySelector('.cont_form_login').style.display = "none";
	},500);  
	  
	  }

</script>

</body>
</html>