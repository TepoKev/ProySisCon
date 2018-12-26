/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import controlador.Controlador;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author student
 */
public class EstResult {

   private Date fechaI;
   private Date fechaF;
   private BigDecimal inventarioF;
   private Controlador ctr;
   private SimpleDateFormat sdf;

   public EstResult() {
      try {
         Calendar calendario = new GregorianCalendar();
         this.sdf = new SimpleDateFormat("yyyy-MM-dd");
         this.fechaI = sdf.parse(String.valueOf(calendario.get(Calendar.YEAR)) + "-01-01");
         this.fechaF = sdf.parse(String.valueOf(calendario.get(Calendar.YEAR)) + "-12-31");
         this.inventarioF = new BigDecimal(0);
         this.ctr = new Controlador();
      } catch (ParseException e) {
         System.out.println(e.getMessage());
      }
   }

   public EstResult(Date fechaI, Date fechaF, BigDecimal inventarioF) {
      this.fechaI = fechaI;
      this.fechaF = fechaF;
      this.inventarioF = inventarioF.setScale(2, RoundingMode.HALF_UP);
      this.ctr = new Controlador();
   }
   
   public EstResult(Date fechaI, Date fechaF, String inventarioF) {
      this.fechaI = fechaI;
      this.fechaF = fechaF;
      this.inventarioF = new BigDecimal(inventarioF).setScale(2, RoundingMode.HALF_UP);
      this.ctr = new Controlador();
   }
   
   
   
}
