<%-- 
    Document   : index
    Created on : 08-21-2018, 07:07:37 PM
    Author     : student
--%>
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
              box-shadow: 0 0 15px rgba(10, 10, 10, 0.3);
          }
      </style>
   </head>
   <body>
      <div class="bg-danger text-white" style="margin-bottom: 50px;">

         <div style="background-color: rgba(255,255,255,.1);">
	<div class="container">
	   <%@include file="nav.jsp" %>
	</div>
         </div>

         <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
	<h1 class="text-sm-center font-weight-bold">ProySisCon</h1>
         </div>

      </div>
      <div class="container" style="margin-bottom: 9rem;margin-top: 5rem; ">
         <div class='card-deck'>
	<div class="card"">
	   <!--<img class="card-img-top" src="" alt=""> !-->
	   <div class="card-body">
	      <h5 class="card-title">Cuentas</h5>
	      <p class="card-text">Ver el catálogo de cuentas, y/o hacer modificaciones</p>
	      <a href="registrar-catalogo.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Partidas</h5>
	      <p class="card-text">Registrar una o varias partidas / transacciones</p>
	      <a href="registrar-partidas.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card">
	   <div class="card-body">
	      <h5 class='card-title'>Libro Diario</h5>
	      <p class="card-text">Ver las partidas / transacciones registradas</p>
	      <a href="mostrar-librodiario.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>
         <div class="card-deck">
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Libro mayor</h5>
	      <p class="card-text">Ver la mayorización en cualquier momento</p>
	      <a href="libro-mayor.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Balanza de comoprobación</h5>
	      <p class="card-text">Mostrar la balanza de comprobacion para hacer comprobaciones</p>
	      <a href="balanza-de-comprobacion.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Estado de resultados</h5>
	      <p class="card-text">Mostrar el estado de resultados, para poder ver la utilidad en cualquier momento</p>
	      <a href="mostrar-estado-de-resultados.jsp" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
         </div>

         <div class="card-deck">
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Balance General</h5>
	      <p class="card-text"> </p>
	      <a href="#" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Cierre contable</h5>
	      <p class="card-text"> </p>
	      <a href="#" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
	   </div>
	</div>
	<div class="card">
	   <div class="card-body">
	      <h5 class="card-title">Exportar</h5>
	      <p class="card-text">Exportar cuentas, partidas / transacciones a Microsoft Excel o hacer un Backup de la base de datos</p>
	      <a href="#" class="btn btn-info">Ver más <i class="fa fa-plus"></i></a>
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