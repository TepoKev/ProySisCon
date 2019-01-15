<%-- 
    Document   : configuracion.jsp
    Created on : 12-21-2018, 05:26:37 PM
    Author     : Student
--%>

<%@page import="modelo.validarPeriodo"%>
<%@page import="java.time.LocalDate"%>
<%@page import="modelo.Periodo"%>
<%@page import="modelo.Parametro"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Configuración</title>
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="fonts/font-awesome.css">
      <link rel="stylesheet" href="fonts/fonts.css">
      <link rel="stylesheet" href="css/custom-tree.css">
      <script src="js/tether.min.js"></script>
      <script src="js/jquery-3.1.1.js"></script>
      <script src="js/bootstrap.js"></script>
   </head>
   <%
      Controlador ctr = new Controlador();
      Periodo periodoVal;
      if (request.getParameter("opc") != null) {
         if ("n".equals(request.getParameter("opc")) || "c".equals(request.getParameter("opc"))) {
	periodoVal = ctr.periodoNow();
	if ("n".equals(request.getParameter("opc")) && periodoVal != null) {
	   if (periodoVal.getEncurso() == true && periodoVal.getFinalizado() == false) {
   %>
   <script type="text/javascript">
      window.location = "configuracion.jsp?opc=c";
   </script>
   <%
         }
      }
      if ("c".equals(request.getParameter("opc"))) {
         if (periodoVal == null || periodoVal.getFinalizado() == true) {
   %>
   <script type="text/javascript">
      window.location = "configuracion.jsp?opc=n";
   </script>
   <%
         }
      }

   %>

   <!-- Aqui va el boody -->

   <body>
      <div class="bg-danger text-white" style="margin-bottom: 50px;">

         <div style="background-color: rgba(255,255,255,.2);">
	<div class="container">
	   <%@include file="nav.jsp" %>
	</div>
         </div>

         <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
	<h1 class="text-sm-center font-weight-bold">Configuración</h1>
         </div>

      </div>
      <div class="container">
         <div class="row">
	<%@include file="aside.jsp" %>
	<div class="col-lg-9">
	   <form class="mb-5" action="ServletConfig" method="post" name="frmConfig" id="frmConfig">
	      <%	         Periodo aux = null;
	      %>
	      <div class="text-right">
	         <a class="my-3 text-sm-center  btn btn-outline-info" href="configuracion.jsp?default=true">Configuración por defecto <i class="fa fa-cog"></i></a>
	      </div>
	      <%
	         String paramDefault = request.getParameter("default");
	         boolean predeterminada = "true".equalsIgnoreCase(paramDefault) ? true : false;
	      %>
	      <h2>Periodo de operación</h2>
	      <div class="alert alert-info">
	         Si desea ver el estado de resultados debe ingresar el valor del inventario final, 
	         los periodos de operaicón deben ingresarse para el correcto funcionamiento
	      </div>
	      <%
	         if (request.getParameter("opc").equals("n") && ctr.periodoNow() == null) {
		Periodo pero = ctr.periodoNow();
		Parametro fechI = new Parametro();
		Parametro fechF = new Parametro();
		Parametro invF = new Parametro();
		if (pero != null) {
		   fechI = ctr.recuperarParamPer("FECHA_INICIAL", pero.getId());
		   fechF = ctr.recuperarParamPer("FECHA_FINAL", pero.getId());
		   invF = ctr.recuperarParamPer("INVENTARIO_FINAL", pero.getId());
		}
	      %>
	      <input type="hidden" name="opc" id="opc" value="<%= request.getParameter("opc")%>">
	      <input type="hidden" name="idfI" id="idfI" value="<%= fechI.getId()%>">
	      <input type="hidden" name="idfF" id="idfF" value="<%= fechF.getId()%>">
	      <input type="hidden" name="invF" id="invF" value="<%= invF.getId()%>">
	      <div class="form-group row mt-3">
	         <label for="FECHA_INICIAL" class="col-sm-3 col-form-label">Fecha inicial</label>
	         <div class="col-sm-4">
		<input value="<%= LocalDate.now().getYear()%>-01-01" type="date" class="form-control" name="FECHA_INICIAL" id="FECHA_INICIAL" placeholder="Fecha inicial">
	         </div>
	         <div class="col-md-3 font-weight-bold">FECHA_INICIAL</div>
	      </div>

	      <div class="form-group row">
	         <label for="FECHA_FINAL" class="col-sm-3 col-form-label">Fecha final</label>
	         <div class="col-sm-4">
		<input value="<%= LocalDate.now().getYear()%>-12-31" type="date" class="form-control" name="FECHA_FINAL" id="FECHA_FINAL" placeholder="Fecha final">
	         </div>
	         <div class="col-md-3 font-weight-bold">FECHA_FINAL</div>
	      </div>
	      <div class="form-group row">
	         <label for="INVENTARIO_FINAL" class="col-sm-3 col-form-label">Inventario final</label>
	         <div class="col-sm-4">
		<input value=""  type="number" step="any" class="form-control" name="INVENTARIO_FINAL" id="INVENTARIO_FINAL" placeholder="Inventario final">
	         </div>
	         <div class="col-md-3 font-weight-bold">INVENTARIO_FINAL</div>
	      </div>
	      <hr>
	      <div class="form-group row">
	         <label class="col-sm-3 col-form-label">Ver periodo</label>
	         <div class="col-sm-4">
		<select class="form-control" name="selPer" id="selPer">
		   <option value="">
		      Seleccione...
		   </option>
		   <%
		      ArrayList<Periodo> per = (ArrayList<Periodo>) ctr.recuperarPeriodos();
		      for (Periodo p : per) {
		         if (p.getEncurso() == true && p.getFinalizado() == false) {
		   %>
		   <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%> Actual y En curso</option>
		   <%
		   } else {
		      if (p.getEncurso() == false && p.getFinalizado() == false) {
		   %>
		   <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%> En curso</option>
		   <%
		   } else {
		      if (p.getEncurso() == false && p.getFinalizado() == true) {
		         aux = p;
		   %>
		   <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%></option>
		   <%

		   } else {
		      if (p.getEncurso() == true && p.getFinalizado() == true) {
		         aux = p;
		   %>
		   <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%> Actual</option>
		   <%
			      }
			   }
			}
		         }
		      }
		   %>
		</select>
	         </div>
	         <%
	         } else {
		Periodo pero = ctr.periodoNow();
		Parametro fechI = new Parametro();
		Parametro fechF = new Parametro();
		Parametro invF = new Parametro();
		if (pero != null) {
		   fechI = ctr.recuperarParamPer("FECHA_INICIAL", pero.getId());
		   fechF = ctr.recuperarParamPer("FECHA_FINAL", pero.getId());
		   invF = ctr.recuperarParamPer("INVENTARIO_FINAL", pero.getId());
		}

	         %>
	         <input type="hidden" name="opc" id="opc" value="<%= request.getParameter("opc")%>">
	         <input type="hidden" name="idfI" id="idfI" value="<%= fechI.getId()%>">
	         <input type="hidden" name="idfF" id="idfF" value="<%= fechF.getId()%>">
	         <input type="hidden" name="invF" id="invF" value="<%= invF.getId()%>">
	         <div class="form-group row mt-3">
		<label for="FECHA_INICIAL" class="col-sm-3 col-form-label">Fecha inicial</label>
		<div class="col-sm-4">
		   <%if (predeterminada) {
		   %>
		   <input value="2018-01-01" type="date" class="form-control" name="FECHA_INICIAL" id="FECHA_INICIAL" placeholder="Fecha inicial">
		   <%
		   } else {%>
		   <input value="<%= fechI.getValor()%>" type="date" class="form-control" name="FECHA_INICIAL" id="FECHA_INICIAL" placeholder="Fecha inicial">
		   <%}%>
		</div>
		<div class="col-md-3 font-weight-bold">FECHA_INICIAL</div>
	         </div>

	         <div class="form-group row">
		<label for="FECHA_FINAL" class="col-sm-3 col-form-label">Fecha final</label>
		<div class="col-sm-4">
		   <%if (predeterminada) {
		   %>
		   <input value="2018-12-31" type="date" class="form-control" name="FECHA_FINAL" id="FECHA_FINAL" placeholder="Fecha final">
		   <%
		   } else {%>
		   <input value="<%= fechF.getValor()%>" type="date" class="form-control" name="FECHA_FINAL" id="FECHA_FINAL" placeholder="Fecha final">
		   <%}%>
		</div>
		<div class="col-md-3 font-weight-bold">FECHA_FINAL</div>
	         </div>
	         <div class="form-group row">
		<label for="INVENTARIO_FINAL" class="col-sm-3 col-form-label">Inventario final</label>
		<div class="col-sm-4">
		   <%if (predeterminada) {
		   %>
		   <input value=""  type="number" step="any" class="form-control" name="INVENTARIO_FINAL" id="INVENTARIO_FINAL" placeholder="Inventario final">
		   <%
		   } else {%>
		   <input value="<%= invF.getValor()%>" type="number" step="any" class="form-control" name="INVENTARIO_FINAL" id="INVENTARIO_FINAL" placeholder="Inventario final">
		   <%}%>
		</div>
		<div class="col-md-3 font-weight-bold">INVENTARIO_FINAL</div>
	         </div>
	         <hr>
	         <div class="form-group row">
		<label class="col-sm-3 col-form-label">Ver periodo</label>
		<div class="col-sm-4">
		   <select class="form-control" name="selPer" id="selPer">
		      <option value="">
		         Seleccione...
		      </option>
		      <%

		         ArrayList<Periodo> per = (ArrayList<Periodo>) ctr.recuperarPeriodos();
		         for (Periodo p : per) {
			if (p != null) {
			   if (p.getEncurso() == true && p.getFinalizado() == false) {
		      %>
		      <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%> Actual y En curso</option>
		      <%
		      } else {
		         if (p.getEncurso() == false && p.getFinalizado() == false) {
		      %>
		      <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%> En curso</option>
		      <%
		      } else {
		         if (p.getEncurso() == false && p.getFinalizado() == true) {
			aux = p;
		      %>
		      <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%></option>
		      <%

		      } else {
		         if (p.getEncurso() == true && p.getFinalizado() == true) {
			aux = p;
		      %>
		      <option value="<%= p.getId()%>">Periodo <%=p.getFechaInicial().toString()%> hasta <%=p.getFechaFinal().toString()%> Actual</option>
		      <%

				}
			         }
			      }
			   }
			}
		         }
		      %>
		   </select>
		</div>

		<%
		   }
		%>

	         </div>
	         <div class="text-center mt-4">
		<button type="reset" class="btn btn-warning"><i class="fa fa-undo"></i> Limpiar campos</button>
		<button type="submit" class="btn text-center btn-success"><i class="fa fa-check"></i>
		   <%
		      if (request.getParameter("opc").equals("n")) {
		   %>
		   Iniciar Periodo
		   <%
		   } else {
		   %>
		   Aplicar Configuracion
		   <%
		      }
		   %>
		</button>
	         </div>
	      </div>
	   </form>

	</div>
         </div>
      </div>

      <footer class="badge-danger text-white mt-3" style="min-height: 170px">
         <div class="container">
         </div>
      </footer>
   </body>


   <%
         } else {
	out.print(validarPeriodo.fullValidacion());
         }
      } else {
         out.print(validarPeriodo.fullValidacion());
      }
   %>
</html>