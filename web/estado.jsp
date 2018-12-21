<%-- 
    Document   : estado.jsp
    Created on : 12-20-2018, 08:33:41 AM
    Author     : student
--%>
<%@page import="modelo.Mayor"%>
<%@page import="controlador.Controlador" %>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%
   BigDecimal acum = new BigDecimal(0);
   //Costo de Venta
   BigDecimal cv = new BigDecimal(0);
   //Compras Totales
   BigDecimal ct = new BigDecimal(0);
   //Compras Netas
   BigDecimal cn = new BigDecimal(0);
   //Mercaderia Disponible
   BigDecimal md = new BigDecimal(0);
   //Reserva Legal
   BigDecimal rv = new BigDecimal(0);
   //Impuesto sobre la Renta
   BigDecimal imp = new BigDecimal(0);
   
   BigDecimal tg = new BigDecimal(0);
   
   BigDecimal reserva = new BigDecimal(0);
   
   BigDecimal renta = new BigDecimal(0);
   
   BigDecimal uir = new BigDecimal(0);
   
   BigDecimal ur = new BigDecimal(0);

   BigDecimal u = new BigDecimal(0);
   
   BigDecimal invf = new BigDecimal(request.getParameter("inventariof")).setScale(2, RoundingMode.HALF_UP);
   String fechi = request.getParameter("fechai");
   String fechf = request.getParameter("fechaf");
   Controlador ctr = new Controlador();
   //Declaracion de variables alicivas al estado de reultados
   Mayor ventas, rdvents, compras, gscompras, rdcompras, inventario, gda, gdv, gf, og, oi;
  
   ventas = ctr.mayorizarCuenta("5101",fechi,fechf);
   ventas.generarSaldos();
   
   //Rebajas y Deboluciones sobre ventas
   rdvents = ctr.mayorizarCuenta("4101", fechi, fechf);
   rdvents.generarSaldos();
   
   compras = ctr.mayorizarCuenta("4102", fechi, fechf);
   compras.generarSaldos();
   
   //Gastos sobre Compras
   gscompras = ctr.mayorizarCuenta("4203", fechi, fechf);
   gscompras.generarSaldos();
   
   //Rebajas y Devoluciones sobre Compras
   rdcompras = ctr.mayorizarCuenta("5105", fechi, fechf);
   rdcompras.generarSaldos();
   
   //Inventario Inicial
   inventario = ctr.mayorizarCuenta("1109", fechi, fechf);
   inventario.generarSaldos();
   
   //Gastos de Administracion
   gda = ctr.mayorizarCuenta("4201", fechi, fechf);
   gda.generarSaldos();
   
   //Gastos de Ventas
   gdv = ctr.mayorizarCuenta("4202", fechi, fechf);
   gdv.generarSaldos();
   
   //Gastos Finacieros
   gf = ctr.mayorizarCuenta("4204", fechi, fechf);
   gf.generarSaldos();
   
   //Otros Gastos
   og = ctr.mayorizarCuenta("4205", fechi, fechf);
   og.generarSaldos();
   
   //Otros Ingresos
   oi = ctr.mayorizarCuenta("5106", fechi, fechf);
   oi.generarSaldos();
   
   acum = acum.add(new BigDecimal(ventas.getSaldoA()));
   
   ct = ct.add(new BigDecimal(compras.getSaldoD()));
   ct = ct.add(new BigDecimal(gscompras.getSaldoD()));
   
   cn = ct.subtract(new BigDecimal(rdcompras.getSaldoA()));
   
   md = cn.add(new BigDecimal(inventario.getSaldoD()));
   
   cv = md.subtract(invf);
   
   tg = tg.add(new BigDecimal(gda.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
   
   tg = tg.add(new BigDecimal(gdv.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
   
   tg = tg.add(new BigDecimal(gf.getSaldoD()).setScale(2, RoundingMode.HALF_UP));
%>
<%@include file="aside.jsp" %>
<div class="col-lg-9">
   <table class="table table-sm">
      <tbody>
         <tr>
	<td></td>
	<td>VENTAS</td>
	<td></td>
	<td><%= ventas.getSaldoA()%></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>REBAJAS Y DEVOLUCIONES</td>
	<td></td>
	<td><%= rdvents.getSaldoD()%></td>
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
	<td><%= (acum = acum.subtract(new BigDecimal(rdvents.getSaldoD()))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>COSTO DE VENTAS</td>
	<td></td>
	<td><%= cv.setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td></td>
	<td>COMPRAS</td>
	<td><%= new BigDecimal(compras.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr>
	<td>(+)</td>
	<td>GASTOS SOBRE COMPRAS</td>
	<td><%= new BigDecimal(gscompras.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr class="table-active">
	<td>(=)</td>
	<td>COMPRAS TOTALES</td>
	<td><%= ct.setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>REBAJAS Y DEVOLUCIONES</td>
	<td><%= new BigDecimal(rdcompras.getSaldoA()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
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
	<td><%= cn.setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr>
	<td>(+)</td>
	<td>INVENTARIO INICIAL</td>
	<td><%= new BigDecimal(inventario.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr class="table-active">
	<td>(=)</td>
	<td>MERCADERIA DISPONIBLE</td>
	<td><%= md.setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>INVENTARIO FINAL</td>
	<td><%= invf.setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr class="table-active">
	<td>(=)</td>
	<td>COSTO DE VENTA</td>
	<td><%= cv.setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr class="table-info">
	<td>(=)</td>
	<td>UTILIDAD BRUTA</td>
	<td></td>
	<td><%= (acum = acum.subtract(cv.setScale(2, RoundingMode.HALF_UP))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>GASTOS DE OPERACION</td>
	<td></td>
	<td><%= tg.setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td></td>
	<td>GASTOS DE ADMINISTRACION</td>
	<td><%= new BigDecimal(gda.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr>
	<td></td>
	<td>GASTOS DE VENTA</td>
	<td><%= new BigDecimal(gdv.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr>
	<td></td>
	<td>GASTOS FINANCIEROS</td>
	<td><%= new BigDecimal(gf.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
	<td></td>
         </tr>
         <tr class="table-info">
	<td>(=)</td>
	<td>UTILIDAD DE OPERACION</td>
	<td></td>
	<td><%= (acum = acum.subtract(tg.setScale(2, RoundingMode.HALF_UP))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>OTROS GASTOS</td>
	<td></td>
	<td><%= new BigDecimal(og.getSaldoD()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td>(+)</td>
	<td>OTROS INGRESOS</td>
	<td></td>
	<td><%= new BigDecimal(oi.getSaldoA()).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr class="table-info">
	<td>(=)</td>
	<td>UTILIDAD ANTES DE</td>
	<td></td>
	<td><%= (acum = acum.add(new BigDecimal(og.getSaldoD()).setScale(2, RoundingMode.HALF_UP).subtract(new BigDecimal(oi.getSaldoA()).setScale(2, RoundingMode.HALF_UP)))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
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
	<td><%= (reserva = acum.multiply(new BigDecimal("0.07"))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr class="table-info">
	<td>(=)</td>
	<td>UTILIDAD ANTES DE IMPUESTO</td>
	<td></td>
	<td><%= (acum = acum.subtract(reserva.setScale(2, RoundingMode.HALF_UP))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr>
	<td>(-)</td>
	<td>IMPUESTO SOBRE LA RENTA</td>
	<td></td>
	<td><%= (renta = acum.multiply(new BigDecimal("0.25"))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
         <tr class="table-info">
	<td>(=)</td>
	<td>UTILIDAD DEL EJERCICIO</td>
	<td></td>
	<td><%= (acum = acum.subtract(renta.setScale(2, RoundingMode.HALF_UP))).setScale(2, RoundingMode.HALF_UP).toString()%></td>
         </tr>
      </tbody>
   </table>
</div>

