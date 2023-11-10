<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//intento ver si me ha puesto los dtos para añadir un nuevo cine
	
	ArrayList<Employee> result=null;
	try{
		
		result = (ArrayList<Employee>) DbRepository.findAll(Employee.class);
%>


<table class="table">
	<thead>
		<th scope="col">Id</th>
		<th scope="col">Nombre</th>
		<th scope="col">Apellidos</th>
		<th scope="col">Email</th>
		<th scope="col">Genero</th>
		<th scope="col">Fecha Nacimiento</th>
		<th scope="col">Nombre Compañia</th>
		
	</thead>
	<tbody>
		<%
			for(Employee e : result){
		%>
		<tr>
			<td><%=e.getId() %></td>
			<td><%=e.getFirstName() %></td>
			<td><%=e.getLastName() %></td>
			<td><%=e.getEmail() %></td>
			<td><%=e.getGender() %></td>
			<td><%=e.getDateOfBirth() %></td>
			<td><%=e.getCompany().getName()%></td>
			
			<th scope="col">Empleados</th>
		</tr>
		<%
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