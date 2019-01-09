<%-- 
    Document   : mostrar-estado-de-resultados
    Created on : 10-10-2018, 12:47:41 AM
    Author     : diegoone
--%>

<%@page import="modelo.EstResult"%>
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
	   <%@include file="nav.jsp" %>
	</div>
         </div>

         <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
	<h1 class="text-sm-center font-weight-bold">Estado de Resultados</h1>
         </div>
      </div>

      <div class="container-fluid">
         <%
	Controlador ctr = new Controlador();
	String fechI = ctr.recuperarParametro("FECHA_INICIAL").getValor();
	String fechF = ctr.recuperarParametro("FECHA_FINAL").getValor();
	String invF = ctr.recuperarParametro("INVENTARIO_FINAL").getValor();
	EstResult estado = new EstResult(fechI, fechF, invF);
         %>
      </div>
      <div class="container">
         <div class="row">
	<hr>
         </div>
         <div class="row">
	<!-- Aqui va el estado de resultados-->
	<%@include file="aside.jsp" %>
	<div class="col-lg-9">
	   <table class="table table-sm">
	      <tbody>
	         <tr>
		<td></td>
		<td>VENTAS</td>
		<td></td>
		<td><%= estado.getVentas().toString()%></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>REBAJAS Y DEVOLUCIONES</td>
		<td></td>
		<td><%= estado.getReb_deb_ventas().toString()%></td>
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
		<td><%= estado.VentasNetas().toString()%></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>COSTO DE VENTAS</td>
		<td></td>
		<td><%= estado.CostoVenta().toString()%></td>
	         </tr>
	         <tr>
		<td></td>
		<td>COMPRAS</td>
		<td><%= estado.getCompras().toString()%></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(+)</td>
		<td>GASTOS SOBRE COMPRAS</td>
		<td><%= estado.getGastos_compras().toString()%></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>COMPRAS TOTALES</td>
		<td><%= estado.ComprasTotales().toString()%></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>REBAJAS Y DEVOLUCIONES</td>
		<td><%= estado.getReb_deb_compras().toString()%></td>
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
		<td><%= estado.ComprasNetas().toString()%></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(+)</td>
		<td>INVENTARIO INICIAL</td>
		<td><%= estado.getInventarioI().toString()%></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>MERCADERIA DISPONIBLE</td>
		<td><%= estado.MercaderiaDisponible().toString()%></td>
		<td></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>INVENTARIO FINAL</td>
		<td><%= estado.getInventarioF().toString()%></td>
		<td></td>
	         </tr>
	         <tr class="table-active">
		<td>(=)</td>
		<td>COSTO DE VENTA</td>
		<td><%= estado.CostoVenta().toString()%></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD BRUTA</td>
		<td></td>
		<td><%= estado.UtilidadBruta().toString()%></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>GASTOS DE OPERACION</td>
		<td></td>
		<td><%= estado.GastosOperacion().toString()%></td>
	         </tr>
	         <tr>
		<td></td>
		<td>GASTOS DE ADMINISTRACION</td>
		<td><%= estado.getGast_admon().toString()%></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>GASTOS DE VENTA</td>
		<td><%= estado.getGast_vent().toString()%></td>
		<td></td>
	         </tr>
	         <tr>
		<td></td>
		<td>GASTOS FINANCIEROS</td>
		<td><%= estado.getGast_fin().toString()%></td>
		<td></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD DE OPERACION</td>
		<td></td>
		<td><%= estado.UtilidadOperacion().toString()%></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>OTROS GASTOS</td>
		<td></td>
		<td><%= estado.getOtros_gast().toString()%></td>
	         </tr>
	         <tr>
		<td>(+)</td>
		<td>OTROS INGRESOS</td>
		<td></td>
		<td><%= estado.getOtros_ingre().toString()%></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD ANTES DE</td>
		<td></td>
		<td><%= estado.UtilidadAIR().toString()%></td>
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
		<td><%= estado.ReservaLegal().toString()%></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD ANTES DE IMPUESTO</td>
		<td></td>
		<td><%= estado.UtilidadAI().toString()%></td>
	         </tr>
	         <tr>
		<td>(-)</td>
		<td>IMPUESTO SOBRE LA RENTA</td>
		<td></td>
		<td><%= estado.ImpuestoRenta().toString()%></td>
	         </tr>
	         <tr class="table-info">
		<td>(=)</td>
		<td>UTILIDAD DEL EJERCICIO</td>
		<td></td>
		<td><%= estado.UtilidadEjercicio().toString()%></td>
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
