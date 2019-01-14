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
         String fechaI = request.getParameter("FECHA_INICIAL");
         String fechaF = request.getParameter("FECHA_FINAL");
         String inventarioF = request.getParameter("INVENTARIO_FINAL");
         String idPeriodo = request.getParameter("selPer");
         String opc = request.getParameter("opc");
         RequestDispatcher dispatcher;
         if ("".equals(inventarioF)) {
	inventarioF = "0";
         }
         Controlador ctr = new Controlador();
         Periodo actual;
         ctr.actualizarParamNombre("FECHA_INICIAL", fechaI);
         ctr.actualizarParamNombre("FECHA_FINAL", fechaF);
         ctr.actualizarParamNombre("INVENTARIO_FINAL", inventarioF);
         if ("n".equals(opc)) {
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
	   if (bActual != null && actual != null) {
	      bActual.setEncurso(true);
	      actual.setEncurso(false);
	      ctr.actualizar(actual);
	      ctr.actualizar(bActual);
	      dispatcher = request.getRequestDispatcher("index.jsp");
	      dispatcher.forward(request, response);
	   }
	} else {
	   if ("c".equals(opc) && idPeriodo.isEmpty()) {
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

	      dispatcher = request.getRequestDispatcher("index.jsp");
	      dispatcher.forward(request, response);
	   }
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
