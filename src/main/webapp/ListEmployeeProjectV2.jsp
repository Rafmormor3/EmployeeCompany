<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalTime"%>
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
	EmployeeProject employeeProject = null;
	Map<Integer, LocalTime> map = session.getAttribute("mapa")==null? new HashMap() : (HashMap)session.getAttribute("mapa");
	double minutes =0;
	try{
		int idEmployee = (int) (session.getAttribute("idEmployee"));
		empleado = DbRepository.find(Employee.class, idEmployee);
		
		if(request.getParameter("empezar")!=null){
			map.put(Integer.valueOf(request.getParameter("empezar")), LocalTime.now());
			session.setAttribute("mapa", map);
			
			
		}else if(request.getParameter("terminar")!=null){
			
			int idProject = Integer.valueOf(request.getParameter("terminar"));
			
			LocalTime tiempo = map.get(idProject);
			
			minutes = ChronoUnit.MINUTES.between(tiempo,LocalTime.now());
			
			Project project = DbRepository.find(Project.class, idProject);
			employeeProject = new EmployeeProject(project, empleado, minutes);
			
			if(DbRepository.find(EmployeeProject.class, employeeProject)!=null){
				minutes = employeeProject.getHora()+minutes;
				employeeProject.setHora(minutes);
				DbRepository.update(employeeProject);
			}else{
				DbRepository.add(employeeProject);
			}
			
			map.remove(idProject);
		}
		
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
			<td>
				<form>
				<%if(!map.containsKey(cp.getProject().getId())){%>
					<button type="submit" value="<%= cp.getProject().getId()%>" name="empezar" class="btn btn-warning">Empezar Proyecto</button>
				<%}else{ %>
					<button type="submit" value="<%= cp.getProject().getId()%>" name="terminar" class="btn btn-danger">Terminar Proyecto</button>
				<%} %>
				</form>
			</td>
		</tr>
		<%		}
			}
		%>
	</tbody>
</table>
<%
	}catch(Exception e){
		out.print(e.getMessage());
	}
%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>