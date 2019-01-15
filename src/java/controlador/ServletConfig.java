/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Parametro;
import modelo.Periodo;

/**
 *
 * @author student
 */
public class ServletConfig extends HttpServlet {

   /**
    * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
    * methods.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException, ParseException {
      response.setContentType("text/html;charset=UTF-8");
      try {
         String idPeriodo = request.getParameter("selPer");
         String opc = request.getParameter("opc");
         String fI = request.getParameter("idfI");
         String fF = request.getParameter("idfF");
         String iF = request.getParameter("invF");
         Parametro paramFechI;
         Parametro paramFechF;
         Parametro paramInvF;
         if (request.getParameter("idfI").isEmpty() && request.getParameter("idfI").isEmpty() && request.getParameter("invF").isEmpty()) {
	paramFechI = new Parametro();
	paramFechF = new Parametro();
	paramInvF = new Parametro();
         } else {
	paramFechI = new Parametro(Integer.parseInt(request.getParameter("idfI")), "FECHA_INICIAL", request.getParameter("FECHA_INICIAL"));
	paramFechF = new Parametro(Integer.parseInt(request.getParameter("idfF")), "FECHA_FINAL", request.getParameter("FECHA_FINAL"));
	paramInvF = new Parametro(Integer.parseInt(request.getParameter("invF")), "INVENTARIO_FINAL", request.getParameter("INVENTARIO_FINAL"));
         }

         RequestDispatcher dispatcher;
         Periodo actual, bActual;
         Controlador ctr = new Controlador();
         if ("".equals(paramInvF.getValor())) {
	paramInvF.setValor("0");
         }
         if ("n".equals(opc)) {
	if (idPeriodo.isEmpty() && ctr.periodoNow() == null) {
	   actual = new Periodo(request.getParameter("FECHA_INICIAL"), request.getParameter("FECHA_FINAL"), true, false);
	   actual.setId((int) ctr.guardar(actual));
	   paramFechI.setPeriodo(actual);
	   ctr.guardar(paramFechI);
	   paramFechF.setPeriodo(actual);
	   ctr.guardar(paramFechF);
	   paramInvF.setPeriodo(actual);
	   ctr.guardar(paramInvF);
	   dispatcher = request.getRequestDispatcher("index.jsp");
	   dispatcher.forward(request, response);
	} else {
	   if (!idPeriodo.isEmpty() && ctr.periodoNow() == null) {
	      actual = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	      actual.setEncurso(true);
	      ctr.actualizar(actual);
	      dispatcher = request.getRequestDispatcher("index.jsp");
	      dispatcher.forward(request, response);
	   } else {
	      if (!idPeriodo.isEmpty() && ctr.periodoNow() != null) {
	         actual = ctr.periodoNow();
	         actual.setEncurso(false);
	         ctr.actualizar(actual);
	         bActual = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	         bActual.setEncurso(true);
	         ctr.actualizar(bActual);
	         dispatcher = request.getRequestDispatcher("index.jsp");
	         dispatcher.forward(request, response);
	      } else {
	         if (idPeriodo.isEmpty() && ctr.periodoNow() != null) {
		actual = ctr.periodoNow();
		actual.setEncurso(false);
		ctr.actualizar(actual);
		actual = new Periodo(request.getParameter("FECHA_INICIAL"), request.getParameter("FECHA_FINAL"), true, false);
		actual.setId((int) ctr.guardar(actual));
		paramFechI.setPeriodo(actual);
		ctr.guardar(paramFechI);
		paramFechF.setPeriodo(actual);
		ctr.guardar(paramFechF);
		paramInvF.setPeriodo(actual);
		ctr.guardar(paramInvF);
		dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	         }
	      }

	   }

	}

         } else {
	if (idPeriodo.isEmpty()) {
	   actual = ctr.periodoNow();
	   paramFechI.setPeriodo(actual);
	   paramFechF.setPeriodo(actual);
	   paramInvF.setPeriodo(actual);
	   ctr.actualizar(paramFechI);
	   ctr.actualizar(paramFechF);
	   ctr.actualizar(paramInvF);
	   dispatcher = request.getRequestDispatcher("configuracion.jsp");
	   dispatcher.forward(request, response);
	} else {
	   actual = ctr.periodoNow();
	   bActual = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	   paramFechI.setPeriodo(actual);
	   paramFechF.setPeriodo(actual);
	   paramInvF.setPeriodo(actual);
	   ctr.actualizar(paramFechI);
	   ctr.actualizar(paramFechF);
	   ctr.actualizar(paramInvF);
	   actual.setEncurso(false);
	   ctr.actualizar(actual);
	   bActual.setEncurso(true);
	   ctr.actualizar(bActual);
	   dispatcher = request.getRequestDispatcher("index.jsp");
	   dispatcher.forward(request, response);
	}
         }

         dispatcher = request.getRequestDispatcher("configuracion.jsp");
         dispatcher.forward(request, response);
      } catch (IOException | ServletException e) {
      }
   }

   // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
   /**
    * Handles the HTTP <code>GET</code> method.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
      try {
         processRequest(request, response);

      } catch (ParseException ex) {
         Logger.getLogger(ServletConfig.class
	     .getName()).log(Level.SEVERE, null, ex);
      }
   }

   /**
    * Handles the HTTP <code>POST</code> method.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
      try {
         processRequest(request, response);

      } catch (ParseException ex) {
         Logger.getLogger(ServletConfig.class
	     .getName()).log(Level.SEVERE, null, ex);
      }
   }

   /**
    * Returns a short description of the servlet.
    *
    * @return a String containing servlet description
    */
   @Override
   public String getServletInfo() {
      return "Short description";
   }// </editor-fold>

}


