<%-- 
    Document   : mostrar-librodiario
    Created on : 08-03-2018, 03:14:13 PM
    Author     : tepokev
--%>

<%@page import="modelo.CargoAbono"%>
<%@page import="modelo.Partida"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Libro Diario</title>
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="css/jstree.css">
      <link rel="stylesheet" href="fonts/font-awesome.css">
      <link rel="stylesheet" href="fonts/fonts.css">
      <link rel="stylesheet" href="css/custom-tree.css">
      <script src="js/tether.min.js"></script>
      <script src="js/jquery-3.1.1.js"></script>
      <script src="js/bootstrap.js"></script>
   </head>
   <body>
      <div class="bg-danger text-white" style="margin-bottom: 50px;">

         <div style="background-color: rgba(255,255,255,.2);">
	<div class="container">
	   <nav class="navbar navbar-expand-lg navbar-dark">
	      <a class="navbar-brand" href="#">Proy-SisCon</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	         <span class="navbar-toggler-icon"></span>
	      </button>
	      <div class="collapse navbar-collapse" id="navbarSupportedContent">
	         <ul class="navbar-nav mr-auto">
		<li class="nav-item active">
		   <a class="nav-link" href="index.jsp">Inicio <span class="sr-only">(current)</span></a>
		</li>
		<li class="nav-item">
		   <a class="nav-link" href="#">Caracteristicas</a>
		</li>
		<li class="nav-item">
		   <a class="nav-link" href="#">Acerca de</a>
		</li>
		<li class="nav-item">
		   <a class="nav-link disabled" href="#">Ayuda</a>
		</li>
	         </ul>
	         <span class="navbar-text text-white">Sistema Contable</span>
	      </div>
	   </nav>
	</div>
         </div>

         <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
	<h1 class="text-sm-center font-weight-bold">Libro Diario</h1>
         </div>

      </div>
      <div class="container">
         <div class="row">
	<%@include file="aside.jsp" %>
	<div class="col-lg-9">
	   <%
	      Controlador ctr = new Controlador();
	      ArrayList<Partida> partida = (ArrayList<Partida>) ctr.recuperarPartidas();
	      float tCargo = 0, tAbono = 0;
	      for (Partida p : partida) {
	   %>
	   <div class="row">
	      <div class="col-sm-4">
	         <p>Fecha: <%= p.getFecha()==null? "<span class=\"text-danger font-weight-bold\">fecha nula</span>":p.getFecha().toString()%></p>
	      </div>
	      <div class="col-sm-4">
	         <p><span style="font-size: 100%" class="badge badge-info font-weight-bold">Partida N&deg; <%= p.getContador()%></span></p>
	      </div>
	   </div>  

	   <div class="col-lg-9">
	      <table class="table">
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
		         tCargo += c.getMonto();
		   %>
		   <td><%= c.getMonto()%></td>
		   <td></td>
		   <%} else {
		      tAbono += c.getMonto();
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
	         if (tCargo == tAbono) {
	      %>
	      <div class="col-sm-3">
	         <p style="color:green">Total Cargo <%= tCargo%></p>
	      </div>
	      <div class="col-sm-6">
	         <p style="color:green">Total Abono <%= tAbono%></p>
	      </div>
	      <%
	      } else {
	      %>
	      <div class="col-sm-3">
	         <p style="color:red">Total Cargo <%= tCargo%></p>
	      </div>
	      <div class="col-sm-6">
	         <p style="color:red">Total Abono <%= tAbono%></p>
	      </div>
	      <%
	         }
	      %>

	   </div> 
	</div>
         </div>
      </div>

      <footer class="badge-danger text-white mt-3" style="min-height: 170px">
         <div class="container">
         </div>
      </footer>
   </body>
</html>