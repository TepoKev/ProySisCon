<%-- 
    Document   : mostrar-estado-de-resultados
    Created on : 10-10-2018, 12:47:41 AM
    Author     : diegoone
--%>

<%@page import="controlador.Controlador" %>
<%@page import="modelo.Mayor" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Estado de Resultados</title>
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
	<h1 class="text-sm-center font-weight-bold">Estado de Resultados</h1>
         </div>
      </div>

      <div class="container-fluid">
         <div class="row">
	<div class="col-md-1">

	</div>
	<div class="col-md-3">
	   <label>Inventario Final</label>
	</div>

	<div class="col-md-3">
	   <label>Fecha Inicial</label>
	</div>

	<div class="col-md-3">
	   <label>Fecha Final</label>
	</div>
         </div>
         <div class="row">
	<div class="col-md-1">

	</div>
	<div class="col-md-3">
	   <div class="input-group mb-1">
	      <input type="text" aria-label="Amount (to the nearest dollar)" name="invf" id="invf">
	      <div class="input-group-append">
	         <span class="input-group-text">.00</span>
	      </div>
	   </div>
	</div>

	<div class="col-md-3">
	   <div class="input-group mb-1">
	      <input type="date" name="fechi" id="fechi">
	      <div class="input-group-append">
	         <span class="input-group-text">dd/MM/yyyy</span>
	      </div>
	   </div>
	</div>

	<div class="col-md-3">
	   <div class="input-group mb-1">
	      <input type="date" name="fechf" id="fechf">
	      <div class="input-group-append">
	         <span class="input-group-text">dd/MM/yyyy</span>
	      </div>
	   </div>
	</div>

	<div class="col-md-2">
	   <button type="button" class="btn btn-outline-danger">Generar</button>
	</div>
         </div>

      </div>

      <div class="container">
         <div class="row">
	<hr>
         </div>
         <div class="row">
	<%@include file="aside.jsp" %>
	<div class="col-lg-9">
	   <table class="table table-sm">
	      <tbody>
	         <tr>
		<td></td>
		<td>VENTAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>REBAJAS Y DEVOLUCIONES</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>SOBRE VENTAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>VENTAS NETAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>COSTO DE VENTAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>COMPRAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(+)</td>
		<td>GASTOS SOBRE COMPRAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>COMPRAS TOTALES</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>REBAJAS Y DEVOLUCIONES</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>SOBRE COMPRAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>COMPRAS NETAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(+)</td>
		<td>INVENTARIO INICIAL</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>MERCADERIA DISPONIBLE</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>INVENTARIO FINAL</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>COSTO DE VENTA</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD BRUTA</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>GASTOS DE OPERACION</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>GASTOS DE ADMINISTRACION</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>GASTOS DE VENTA</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>GASTOS FINANCIEROS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD DE OPERACION</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>OTROS GASTOS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(+)</td>
		<td>OTROS INGRESOS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD ANTES DE</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>IMPUESTO Y RESERVAS</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>RESERVA LEGAR 7%</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD ANTES DE IMPUESTO</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>IMPUESTO SOBRE LA RENTA</td>
		<td></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD DEL EJERCICIO</td>
		<td></td>
		<td></td>
	         </tr>
	      </tbody>
	   </table>
	</div>
         </div>
      </div>
      <div class="container">
         <div class="row">
	
	<div class="col-md-12 text-sm-center">
	   <button type="button" class="btn btn-outline-success">Imprimir</button>
	</div>

         </div>
         <div class="row">
	<hr>
         </div>
      </div>
      <footer style="min-height: 170px" class="text-white bg-info">
         <div class="container">

         </div>
      </footer>
   </body>
</html>
