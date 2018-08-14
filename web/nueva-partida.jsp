
<%@page import="controlador.Controlador"%>
<%-- 
Document   : nueva-partida
Created on : 12-30-2017, 09:22:54 PM
Author     : deb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   Controlador ctl = new Controlador();
   String c = request.getParameter("num-partida");
   long i;
   if (c != null) {
      try {
         i = Long.parseLong(c);
         if (i < 0) {
	i = ctl.sigContador();
	i--;
         } else {
	i++;
         }
      } catch (Exception e) {
         return;
      }
   } else {
      i = 0;
      return;
   }
%>
<%
   String opcion = request.getParameter("ajax-opcion");
   if (opcion == null) {
      return;
   }
   if (opcion.equals("partida")) {
%>
<%--
   Esta pagina imprime un div que contiene lo siguiente: 
   div data-num-partida data-type="partida"
	  h2 con un texto indicativo y el numero de partida
	  div data-type="lista-dh" este div contiene una lista formada por 3 elementos:
		div
		 la cuenta
		div
		 un input para escribir el cargo
		div
		 un input para escribir el abono
	  
--%>
<div class="mb-3 mt-1" data-num-partida="<%=i%>" data-type="partida">
   <a data-type='btn-agregar' href="#">
      <i class="fa fa-plus text-primary"></i> Cargo o abono
   </a>
   <a class="ml-3 text-muted" data-type='btn-eliminar-partida' href="#">
      <i class="fa fa-trash text-danger"></i> Eliminar partida
   </a>
   <div class="row">
      <div class="col-md-3">
         <h2>Partida # <span data-type="contador" class="text-primary"><%=i%></span></h2>
      </div>
      <div class="col-md-3" data-type="fecha">
         <input type="date" class="form-control" name="fecha" placeholder="Fecha de transacción">
      </div>
   </div>
   <div data-type="lista-dh" >
      <div data-type="dh" class="row mb-1">
         <div class="col-md-6">
	<input type="checkbox" data-type="checkbox-eliminar">
	<a href="#" data-codigo="" class="text-muted font-weight-bold">Seleccionar cuenta</a>
         </div>
         <div class="col-md-3">
	<input class="form-control" name="cargo" type="text" placeholder="Cargo">
         </div>
         <div class="col-md-3">
	<input class="form-control" name="abono" type="text" placeholder="Abono">
         </div>
      </div>
      <div data-type="dh" class="row mb-1">
         <div class="col-md-6">
	<input type="checkbox" data-type="checkbox-eliminar">
	<a href="#" data-codigo="" class="text-muted font-weight-bold">Seleccionar cuenta</a>
         </div>
         <div class="col-md-3">
	<input class="form-control" name="cargo" type="text" placeholder="Cargo">
         </div>
         <div class="col-md-3">
	<input class="form-control" name="abono" type="text" placeholder="Abono">
         </div>
      </div>
   </div>
   <div class="row mb-3" data-type="total-partida">
      <div class="col-md-3">
         <a class="text-danger" data-type="btn-eliminar-ch" href="#"><i class="fa fa-trash"></i> Eliminar la selección</a>
      </div>
      <div class="col-md-3 text-right">Totales:</div>
      <div class="col-md-3" data-type="total-cargo">$</div>
      <div class="col-md-3" data-type="total-abono">$</div>
   </div>
   <div data-type="descripcion">
      <textarea class="form-control" name="descripcion" placeholder="Descripcion de la transacción"></textarea>
   </div>

</div>
<%
} else if (opcion.equals("cargo-abono")) {
%>
<div data-type="dh" class="row mb-1">

   <div class="col-md-6">
      <input type="checkbox" data-type="checkbox-eliminar">
      <a href="#" data-codigo="" class="text-muted font-weight-bold">Seleccionar cuenta</a>
   </div>
   <div class="col-md-3">
      <input class="form-control" name="cargo" type="text" placeholder="Cargo">
   </div>
   <div class="col-md-3">
      <input class="form-control" name="abono" type="text" placeholder="Abono">
   </div>
</div>
<%
   }
%>
