<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<link rel="stylesheet" href="style.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	HttpSession sesion = request.getSession();
	boolean admin = false;
	boolean user = false;
	try{
		String nameUser = (String) sesion.getAttribute("nameUser");
		String role = (String) sesion.getAttribute("role");
		
		if(nameUser!=null ){
			if(role.equals("ADMIN")){
				admin=true;
			}else{
				user=true;
			}
		}else{
			response.sendRedirect("error.jsp?msg=Usuario no registrado");
			return;
		}
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg=Usuario no registrado");
		return;
	}
%>
<%if(admin){ %>
<br>
<form action="employee/addEmployee.jsp">
	<div class="form-group row">
		<div class="offset-4 col-8">
			<button name="Add" type="submit" class="btn btn-primary">Añadir Empleado</button>
		</div>
	</div>
</form>
<form action="addProjectCompany.jsp">
	<div class="form-group row">
		<div class="offset-4 col-8">
			<button name="Add" type="submit" class="btn btn-primary">Añadir EmployeeCompany</button>
		</div>
	</div>
</form>		
<%
}
	//intento ver si me ha puesto los dtos para añadir un nuevo cine
	
	ArrayList<Company> result=null;
	try{
		
		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
		
	if(admin || user){
		
		for(Company c : result){
%>
<table class="table">
	<thead id="titulos">
		<th scope="col">Nombre</th>
		<th scope="col">Numero empleados</th>
		<th scope="col">Numero proyectos</th>
		
	</thead>
	<tbody>
			<tr id="company">
				<td><%=c.getName() %></td>
				<td><%=c.getEmpleados().size() %></td>
				<td><%=c.getCompanyProjects().size() %></td>
				
			</tr>
			<th scope="col" id ="apartado">Empleados</th>
		<%
			for(Employee e : c.getEmpleados()){
			%>
				<tr id="empleado">
					<td><%=e.getId() %></td>
					<td><%=e.getFirstName() %></td>
					<td><%=e.getLastName() %></td>
			<%if(admin){ %>
					<td><button name="edit"><a href="employee/editEmployee.jsp?idEmployee=<%=e.getId()%>">Editar</a></button><td>
					<td><button name="delete"><a href="employee/deleteEmployee.jsp?idEmployee=<%=e.getId()%>">Eliminar</a></button><td>				
			<%} %>
				</tr>
			<%				
			}
		%>
			<th scope="col" id ="apartado">Proyectos</th>
					<%
			for(CompanyProject cp : c.getCompanyProjects()){
			%>
				<tr id="proyecto">
					<td><%=cp.getProject().getId() %></td>
					<td><%=cp.getProject().getName()%></td>
					<td><%=cp.getProject().getButget() %></td>
					
				</tr>
			<%				
			}
		%>
	</tbody>
</table><br><br><br><br>
<%
			}
		}else{
			response.sendRedirect("error.jsp?msg=Usuario no administrador");
			return;
		}
	}catch(Exception e){
		
	}
%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>