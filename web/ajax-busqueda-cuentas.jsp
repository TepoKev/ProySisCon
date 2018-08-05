<%-- 
    Document   : ajax-busqueda-cuentas
    Created on : 12-29-2017, 05:25:59 PM
    Author     : deb
--%>
<%@page import="java.util.List"%>
<%@page import="modelo.Cuenta"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   String busqueda = request.getParameter("ajax-busqueda");
   Controlador ctl = new Controlador();
   List cuentas = ctl.buscarPorNombreOCodigo(busqueda);
   int i, size = cuentas.size();
   Cuenta c;
   if (size > 0) {
%>
<div class="list-group">
   <%
	  for (i = 0; i < size; i++) {
		 c = (Cuenta) cuentas.get(i);
   %>
   <div class="row bg-faded">
	  <div class="col-sm-2 px-0">
		 <div class="list-group-item "><%=c.getCodigo()%></div>
	  </div>
	  <div class="col-sm-10 px-0">
		 <a href="#" data-codigo="<%=c.getCodigo()%>" class="list-group-item list-group-item-action mx-0">
			<span><%=c.getNombre()%></span>
		 </a>
	  </div>

   </div>



   <%
	  }
   %></div>
   <%
	  }

   %>
