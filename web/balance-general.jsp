<%-- 
    Document   : balance-general
    Created on : 12-24-2018, 04:57:07 PM
    Author     : student
--%>

<%@page import="modelo.EstResult"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Mayor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Balance General</title>
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
	<h1 class="text-sm-center font-weight-bold">Balance General</h1>
         </div>
      </div>

      <div class="container">
         <div class="row">
	<%@include file="aside.jsp" %>
	<div class="col-lg-9">
	   <div class="row">
	      <%
	         Controlador ctr = new Controlador();
	         BigDecimal Tac = new BigDecimal(0);
	         BigDecimal Tanc = new BigDecimal(0);
	         BigDecimal Tpc = new BigDecimal(0);
	         BigDecimal Tpnc = new BigDecimal(0);
	         BigDecimal Tpat = new BigDecimal(0);
	         EstResult estado = new EstResult("01-01-2018", "31-12-2018", "200000");
	         ArrayList<Mayor> AC = ctr.mayorizarCuentas(4, "11");
	         ArrayList<Mayor> ANC = ctr.mayorizarCuentas(4, "12");
	         ArrayList<Mayor> PC = ctr.mayorizarCuentas(4, "21");
	         ArrayList<Mayor> PNC = ctr.mayorizarCuentas(4, "22");
	         ArrayList<Mayor> PAT = ctr.mayorizarCuentas(4, "31");
	      %>
	      <div class="col-lg-6">
	         <div>
		<h3>Activo</h3>
		<div class="pl-3">
		   <h4>Corriente</h4>
		   <div class="row pl-4">
		      <div class="col-lg-6">
		         <%
			for (Mayor m : AC) {
			   m.generarSaldos();
			   if ((m.getSaldoD() != 0 || m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
		         %>
		         <div><p><%= m.getCuenta().getNombre()%></p></div>
		         <%
			   }
			}
		         %>	
		         <div><p>INVENTARIO</p></div>
		      </div>
		      <div class="col-lg-6">
		         <%
			for (Mayor m : AC) {
			   if ((m.getSaldoD() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			      Tac = Tac.add(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		         %>
		         <div><p><%= m.getSaldoD()%></p></div>
		         <%
		         } else if ((m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			Tac = Tac.subtract(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		         %>
		         <div><p><%= m.getSaldoA()%></p></div>
		         <%
			   }
			}
			Tac = Tac.add(estado.getInventarioF());
		         %>
		         <div><p><%= estado.getInventarioF().toString()%></p></div>
		      </div>
		   </div>
		   <div class="pl-3">
		      <h4>No Corriente</h4>
		      <div class="row pl-4">
		         <div class="col-lg-6">
			<%    for (Mayor m : ANC) {
			      m.generarSaldos();
			      if (m.getSaldoD() != 0 || m.getSaldoA() != 0) {
			%>
			<div><p><%= m.getCuenta().getNombre()%></p></div>
			<%
			      }
			   }
			%>	
		         </div>
		         <div class="col-lg-6">
			<%
			   for (Mayor m : ANC) {
			      if ((m.getSaldoD() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			         Tanc = Tanc.add(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
			%>
			<div><p><%= m.getSaldoD()%></p></div>
			<%
			} else if ((m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			   Tanc = Tanc.subtract(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
			%>
			<div><p><%= m.getSaldoA()%></p></div>
			<%
			      }
			   }

			%>
		         </div>
		      </div>
		   </div>
		</div>
		<div>TOTAL ACTIVO <%= Tac.add(Tanc).setScale(2, RoundingMode.HALF_UP).toString()%></div>
	         </div>

	      </div>
	      <div class="col-lg-6">
	         <div>
		<h3>Pasivo</h3>
		<div class="pl-3">
		   <h4>Corriente</h4>
		   <div class="row pl-4">
		      <div class="col-lg-6">
		         <%		         for (Mayor m : PC) {
			   m.generarSaldos();
			   if (m.getSaldoA() != 0 || m.getSaldoD() != 0) {
		         %>
		         <div><p><%= m.getCuenta().getNombre()%></p></div>
		         <%
			   }
			}
		         %>
		         <div><p>IMPUESTO SOBRE LA RENTA</p></div>
		      </div>
		      <div class="col-lg-6">
		         <%
			for (Mayor m : PC) {
			   if ((m.getSaldoD() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			      Tpc = Tpc.subtract(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		         %>
		         <div><p><%= m.getSaldoD()%></p></div>
		         <%
		         } else if ((m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			Tpc = Tpc.add(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		         %>
		         <div><p><%= m.getSaldoA()%></p></div>
		         <%
			   }
			}
			Tpc = Tpc.add(estado.ImpuestoRenta());
		         %>
		         <div><p><%= estado.ImpuestoRenta().toString()%></p></div>
		      </div>
		   </div>
		</div>
	         </div>

	         <div class="pl-3">
		<h4>No Corriente</h4>
		<div class="row pl-4">
		   <div class="col-lg-6">
		      <%
		         for (Mayor m : PNC) {
			m.generarSaldos();
			if (m.getSaldoA() != 0 || m.getSaldoD() != 0) {
		      %>
		      <div><p><%= m.getCuenta().getNombre()%></p></div>
		      <%
			}
		         }
		      %>	
		   </div>
		   <div class="col-lg-6">
		      <%
		         for (Mayor m : PNC) {
			if ((m.getSaldoD() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			   Tpnc = Tpnc.subtract(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		      %>
		      <div><p><%= m.getSaldoD()%></p></div>
		      <%
		      } else if ((m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
		         Tpnc = Tpnc.add(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		      %>
		      <div><p><%= m.getSaldoA()%></p></div>
		      <%
			}
		         }

		      %>
		   </div>
		</div>
	         </div>
	         <div>TOTAL PASIVO <%= Tpc.add(Tpnc).setScale(2, RoundingMode.HALF_UP).toString()%></div>
	         <hr>
	         <div>
		<h3>Patrimonio</h3>
		<div class="row pl-4">
		   <div class="col-lg-6">
		      <div><p>RESERVA LEGAL</p></div>
		      <%		         for (Mayor m : PAT) {
			m.generarSaldos();
			if (m.getSaldoA() != 0 || m.getSaldoD() != 0) {
		      %>
		      <div><p><%= m.getCuenta().getNombre()%></p></div>
		      <%
			}
		         }
		      %>
		      <div><p>UTILIDAD DEL EJERCICIO</p></div>
		   </div>
		   <div class="col-lg-6">
		      <div><p><%= estado.ReservaLegal().toString()%></p></div>
		      <%
		         for (Mayor m : PAT) {
			if ((m.getSaldoD() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			   Tpat = Tpat.subtract(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		      %>
		      <div><p><%= m.getSaldoD()%></p></div>
		      <%
		      } else if ((m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {

		         Tpat = Tpat.add(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		      %>
		      <div><p><%= m.getSaldoA()%></p></div>
		      <%
			}
		         }
		         Tpat = Tpat.add(estado.ReservaLegal().add(estado.UtilidadEjercicio()));
		      %>
		      <div><p><%= estado.UtilidadEjercicio().toString()%></p></div>
		   </div>
		</div>
	         </div>
	         <div>TOTAL PATRIMONIO <%= Tpat.setScale(2, RoundingMode.HALF_UP).toString()%></div>
	         
	         <div>TOTAL PASIVO + PATRIMONIO <%= Tpat.add(Tpc.add(Tpnc)).setScale(2, RoundingMode.HALF_UP).toString()%></div>
	      </div>
	         
	   </div>

	</div>

         </div>
      </div>
      <footer style="min-height: 170px" class="text-white bg-info">
         <div class="container">

         </div>
      </footer>
   </body>
</html>
