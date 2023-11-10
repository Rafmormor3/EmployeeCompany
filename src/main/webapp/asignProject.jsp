<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info Character</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="styleSheet.css" />
</head>
<body>

<%
	double minutos = 0;
	boolean ocupado = false;
	Project projectSelect = null;
	EmployeeProject employeeProject = null;
	ArrayList<EmployeeProject> listEmployeeProject = null;
	
	try{
		Employee empleado = DbRepository.find(Employee.class, (int) session.getAttribute("idEmployee"));
		
		if(request.getParameter("start")!=null && session.getAttribute("time")==null){
			session.setAttribute("time", LocalTime.now());
			projectSelect = DbRepository.find(Project.class, request.getParameter("idProject"));
			session.setAttribute("projectSelect", projectSelect);
			
			
		}else if(request.getParameter("stop")!=null && session.getAttribute("time")!=null){
			
			minutos = ChronoUnit.MINUTES.between((LocalTime)session.getAttribute("time"), LocalTime.now());
			
			employeeProject = new EmployeeProject((Project)session.getAttribute("projectSelect"), empleado, minutos);
			
			boolean resultFind= (EmployeeProject) DbRepository.find(EmployeeProject.class, employeeProject)!=null;
			
			
			if(resultFind){
				minutos = minutos + employeeProject.getHora();
				employeeProject.setHora(minutos);
				DbRepository.update(employeeProject);
				
			}else{
				DbRepository.add(employeeProject);
			}
			
			session.setAttribute("time", null);
		}
		
		
		//Cuando le doy a empezar que se ponga una lista abajo con el proyecto y un boton de parar, controlar que no puedas iniciar un proyecto si ya esta en la lista
		
		
%>
<!-- Formulario con los campos rellenos y los botones de editar y borrar -->
<div class="mainWrap">
<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Id Employee:</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="name" name="name" type="text" class="form-control" value="<%=empleado.getId() %>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Name: </label> 
    <div class="col-8">
      <div class="input-group">
        <input id="nationality" name="nationality" type="text" class="form-control" value="<%=empleado.getFirstName()%>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Projects: </label> 
    <div class="col-8">
      <div class="input-group">
      	<select name="idProject">
      		<%
      		if(session.getAttribute("time")==null){
      			for(CompanyProject cp : empleado.getCompany().getCompanyProjects()){
      				if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){
      				%>
      				<option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName() %></option>
      				<%
      				}
      			}
      		}else{
      			projectSelect = (Project)session.getAttribute("projectSelect");
  				%>
  				<option value="<%=projectSelect.getId()%>"><%=projectSelect.getName() %></option>
  				<%      		
  			}
      		%>
      	</select>
      </div>
    </div>
  </div>
  <% 
  if(session.getAttribute("time")==null){
  %>
   <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Time: </label> 
    <div class="col-8">
      <div class="input-group">
        <input id="nationality" name="nationality" type="text" class="form-control" value="<%=minutos %>" readonly>
      </div>
    </div>
  <button name="start" type="submit" class="btn btn-warning">Start Project</button>
  <%
  }else{
  %>
  <button name="stop" type="submit" class="btn btn-danger">Stop Project</button>
  <%
  }
  %>
</form>
 <button name="volver" class="btn btn-dark"><a href="ListEmployeeProjectV2.jsp">Projects List</a></button>
<%
	}catch(Exception e){
		out.print(e.getMessage());
	}
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>