/*if ("n".equals(opc)) {
	if (idPeriodo.isEmpty()) {
	   actual = new Periodo();
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	   actual.setFechaInicial(sdf.parse(fechaI));
	   actual.setFechaFinal(sdf.parse(fechaF));
	   actual.setEncurso(true);
	   actual.setFinalizado(false);
	   ArrayList<Periodo> pers = (ArrayList<Periodo>) ctr.recuperarPeriodos();
	   for (Periodo per : pers) {
	      if (per.getEncurso() == true) {
	         per.setEncurso(false);
	         ctr.actualizar(per);
	      }
	   }
	   ctr.guardar(actual);
	} else {
	   Periodo bActual = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	   bActual.setEncurso(true);
	   ctr.actualizar(bActual);
	}
	dispatcher = request.getRequestDispatcher("index.jsp");
	dispatcher.forward(request, response);
         } else {
	if ("c".equals(opc) && !idPeriodo.isEmpty()) {
	   Periodo bActual = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	   actual = ctr.periodoNow();
	   if (bActual != null && actual != null && bActual.getId() != actual.getId()) {
	      bActual.setEncurso(true);
	      actual.setEncurso(false);
	      ctr.actualizar(actual);
	      ctr.actualizar(bActual);
	      dispatcher = request.getRequestDispatcher("index.jsp");
	      dispatcher.forward(request, response);
	   }
	} else {
	   if ("c".equals(opc) && idPeriodo.isEmpty()) {
	      if (ctr.periodoNow() == null) {
	         actual = new Periodo();
	         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	         actual.setFechaInicial(sdf.parse(fechaI));
	         actual.setFechaFinal(sdf.parse(fechaF));
	         actual.setEncurso(true);
	         actual.setFinalizado(false);
	         ArrayList<Periodo> pers = (ArrayList<Periodo>) ctr.recuperarPeriodos();
	         for (Periodo per : pers) {
		if (per.getEncurso() == true) {
		   per.setEncurso(false);
		   ctr.actualizar(per);
		}
	         }
	         actual.setId((int) ctr.guardar(actual));
	         Parametro fechaIact = new Parametro(actual,"FECHA_INICIAL", fechaI);
	         ctr.guardar(fechaIact);
	         Parametro fechaFact = new Parametro(actual, "FECHA_FINAL", fechaF);
	         ctr.guardar(fechaFact);
	         Parametro invFact = new Parametro(actual, "INVENTARIO_FINAL", inventarioF);
	         ctr.guardar(invFact);
	         dispatcher = request.getRequestDispatcher("index.jsp");
	         dispatcher.forward(request, response);
	      } else {
	         actual = ctr.periodoNow();
	         ctr.actualizarParamNombre("FECHA_INICIAL", fechaI, actual.getId());
	         ctr.actualizarParamNombre("FECHA_FINAL", fechaF, actual.getId());
	         ctr.actualizarParamNombre("INVENTARIO_FINAL", inventarioF, actual.getId());
	      }
	   }
	}
         }*/

 /*if ("n".equals(opc)) {
	if (idPeriodo.isEmpty()) {
	   actual = new Periodo();
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	   actual.setFechaInicial(sdf.parse(fechaI));
	   actual.setFechaFinal(sdf.parse(fechaF));
	   actual.setEncurso(true);
	   actual.setFinalizado(false);
	   ArrayList<Periodo> pers = (ArrayList<Periodo>) ctr.recuperarPeriodos();
	   for (Periodo per : pers) {
	      if (per.getEncurso() == true) {
	         per.setEncurso(false);
	         ctr.actualizar(per);
	      }
	   }
	   ctr.guardar(actual);
	} else {
	   Periodo bAct = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	   bAct.setEncurso(true);
	   ctr.actualizar(bAct);
	   dispatcher = request.getRequestDispatcher("index.jsp");
	   dispatcher.forward(request, response);
	}

         } else {
	if ("c".equals(opc)) {
	   actual = ctr.periodoNow();
	   if (actual.getFinalizado() == false && idPeriodo.isEmpty()) {
	      Parametro paramFechI = new Parametro(Integer.parseInt(request.getParameter("idfI")));
	      Parametro paramFechF = new Parametro(Integer.parseInt(request.getParameter("idfF")));
	      Parametro paramInvF = new Parametro(Integer.parseInt(request.getParameter("invF")));
	      paramFechI.setValor(fechaI);
	      paramFechI.setNombre("FECHA_INICIAL");
	      paramFechI.setPeriodo(actual);
	      ctr.actualizar(paramFechI);
	      paramFechF.setNombre("FECHA_FINAL");
	      paramFechF.setValor(fechaF);
	      paramFechF.setPeriodo(actual);
	      ctr.actualizar(paramFechF);
	      paramInvF.setNombre("INVENTARIO_FINAL");
	      paramInvF.setValor(inventarioF);
	      paramInvF.setPeriodo(actual);
	      ctr.actualizar(paramInvF);
	      dispatcher = request.getRequestDispatcher("configuracion.jsp");
	      dispatcher.forward(request, response);
	   } else {
	      if (!idPeriodo.isEmpty() && actual.getFinalizado() == true) {
	         Periodo bAct = ctr.recuperarPeriodo(Integer.parseInt(idPeriodo));
	         bAct.setEncurso(true);
	         actual.setEncurso(false);
	         ctr.actualizar(actual);
	         ctr.actualizar(bAct);
	         dispatcher = request.getRequestDispatcher("index.jsp");
	         dispatcher.forward(request, response);
	      } else {
	         if (idPeriodo.isEmpty()  && ctr.periodoNow().getFinalizado() == true) {
		Parametro paramFechI = new Parametro(Integer.parseInt(request.getParameter("idfI")));
		Parametro paramFechF = new Parametro(Integer.parseInt(request.getParameter("idfF")));
		Parametro paramInvF = new Parametro(Integer.parseInt(request.getParameter("invF")));
		actual = new Periodo(fechaI, fechaF, true, false);
		actual.setId((int) ctr.guardar(actual));
		paramFechI.setValor(fechaI);
		paramFechI.setNombre("FECHA_INICIAL");
		paramFechI.setPeriodo(actual);
		ctr.actualizar(paramFechI);
		paramFechF.setNombre("FECHA_FINAL");
		paramFechF.setValor(fechaF);
		paramFechF.setPeriodo(actual);
		ctr.actualizar(paramFechF);
		paramInvF.setNombre("INVENTARIO_FINAL");
		paramInvF.setValor(inventarioF);
		paramInvF.setPeriodo(actual);
		ctr.actualizar(paramInvF);
		dispatcher = request.getRequestDispatcher("configuracion.jsp");
		dispatcher.forward(request, response);
	         }
	      }
	   }
	}
         }*/
