<%-- 
    Document   : index
    Created on : 08-21-2018, 07:07:37 PM
    Author     : student
--%>
<%@page import="modelo.Periodo"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="fonts/font-awesome.css">
      <link rel="stylesheet" href="fonts/fonts.css">
      <link rel="stylesheet" href="css/style.css">
      <script src="js/jquery-3.2.1.slim.min.js"></script>
      <script src="js/bootstrap.min.js"></script>
      <title>ProySisCon</title>
      <style>
         .card {
	box-shadow: 0 0 20px rgba(100, 100, 100, .5);
         }
         body {
	background-image: url('images/background.png');
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-position: center;
	background-size: cover; 

         }

         .card {

	background-color: rgba(23, 162, 184,.8)!important;
	background-color: rgba(70, 70,70 ,.8)!important;
	background-image: linear-gradient(rgba(255,255,255,.2), rgba(23, 162, 184,.4));
         }
      </style>
   </head>
   <body>
      <!-- Modal -->
      <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog" role="document">
	<div class="modal-content">
	   <div class="modal-header">
	      <h5 class="modal-title" id="exampleModalLabel">Desea cerrar el ejercicio</h5>
	      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	         <span aria-hidden="true">&times;</span>
	      </button>
	   </div>
	   <div class="modal-body">
	      Realmente desea finalizar el periodo contable ya no se podra revertir esta operacion
	   </div>
	   <div class="modal-footer">
	      <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
	      <a href="cierre.jsp" class="btn btn-primary"><i class="fa fa-lock"></i> Aceptar</a>
	   </div>
	</div>
         </div>
      </div>
      <div class="text-white" style="margin-bottom: 50px;">

         <div class="bg-danger">
	<div class="container">
	   <%@include file="nav.jsp" %>
	</div>
         </div>

         <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
	<h1 class="text-sm-center font-weight-bold" style="  text-shadow: 2px 2px 8px #000;">ProySisCon</h1>
         </div>

      </div>

      <div class="container" style="margin-bottom: 9rem;margin-top: 5rem;">
         <%
	Controlador ctr = new Controlador();
	Periodo p = ctr.periodoNow();
	if (p == null) {
         %>
         <div class='card-deck mb-4'>
	<div class="card bg-info text-white">
	   <!--<img class="card-img-top" src="" alt=""> !-->
	   <div class="card-body" style="">
	      <h5 class="card-title">Cuentas</h5>
	      <p class="card-text">Ver el catálogo de cuentas, y/o hacer modificaciones</p>
	      <a href="registrar-catalogo.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>

	<div class="card bg-info text-white">
	   <!--<img class="card-img-top" src="" alt=""> !-->
	   <div class="card-body" style="">
	      <h5 class="card-title">Iniciar Periodo de Operacion</h5>
	      <p class="card-text">Da inicio a un periodo contable para lo cual se necesitan ciertos parametros de entrada</p>
	      <a href="configuracion.jsp?opc=n" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <%
         } else {
	if (p.getEncurso() == true && p.getFinalizado() == true) {
         %>
         <div class='card-deck mb-4'>
	<div class="card bg-info text-white">
	   <!--<img class="card-img-top" src="" alt=""> !-->
	   <div class="card-body" style="">
	      <h5 class="card-title">Cuentas</h5>
	      <p class="card-text">Ver el catálogo de cuentas, y/o hacer modificaciones</p>
	      <a href="registrar-catalogo.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class='card-title'>Libro Diario</h5>
	      <p class="card-text">Ver las partidas / transacciones registradas</p>
	      <a href="mostrar-librodiario.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <div class="card-deck mb-4">
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Libro mayor</h5>
	      <p class="card-text">Ver la mayorización en cualquier momento</p>
	      <a href="libro-mayor.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Balanza de comoprobación</h5>
	      <p class="card-text">Mostrar la balanza de comprobacion para hacer comprobaciones</p>
	      <a href="balanza-de-comprobacion.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Estado de resultados</h5>
	      <p class="card-text">Mostrar el estado de resultados, para poder ver la utilidad en cualquier momento</p>
	      <a href="mostrar-estado-de-resultados.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <div class="card-deck">
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Balance General</h5>
	      <p class="card-text"> </p>
	      <a href="balance-general.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <%
         } else {
	if (p.getEncurso() == true && p.getFinalizado() == false) {
	}
         %>
         <div class='card-deck mb-4'>
	<div class="card bg-info text-white">
	   <!--<img class="card-img-top" src="" alt=""> !-->
	   <div class="card-body" style="">
	      <h5 class="card-title">Cuentas</h5>
	      <p class="card-text">Ver el catálogo de cuentas, y/o hacer modificaciones</p>
	      <a href="registrar-catalogo.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>

	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Partidas</h5>
	      <p class="card-text">Registrar una o varias partidas / transacciones</p>
	      <a href="registrar-partidas.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class='card-title'>Libro Diario</h5>
	      <p class="card-text">Ver las partidas / transacciones registradas</p>
	      <a href="mostrar-librodiario.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <div class="card-deck mb-4">
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Libro mayor</h5>
	      <p class="card-text">Ver la mayorización en cualquier momento</p>
	      <a href="libro-mayor.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Balanza de comoprobación</h5>
	      <p class="card-text">Mostrar la balanza de comprobacion para hacer comprobaciones</p>
	      <a href="balanza-de-comprobacion.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Estado de resultados</h5>
	      <p class="card-text">Mostrar el estado de resultados, para poder ver la utilidad en cualquier momento</p>
	      <a href="mostrar-estado-de-resultados.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <div class="card-deck">
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Balance General</h5>
	      <p class="card-text"> </p>
	      <a href="balance-general.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card bg-info text-white">
	   <div class="card-body">
	      <h5 class="card-title">Cierre contable</h5>
	      <p class="card-text"> </p>
	      <a href="cierre.jsp" class="btn btn-info" data-toggle="modal" data-target="#exampleModal">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <%
	   }
	}
         %>

      </div>
      <footer style="min-height: 170px" class="text-white bg-info">
         <div class="container">

         </div>
      </footer>
   </body>
</html>