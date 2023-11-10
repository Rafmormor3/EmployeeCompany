<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Añadir EmployeeCompany</title>
<link rel="stylesheet" href="style.css">
</head>
<%
		HttpSession sesion = request.getSession();
		ArrayList<Company> listCompany=null;
		ArrayList<Project> listProject=null;
		
	try{
		
		String role = (String) sesion.getAttribute("role");
		if(role.equals("USER")){
			response.sendRedirect("error.jsp?msg=Usuario no administrador");
			return;
		}
		
		listCompany=(ArrayList<Company>) DbRepository.findAll(Company.class);
		listProject=(ArrayList<Project>) DbRepository.findAll(Project.class);
		
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg= Fallo al principio");
		return;
	}
	
	try{
			Date begin = null;
			Date end = null;
		
		if(request.getParameter("add")!=null){
			int idCompany = Integer.valueOf(request.getParameter("idCompany"));
			int idProject = Integer.valueOf(request.getParameter("idProject"));
			try{
				begin= Date.valueOf(request.getParameter("begin"));
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg=Fecha con formato inválido");
				return;
			}
			try{
				end= Date.valueOf(request.getParameter("end"));
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg=Fecha con formato inválido");
				return;
			}
			
			Company company = DbRepository.find(Company.class, idCompany);
			Project project = DbRepository.find(Project.class, idProject);
			
			CompanyProject companyProject = new CompanyProject(company, project, begin, end);
			
			for(CompanyProject c : (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class)){
				if(c.equals(companyProject)){
					response.sendRedirect("error.jsp?msg= CompanyProject ya existe en la base de datos");
					return;
				}
			}
			
			DbRepository.add(companyProject);
		}
%>
<body>
<form action="" id="formulario">

  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Compañia</label> 
    <div class="col-8">
      <div class="input-group">
        <select name="idCompany">
        <%
        	for(Company c : listCompany){
        		%>
        		<option value="<%= c.getId()%>"><%=c.getName()%></option>
        		<% 
        	}
        %>
        </select>
      </div>
    </div>
  </div>
  </div>
<div class="form-group row">
    <label for="" class="col-4 col-form-label">Proyectos</label> 
    <div class="col-8">
      <div class="input-group">
        <select name="idProject">
        <%
        	for(Project p : listProject){
        		%>
        		<option value="<%= p.getId()%>"><%=p.getName()%></option>
        		<% 
        	}
        %>
        </select>
      </div>
    </div>
  </div>
  </div>
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Fecha Inicio</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="begin" name="begin" type="date" required="required" class="form-control"> 
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Fecha Final</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="end" name="end" type="date" required="required" class="form-control"> 
      </div>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="add" type="submit" class="btn btn-primary">Añadir</button>
      <button><a href="ListEmployeeProjectV2.jsp">Volver</a></button>
    </div>
    
  </div>
</form>

<%	
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+e.getMessage());
		return;
	}
	
	
%>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>