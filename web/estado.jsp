<%-- 
    Document   : estado.jsp
    Created on : 12-20-2018, 08:33:41 AM
    Author     : student
--%>
<%@page import="modelo.EstResult"%>
<%@page import="modelo.Mayor"%>
<%@page import="controlador.Controlador" %>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%
   EstResult estado = new EstResult(request.getParameter("fechai"), request.getParameter("fechaf"), request.getParameter("inventariof")); 
%>
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

