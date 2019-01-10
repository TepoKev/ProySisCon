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
	<%
	   Controlador ctr = new Controlador();
	   BigDecimal Tac = new BigDecimal(0);
	   BigDecimal Tanc = new BigDecimal(0);
	   BigDecimal Tpc = new BigDecimal(0);
	   BigDecimal Tpnc = new BigDecimal(0);
	   BigDecimal Tpat = new BigDecimal(0);
	   String fechI = ctr.recuperarParametro("FECHA_INICIAL").getValor();
	   String fechF = ctr.recuperarParametro("FECHA_FINAL").getValor();
	   String invF = ctr.recuperarParametro("INVENTARIO_FINAL").getValor();
	   EstResult estado = new EstResult(fechI, fechF, invF);
	   ArrayList<Mayor> AC = ctr.mayorizarCuentas(4, "11");
	   ArrayList<Mayor> ANC = ctr.mayorizarCuentas(4, "12");
	   ArrayList<Mayor> PC = ctr.mayorizarCuentas(4, "21");
	   ArrayList<Mayor> PNC = ctr.mayorizarCuentas(4, "22");
	   ArrayList<Mayor> PAT = ctr.mayorizarCuentas(4, "31");
	   if (estado.getInventarioF().doubleValue() <= 0) {
	%>
	<div class="col-lg-9">
	   Para mostrar el balance general primero se tiene que dar un valor a inventario final por favor valla a la pagina de configuracion y asigne un valor.
	</div>
	<%
	} else {
	%>
	<div class="col-lg-9">
	   <div class="row">


	      <div class="col-lg-6">
	         <h4>ACTIVO</h4>
	         <div class="pl-3">
		CORRIENTE
		<div class="row">
		   <%
		      for (Mayor m : AC) {
		         m.generarSaldos();
		         if ((m.getSaldoD() != 0 || m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			if (m.getSaldoD() != 0 && m.getSaldoA() == 0) {
			   Tac = Tac.add(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoD()%>
		   </div>
		   <%
		   } else {
		      if (m.getSaldoA() != 0 && m.getSaldoD() == 0) {
		         Tac = Tac.subtract(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoA()%>
		   </div>
		   <%
			   }
			}
		         }
		      }
		      Tac = Tac.add(estado.getInventarioF());
		   %>
		   <div class="col-lg-6 pl-5">
		      INVENTARIO
		   </div>
		   <div class="col-lg-6">
		      <%= estado.getInventarioF().toString()%>
		   </div>
		   <div class="col-lg-6 pl-5 pt-3">
		      <span class="font-weight-bold text-warning">TOTAL</span>
		   </div>
		   <div class="col-lg-6 pt-3">
		      <span class="font-weight-bold text-warning"><%= Tac.toString()%></span>
		   </div>
		</div>
	         </div>
	         <div class="pl-3 mt-3">
		NO CORRIENTE
		<div class="row">
		   <%
		      for (Mayor m : ANC) {
		         m.generarSaldos();
		         if ((m.getSaldoD() != 0 || m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			if (m.getSaldoD() != 0 && m.getSaldoA() == 0) {
			   Tanc = Tanc.add(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoD()%>
		   </div>
		   <%
		   } else {
		      if (m.getSaldoA() != 0 && m.getSaldoD() == 0) {
		         Tanc = Tanc.subtract(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoA()%>
		   </div>
		   <%
			   }
			}
		         }
		      }
		   %>
		   <div class="col-lg-6 pl-5 pt-3">
		      <span class="font-weight-bold text-warning">TOTAL</span>
		   </div>
		   <div class="col-lg-6 pt-3">
		      <span class="font-weight-bold text-warning"><%= Tanc.toString()%></span>
		   </div>
		</div>
	         </div>

	      </div>
	      <div class="col-lg-6">
	         <h4>PASIVO</h4>
	         <div class="pl-3">
		CORRIENTE
		<div class="row">
		   <%
		      for (Mayor m : PC) {
		         m.generarSaldos();
		         if ((m.getSaldoD() != 0 || m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			if (m.getSaldoD() != 0 && m.getSaldoA() == 0) {
			   Tpc = Tpc.subtract(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoD()%>
		   </div>
		   <%
		   } else {
		      if (m.getSaldoA() != 0 && m.getSaldoD() == 0) {
		         Tpc = Tpc.add(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoA()%>
		   </div>
		   <%
			   }
			}
		         }
		      }
		      Tpc = Tpc.add(estado.ImpuestoRenta());
		   %>
		   <div class="col-lg-6 pl-5">
		      IMPUESTO SOBRE LA RENTA
		   </div>
		   <div class="col-lg-6">
		      <%= estado.ImpuestoRenta().setScale(2, RoundingMode.HALF_UP).toString()%>
		   </div>
		   <div class="col-lg-6 pl-5 pt-3">
		      <span class="font-weight-bold text-warning">TOTAL</span>
		   </div>
		   <div class="col-lg-6 pt-3">
		      <span class="font-weight-bold text-warning"><%= Tpc.toString()%></span>
		   </div>
		</div>
	         </div>
	         <div class="pl-3 mt-3">
		NO CORRIENTE
		<div class="row">
		   <%
		      for (Mayor m : PNC) {
		         m.generarSaldos();
		         if ((m.getSaldoD() != 0 || m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			if (m.getSaldoD() != 0 && m.getSaldoA() == 0) {
			   Tpnc = Tpnc.subtract(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoD()%>
		   </div>
		   <%
		   } else {
		      if (m.getSaldoA() != 0 && m.getSaldoD() == 0) {

		         Tpnc = Tpnc.add(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoA()%>
		   </div>
		   <%
			   }
			}
		         }
		      }
		   %>
		   <div class="col-lg-6 pl-5 pt-3">
		      <span class="font-weight-bold text-warning">TOTAL</span>
		   </div>
		   <div class="col-lg-6 pt-3">
		      <span class="font-weight-bold text-warning"><%= Tpnc.toString()%></span>
		   </div>
		</div>
	         </div>
	         <div class="pl-4 pt-3">
		<span class="font-weight-bold text-success">TOTAL PASIVO <%= Tpc.add(Tpnc).setScale(2, RoundingMode.HALF_UP).toString()%></span>
	         </div>
	         <h4 class="mt-3">PATRIMONIO</h4>
	         <div class="pl-3">
		<div class="row">
		   <div class="col-lg-6 pl-5">
		      RESERVA LEGAL
		   </div>
		   <div class="col-lg-6">
		      <%= estado.ReservaLegal().setScale(2, RoundingMode.HALF_UP).toString()%>
		   </div>
		   <%
		      Tpat = Tpat.add(estado.ReservaLegal());
		      Tpat = Tpat.add(estado.UtilidadEjercicio());
		      for (Mayor m : PAT) {
		         m.generarSaldos();
		         if ((m.getSaldoD() != 0 || m.getSaldoA() != 0) && !("INVENTARIOS".equalsIgnoreCase(m.getCuenta().getNombre()))) {
			if (m.getSaldoD() != 0 && m.getSaldoA() == 0) {
			   Tpat = Tpat.subtract(new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoD()%>
		   </div>
		   <%
		   } else {
		      if (m.getSaldoA() != 0 && m.getSaldoD() == 0) {
		         Tpat = Tpat.add(new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP));
		   %>
		   <div class="col-lg-6 pl-5">
		      <%= m.getCuenta().getNombre()%>
		   </div>
		   <div class="col-lg-6">
		      <%= m.getSaldoA()%>
		   </div>
		   <%
			   }
			}
		         }
		      }
		   %>
		   <div class="col-lg-6 pl-5">
		      UTILIDAD DEL EJERCICIO
		   </div>
		   <div class="col-lg-6">
		      <%= estado.UtilidadEjercicio().setScale(2, RoundingMode.HALF_UP).toString()%>
		   </div>
		   <div class="col-lg-6 pl-5 pt-3">
		      <span class="font-weight-bold text-warning">TOTAL</span>
		   </div>
		   <div class="col-lg-6 pt-3">
		      <span class="font-weight-bold text-warning"><%= Tpat.toString()%></span>
		   </div>
		</div>
	         </div>
	      </div>
	   </div>
	   <div class="row">
	      <div class="col-lg-6">
	         <div class="pl-4 pt-3">
		<span class="font-weight-bold text-success">TOTAL ACTIVO = <%= Tac.add(Tanc).setScale(2, RoundingMode.HALF_UP).toString()%></span>
	         </div>
	      </div>
	      <div class="col-lg-6">
	         <div class="pl-4 pt-3">

		<span class="font-weight-bold text-success">TOTAL PASIVO + PATRIMONIO = <%= Tpat.add(Tpc.add(Tpnc)).setScale(2, RoundingMode.HALF_UP).toString()%></span>

	         </div>
	      </div>
	   </div>
	</div>
	<%
	   }
	%>

         </div>
         <footer style="min-height: 170px; margin-top: 75px;" class="text-white bg-info">
	<div class="container">

	</div>
         </footer>
   </body>
</html>
