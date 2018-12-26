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
   private BigDecimal porc_reserva;
   private BigDecimal porc_imp_renta;
   private String extremo_aplicacion;
   private BigDecimal ventas;
   private BigDecimal reb_deb_ventas;
   private BigDecimal compras;
   private BigDecimal gastos_compras;
   private BigDecimal reb_deb_compras;
   private BigDecimal inventarioI;
   private BigDecimal gast_admon;
   private BigDecimal gast_vent;
   private BigDecimal gast_fin;
   private BigDecimal otros_gast;
   private BigDecimal otros_ingre;
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
         this.porc_reserva = new BigDecimal(0);
         this.porc_imp_renta = new BigDecimal(0);
         this.extremo_aplicacion = "";
         this.ventas = new BigDecimal(0);
         this.reb_deb_ventas = new BigDecimal(0);
         this.compras = new BigDecimal(0);
         this.gastos_compras = new BigDecimal(0);
         this.reb_deb_compras = new BigDecimal(0);
         this.inventarioI = new BigDecimal(0);
         this.gast_admon = new BigDecimal(0);
         this.gast_vent = new BigDecimal(0);
         this.gast_fin = new BigDecimal(0);
         this.otros_gast = new BigDecimal(0);
         this.otros_ingre = new BigDecimal(0);
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

   public EstResult(Date fechaI, Date fechaF, BigDecimal inventarioF, BigDecimal porc_reserva, BigDecimal porc_imp_renta, String extremo_aplicacion, BigDecimal ventas, BigDecimal reb_deb_ventas, BigDecimal compras, BigDecimal gastos_compras, BigDecimal reb_deb_compras, BigDecimal inventarioI, BigDecimal gast_admon, BigDecimal gast_vent, BigDecimal gast_fin, BigDecimal otros_gast, BigDecimal otros_ingre) {
      this.fechaI = fechaI;
      this.fechaF = fechaF;
      this.inventarioF = inventarioF.setScale(2, RoundingMode.HALF_UP);
      this.porc_reserva = porc_reserva.setScale(2, RoundingMode.HALF_UP);
      this.porc_imp_renta = porc_imp_renta.setScale(2, RoundingMode.HALF_UP);
      this.extremo_aplicacion = extremo_aplicacion;
      this.ventas = ventas.setScale(2, RoundingMode.HALF_UP);
      this.reb_deb_ventas = reb_deb_ventas.setScale(2, RoundingMode.HALF_UP);
      this.compras = compras.setScale(2, RoundingMode.HALF_UP);
      this.gastos_compras = gastos_compras.setScale(2, RoundingMode.HALF_UP);
      this.reb_deb_compras = reb_deb_compras.setScale(2, RoundingMode.HALF_UP);
      this.inventarioI = inventarioI.setScale(2, RoundingMode.HALF_UP);
      this.gast_admon = gast_admon.setScale(2, RoundingMode.HALF_UP);
      this.gast_vent = gast_vent.setScale(2, RoundingMode.HALF_UP);
      this.gast_fin = gast_fin.setScale(2, RoundingMode.HALF_UP);
      this.otros_gast = otros_gast.setScale(2, RoundingMode.HALF_UP);
      this.otros_ingre = otros_ingre.setScale(2, RoundingMode.HALF_UP);
      Calendar calendario = new GregorianCalendar();
      this.sdf = new SimpleDateFormat("yyyy-MM-dd");
      this.ctr = new Controlador();
   }

   public Date getFechaI() {
      return fechaI;
   }

   public void setFechaI(Date fechaI) {
      this.fechaI = fechaI;
   }

   public Date getFechaF() {
      return fechaF;
   }

   public void setFechaF(Date fechaF) {
      this.fechaF = fechaF;
   }

   public BigDecimal getInventarioF() {
      return inventarioF.setScale(2, RoundingMode.HALF_UP);
   }

   public void setInventarioF(BigDecimal inventarioF) {
      this.inventarioF = inventarioF.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getPorc_reserva() {
      return porc_reserva.setScale(2, RoundingMode.HALF_UP);
   }

   public void setPorc_reserva(BigDecimal porc_reserva) {
      this.porc_reserva = porc_reserva.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getPorc_imp_renta() {
      return porc_imp_renta.setScale(2, RoundingMode.HALF_UP);
   }

   public void setPorc_imp_renta(BigDecimal porc_imp_renta) {
      this.porc_imp_renta = porc_imp_renta.setScale(2, RoundingMode.HALF_UP);
   }

   public String getExtremo_aplicacion() {
      return extremo_aplicacion;
   }

   public void setExtremo_aplicacion(String extremo_aplicacion) {
      this.extremo_aplicacion = extremo_aplicacion;
   }

   public BigDecimal getVentas() {
      return ventas.setScale(2, RoundingMode.HALF_UP);
   }

   public void setVentas(BigDecimal ventas) {
      this.ventas = ventas.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getReb_deb_ventas() {
      return reb_deb_ventas.setScale(2, RoundingMode.HALF_UP);
   }

   public void setReb_deb_ventas(BigDecimal reb_deb_ventas) {
      this.reb_deb_ventas = reb_deb_ventas.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getCompras() {
      return compras.setScale(2, RoundingMode.HALF_UP);
   }

   public void setCompras(BigDecimal compras) {
      this.compras = compras.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getGastos_compras() {
      return gastos_compras.setScale(2, RoundingMode.HALF_UP);
   }

   public void setGastos_compras(BigDecimal gastos_compras) {
      this.gastos_compras = gastos_compras.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getReb_deb_compras() {
      return reb_deb_compras.setScale(2, RoundingMode.HALF_UP);
   }

   public void setReb_deb_compras(BigDecimal reb_deb_compras) {
      this.reb_deb_compras = reb_deb_compras.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getInventarioI() {
      return inventarioI.setScale(2, RoundingMode.HALF_UP);
   }

   public void setInventarioI(BigDecimal inventarioI) {
      this.inventarioI = inventarioI.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getGast_admon() {
      return gast_admon.setScale(2, RoundingMode.HALF_UP);
   }

   public void setGast_admon(BigDecimal gast_admon) {
      this.gast_admon = gast_admon.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getGast_vent() {
      return gast_vent.setScale(2, RoundingMode.HALF_UP);
   }

   public void setGast_vent(BigDecimal gast_vent) {
      this.gast_vent = gast_vent.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getGast_fin() {
      return gast_fin.setScale(2, RoundingMode.HALF_UP);
   }

   public void setGast_fin(BigDecimal gast_fin) {
      this.gast_fin = gast_fin.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getOtros_gast() {
      return otros_gast.setScale(2, RoundingMode.HALF_UP);
   }

   public void setOtros_gast(BigDecimal otros_gast) {
      this.otros_gast = otros_gast.setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal getOtros_ingre() {
      return otros_ingre.setScale(2, RoundingMode.HALF_UP);
   }

   public void setOtros_ingre(BigDecimal otros_ingre) {
      this.otros_ingre = otros_ingre.setScale(2, RoundingMode.HALF_UP);
   }

   public Controlador getCtr() {
      return ctr;
   }

   public void setCtr(Controlador ctr) {
      this.ctr = ctr;
   }

   public SimpleDateFormat getSdf() {
      return sdf;
   }

   public void setSdf(SimpleDateFormat sdf) {
      this.sdf = sdf;
   }
   
   

}
