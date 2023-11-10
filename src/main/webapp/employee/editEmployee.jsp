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
<title>Añadir empleado</title>
<link rel="stylesheet" href="style.css">
</head>
<%
	HttpSession sesion = request.getSession();
	ArrayList<Company> listComany=null;
	String idEmployee = request.getParameter("idEmployee");
	Employee findEmployee = null;
		
	try{
		
		String role = (String) sesion.getAttribute("role");
		if(role.equals("USER")){
			response.sendRedirect("./../error.jsp?msg=Usuario no administrador");
			return;
		}
		
		listComany=(ArrayList<Company>) DbRepository.findAll(Company.class);
			
	}catch(Exception e){
		response.sendRedirect("./../error.jsp?msg="+e.getMessage());
		return;
	}
		
	try{	
		findEmployee = (Employee)DbRepository.find(Employee.class, Integer.valueOf(idEmployee));
	}catch(Exception e){
		response.sendRedirect("./../error.jsp?msg=No se encuentra tal empleado enla base de datos");
		return;
	}
	
	try{
		
		if(request.getParameter("submit")!= null){
			
			int idEmpl = Integer.valueOf(request.getParameter("idEmployee"));
			String name = request.getParameter("name");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			
			Date dateOfBirth=null;
			try{
				dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
			}catch(Exception e){
				response.sendRedirect("./../error.jsp?msg=Fecha erronea, formato adecuado: yyyy-MM-dd");
				return;
			}
			
			int id = Integer.valueOf(request.getParameter("company"));
			
			Company company = DbRepository.find(Company.class, id);
		
			findEmployee = new Employee(idEmpl,  name, lastName, email, gender, dateOfBirth, company);
			DbRepository.update(findEmployee);	
		}
		
	}catch(Exception e){
		response.sendRedirect("./../error.jsp?msg="+e.getMessage());
		return;
	}
%>
<body>
<form action="" id="formulario" >
  <div class="form-group row" hidden>
    <label for="" class="col-4 col-form-label">Id</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="idEmployee" name="idEmployee" type="text" required="required" class="form-control" value="<%=findEmployee.getId()%>" hidden> 
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Nombre</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="name" name="name" type="text" required="required" class="form-control" value="<%=findEmployee.getFirstName()%>"> 
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Apellidos</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="lastName" name="lastName" type="text" required="required" class="form-control" value="<%=findEmployee.getLastName()%>"> 
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="email" name="email" type="email" required="required" class="form-control" value="<%=findEmployee.getEmail()%>"> 
      </div>
    </div>
  </div> 
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Genero</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="gender" name="gender" type="text" required="required" class="form-control" value="<%=findEmployee.getGender()%>"> 
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Fecha Nacimiento</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="dateOfBirth" name="dateOfBirth" type="date" required="required" class="form-control" value="<%=findEmployee.getDateOfBirth()%>"> 
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Compañia</label> 
    <div class="col-8">
      <div class="input-group">
        <select name="company">
        <%
        	for(Company c : listComany){
        		%>
        		<option value="<%=findEmployee.getCompany().getId() %>"><%=findEmployee.getCompany().getName() %></option>
        		<option value="<%= c.getId()%>"><%=c.getName()%></option>
        		<% 
        	}
        %>
        </select>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-primary">Editar</button>
      <button><a href="./../ListEmployeeCompany.jsp">Volver</a></button>
    </div>
    
  </div>
</form>



<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>