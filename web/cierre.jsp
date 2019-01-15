<%-- 
    Document   : mostrar-estado-de-resultados
    Created on : 10-10-2018, 12:47:41 AM
    Author     : TepoKev
--%>
<%@page import="modelo.validarPeriodo"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="modelo.CargoAbono"%>
<%@page import="modelo.partidasCierre"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Partida"%>
<%@page import="modelo.EstResult"%>
<%@page import="controlador.Controlador" %>
<%@page import="modelo.Mayor" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Cierre del Ejercicio</title>
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="fonts/font-awesome.css">
      <link rel="stylesheet" href="fonts/fonts.css">
      <link rel="stylesheet" href="css/custom-tree.css">
      <script src="js/tether.min.js"></script>
      <script src="js/jquery-3.1.1.js"></script>
      <script src="js/bootstrap.js"></script>
   </head>
   <%
      if (!validarPeriodo.val() || !validarPeriodo.valF()) {
   %>
   <script type="text/javascript">
      window.location = "configuracion.jsp?opc=n";
   </script>
   <%
   } else {
   %>
   <body>
      <div class="bg-danger text-white" style="margin-bottom: 50px;">

         <div style="background-color: rgba(255,255,255,.2);">
	<div class="container">
	   <%@include file="nav.jsp" %>
	</div>
         </div>

         <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
	<h1 class="text-sm-center font-weight-bold">Cierre del Ejercicio</h1>
         </div>
      </div>
      <div class="container mb-4">
         <!-- Aqui va el cierre del ejercicio-->
         <div class="row">
	<%@include file="aside.jsp" %>
	<div class="col-lg-9">
	   <h4 class="text-center">Partidas de Ajuste</h4>

	   <%	      Controlador ctr = new Controlador();
	      partidasCierre par = new partidasCierre();
	      par.generarPartidasCierre();
	      ArrayList<Partida> partida = par.partidas;
	      BigDecimal tCargo = new BigDecimal("0");
	      BigDecimal tAbono = new BigDecimal("0");
	      for (Partida p : partida) {
	   %>
	   <div class="row">
	      <div class="col-sm-4">
	         <p>Fecha: <%= p.getFecha() == null ? "<span class=\"text-danger font-weight-bold\">fecha nula</span>" : p.getFecha().toString()%></p>
	      </div>
	      <div class="col-sm-4">
	         <p><span style="font-size: 100%" class="badge badge-info font-weight-bold">Partida N&deg; <%= p.getContador()%></span></p>
	      </div>
	   </div>  

	   <div class="col-lg-9">
	      <table class="table table-sm">
	         <thead>
		<tr>
		   <th scope="col">Codigo</th>
		   <th scope="col">Nombre</th>
		   <th scope="col">Cargo</th>
		   <th scope="col">Abono</th></tr>
	         </thead>
	         <tbody>
		<%
		   for (CargoAbono c : ctr.ordenarCA(p.getCargosAbonos())) {

		%>
		<tr>
		   <th scope="row"><%= c.getCuenta().getCodigo()%></th>
		   <td><%= c.getCuenta().getNombre()%></td>
		   <%if (c.getOperacion().equals("c")) {
		         tCargo = tCargo.add(new BigDecimal(c.getMonto()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <td><%= c.getMonto()%></td>
		   <td></td>
		   <%} else {
		      tAbono = tAbono.add(new BigDecimal(c.getMonto()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <td></td>
		   <td><%= c.getMonto()%></td><%}%>
		</tr>
		<%
		   }
		%>
	         </tbody>
	      </table>
	   </div>
	   <div class="col-lg-9">
	      <p class="text-muted"><%= p.getDescripcion()%></p>
	   </div>
	   <hr>
	   <%
	      }
	   %>
	   <div class="row">
	      <div class="col-sm-3">

	      </div>
	      <%
	         if (tCargo.equals(tAbono)) {
	      %>
	      <div class="col-sm-3">
	         <p style="color:green">Total Cargo <%= tCargo.toString()%></p>
	      </div>
	      <div class="col-sm-6">
	         <p style="color:green">Total Abono <%= tAbono.toString()%></p>
	      </div>
	      <%
	      } else {
	      %>
	      <div class="col-sm-3">
	         <p style="color:red">Total Cargo <%= tCargo.toString()%></p>
	      </div>
	      <div class="col-sm-6">
	         <p style="color:red">Total Abono <%= tAbono.toString()%></p>
	      </div>
	      <%
	         }
	      %>
	   </div>
	</div>
         </div>
      </div>
      <footer style="min-height: 170px" class="text-white bg-info">
         <div class="container">

         </div>
      </footer>
   </body>
   <%
      }
   %>
</html>