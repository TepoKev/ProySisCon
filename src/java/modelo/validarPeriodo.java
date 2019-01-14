/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import controlador.Controlador;

/**
 *
 * @author student
 */
public abstract class validarPeriodo {
   
   //Este metodo devolvera verdadero si se encuentra un periodo en curso, por lo contrario devolvera falso
   public static boolean val(){
      Controlador ctr = new Controlador();
      Periodo p = ctr.periodoNow();
      if(p == null){
         return false;
      }
      return true;
   }
   
   public static boolean valF(){
      Controlador ctr = new Controlador();
      Periodo p = ctr.periodoNow();
      if(p == null){
         return false;
      }else{
         if(p.getFinalizado() == true){
	return false;
         }
      }
      return true;
   }
   
}
