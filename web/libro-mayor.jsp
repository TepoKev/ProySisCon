<%-- 
    Document   : libro-mayor
    Created on : 09-09-2018, 05:27:25 PM
    Author     : tepokev
--%>
<%@page import="modelo.Periodo"%>
<%@page import="modelo.validarPeriodo"%>
<%@page import="controlador.Controlador" %>
<%@page import="modelo.Mayor" %>
<%@page import="java.util.ArrayList" %>
<%@page import="modelo.CargoAbono" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Libro Mayor</title>
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="css/jstree.css">
      <link rel="stylesheet" href="fonts/font-awesome.css">
      <link rel="stylesheet" href="fonts/fonts.css">
      <link rel="stylesheet" href="css/custom-tree.css">
      <script src="js/tether.min.js"></script>
      <script src="js/jquery-3.1.1.js"></script>
      <script src="js/bootstrap.js"></script>
   </head>
   <%
      if (!validarPeriodo.val()) {
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
	<h1 class="text-sm-center font-weight-bold">Libro  Mayor</h1>
         </div>
      </div>

      <main class="container">
         <%
	Controlador ctr = new Controlador();
	ArrayList<Mayor> lista = ctr.mayorizarCuentas(4);
	for (Mayor item : lista) {
	   if (item.getTransacciones().size() > 0) {
	      item.generarSaldos();
         %>
         <div class="row">
	<div class="col-lg-12 py-3">
	   <div class="container">
	      <h4 class="text-sm-center"><%=item.getCuenta().getNombre()%></h4>
	   </div>
	   <table class="table table-sm">
	      <thead>
	         <tr>
		<th>Codigo</th>
		<th>Concepto</th>
		<th>Debe</th>
		<th>Haber</th>
		<th>Saldo</th>
	         </tr>
	      </thead>
	      <tbody>
	         <%
		Periodo actual = ctr.periodoNow();
		for (CargoAbono ca : item.getTransacciones()) {
		   if (ca.getPartida().getPeriodo().getId() == actual.getId()) {
	         %>
	         <tr>
		<th><%=ca.getCuenta().getCodigo()%></th>
		<td><%=ca.getPartida().getDescripcion()%></td>
		<td><%=("c".equalsIgnoreCase(ca.getOperacion())) ? ca.getMonto() : ""%></td>
		<td><%=("a".equalsIgnoreCase(ca.getOperacion())) ? ca.getMonto() : ""%></td>
		<td><%=ca.getMonto()%></td>
	         </tr>
	         <%
		   }
		}
	         %>
	      </tbody>
	      <tfoot>
	         <tr>
		<td></td>
		<th scope="row">Totales</th>
		<td><%=(item.getCargo() != 0) ? item.getCargo() : ""%></td>
		<td><%=(item.getAbono() != 0) ? item.getAbono() : ""%></td>
		<td><%= (item.getSaldoD() != 0) ? item.getSaldoD() : ((item.getSaldoA() != 0) ? item.getSaldoA() : "")%></td>
	         </tr>
	      </tfoot>
	   </table>
	</div>
         </div>
         <%
	   }
	}
         %>
      </main>
      <footer class="badge-info text-white mt-3" style="min-height: 170px">
         <div class="container">
         </div>
      </footer>
   </body>
   <%
      }
   %>
</html>
