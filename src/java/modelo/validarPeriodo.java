/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import controlador.Controlador;
import static java.lang.System.out;

/**
 *
 * @author student
 */
public abstract class validarPeriodo {

   //Este metodo devolvera verdadero si se encuentra un periodo en curso, por lo contrario devolvera falso
   public static boolean val() {
      Controlador ctr = new Controlador();
      Periodo p = ctr.periodoNow();
      if (p == null) {
         return false;
      }
      return true;
   }

   public static boolean valF() {
      Controlador ctr = new Controlador();
      Periodo p = ctr.periodoNow();
      if (p == null) {
         return false;
      } else {
         if (p.getFinalizado() == true) {
	return false;
         }
      }
      return true;
   }

   public static String fullValidacion() {
      Controlador ctr = new Controlador();
      Periodo p = ctr.periodoNow();
      if (p == null) {
         return "<script type=\"text/javascript\">\n"
	     + "      window.location = \"configuracion.jsp?opc=n\";\n"
	     + "</script>";
      }
      if (p.getEncurso() == true && p.getFinalizado() == false) {
         return "<script type=\"text/javascript\">\n"
	     + "      window.location = \"configuracion.jsp?opc=c\";\n"
	     + "</script>";
      }
      if (p.getEncurso() == true && p.getFinalizado() == true) {
         return "<script type=\"text/javascript\">\n"
	     + "      window.location = \"configuracion.jsp?opc=n\";\n"
	     + "</script>";
      }
      return "";
   }

}
