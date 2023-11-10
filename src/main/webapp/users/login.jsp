<%@page import="java.security.Principal"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="styleLogin.css" rel="stylesheet">
</head>
<body>
<%
	HttpSession sesion = request.getSession();
	Employee empleado = null;
	String mensaje="";
	
	try{
		int idEmployee = Integer.valueOf(request.getParameter("idEmployee"));
		empleado = DbRepository.find(Employee.class, idEmployee);
		
		if(request.getParameter("submit")!=null && empleado!=null && empleado.getContrasenia().equals(request.getParameter("password"))){
			
			sesion.setAttribute("idEmployee", empleado.getId());
			session.setAttribute("role", empleado.getRole());
			
			response.sendRedirect("./../ListEmployeeProjectV2.jsp");
			return;
			
		}else{
			mensaje="Usuario no encontrado";
		}
	}catch(Exception e){
		
	}
%>
<div class="wrapper fadeInDown">

   <div class="fadeIn first">
      <h1><%=mensaje %></h1>
   </div>
   
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <h1>Login</h1>
    </div>

    <!-- Login Form -->
    <form>
      <input type="text" id="idEmployee" class="fadeIn second" name="idEmployee" placeholder="id">
      <input type="password" id="password" class="fadeIn third" name="password" placeholder="password">
      <input type="submit" id="submit" name="submit" class="fadeIn fourth" value="Log In">
    </form>

  </div>
</div>
</body>
</html>