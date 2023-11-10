<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List EmployeeProject</title>
</head>
<body>
<%
	
	Employee empleado = null;
	HttpSession sesion = request.getSession();
	try{
		int idEmployee = (int) (sesion.getAttribute("idEmployee"));
		empleado = DbRepository.find(Employee.class, idEmployee);
		
%>

<table class="table">
	<thead>
		<th scope="col">Id</th>
		<th scope="col">Nombre</th>
		<th scope="col">Butget</th>
		<th> 
			<form action="addProjectCompany.jsp">
     			<button name="submit" type="submit" class="btn btn-dark">Añadir Proyecto</button>
     		</form>
 		</th>
		<th> 
			<form action="asignProject.jsp">
     			<button name="submit" type="submit" class="btn btn-primary">Elegir Proyecto</button>
     		</form>
 		</th>
		
		
	</thead>
	<tbody>
		<%
			for(CompanyProject cp : empleado.getCompany().getCompanyProjects()){
				if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){
		%>
		<tr>
			<td><%=cp.getProject().getId() %></td>
			<td><%=cp.getProject().getName() %></td>
			<td><%=cp.getProject().getButget() %></td>
		</tr>
		<%		}
			}
		%>
	</tbody>
</table>
<%
	}catch(Exception e){
		
	}
%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>