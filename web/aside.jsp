<%-- 
    Document   : aside.jsp
    Created on : 08-14-2018, 10:13:37 AM
    Author     : student
--%>
<%@page import="modelo.validarPeriodo"%>
<div class="col-lg-3">

   <div class="list-group">
      <a class="list-group-item list-group-item-action" href="configuracion.jsp"><i class="text-danger fa fa-cog mr-1"></i>Configuración</a>
      <a class="list-group-item list-group-item-action" href="registrar-catalogo.jsp"><i class="text-danger fa fa-sitemap mr-1"></i>Registrar Catalogo</a>
      <%
         if (validarPeriodo.val()) {
      %>
      <a class="list-group-item list-group-item-action" href="registrar-partidas.jsp"><i class="text-danger fa fa-calculator mr-1"></i>Registrar Partidas</a>
      <a class="list-group-item list-group-item-action" href="mostrar-librodiario.jsp"><i class="text-danger fa fa-book mr-1"></i>Libro Diario</a>
      <a class="list-group-item list-group-item-action" href="libro-mayor.jsp"><i class="text-danger fa fa-book mr-1"></i>Libro Mayor</a>
      <a class="list-group-item list-group-item-action" href="balanza-de-comprobacion.jsp"><i class="text-danger fa fa-balance-scale mr-1"></i>Balanza de Comprobación</a>
      <a class="list-group-item list-group-item-action" href="mostrar-estado-de-resultados.jsp"><i class="text-danger fa fa-book mr-1"></i>Estado de Resultados</a>
      <a class="list-group-item list-group-item-action" href="balance-general.jsp"><i class="text-danger fa fa-balance-scale mr-1"></i>Balance General</a>
      <a class="list-group-item list-group-item-action" href="cierre.jsp"><i class="text-danger fa fa-lock mr-1"></i>Cierre Contable</a>
      <%
         }
      %>

   </div>
</div>
