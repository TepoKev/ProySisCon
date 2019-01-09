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
      this.sdf = new SimpleDateFormat("yyyy-MM-dd");
      this.ctr = new Controlador();
   }

   public EstResult(String fechaI, String fechaF, String inventarioF) throws ParseException {
      this.sdf = new SimpleDateFormat("yyyy-MM-dd");
      this.ctr = new Controlador();
      this.fechaI = sdf.parse(fechaI);
      this.fechaF = sdf.parse(fechaF);
      Mayor venta, rdvents, compra, gscompras, rdcompras, inventario, gda, gdv, gf, og, oi;
      this.inventarioF = new BigDecimal(inventarioF).setScale(2, RoundingMode.HALF_UP);
      venta = ctr.mayorizarCuenta("5101", fechaI, fechaF);
      venta.generarSaldos();
      this.ventas = new BigDecimal(venta.getSaldoA()).setScale(2, RoundingMode.HALF_UP);
      rdvents = ctr.mayorizarCuenta("4101", fechaI, fechaF);
      rdvents.generarSaldos();
      this.reb_deb_ventas = new BigDecimal(rdvents.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      compra = ctr.mayorizarCuenta("4102", fechaI, fechaF);
      compra.generarSaldos();
      this.compras = new BigDecimal(compra.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      gscompras = ctr.mayorizarCuenta("4203", fechaI, fechaF);
      gscompras.generarSaldos();
      this.gastos_compras = new BigDecimal(gscompras.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      //Rebajas y Devoluciones sobre Compras
      rdcompras = ctr.mayorizarCuenta("5105", fechaI, fechaF);
      rdcompras.generarSaldos();
      this.reb_deb_compras = new BigDecimal(rdcompras.getSaldoA()).setScale(2, RoundingMode.HALF_UP);
      //Inventario Inicial
      inventario = ctr.mayorizarCuenta("1109", fechaI, fechaF);
      inventario.generarSaldos();
      this.inventarioI = new BigDecimal(inventario.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      //Gastos de Administracion
      gda = ctr.mayorizarCuenta("4201", fechaI, fechaF);
      gda.generarSaldos();
      this.gast_admon = new BigDecimal(gda.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      //Gastos de Ventas
      gdv = ctr.mayorizarCuenta("4202", fechaI, fechaF);
      gdv.generarSaldos();
      this.gast_vent = new BigDecimal(gdv.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      //Gastos Finacieros
      gf = ctr.mayorizarCuenta("4204", fechaI, fechaF);
      gf.generarSaldos();
      this.gast_fin = new BigDecimal(gf.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      //Otros Gastos
      og = ctr.mayorizarCuenta("4205", fechaI, fechaF);
      og.generarSaldos();
      this.otros_gast = new BigDecimal(og.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      //Otros Ingresos
      oi = ctr.mayorizarCuenta("5106", fechaI, fechaF);
      oi.generarSaldos();
      this.otros_ingre = new BigDecimal(oi.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
   }

   public EstResult(String fechaI, String fechaF, String inventarioF, String ventas, String reb_deb_ventas, String compras, String gastos_compras, String reb_deb_compras, String inventarioI, String gast_admon, String gast_vent, String gast_fin, String otros_gast, String otros_ingre) throws ParseException {
      this.sdf = new SimpleDateFormat("yyyy-MM-dd");
      this.fechaI = sdf.parse(fechaI);
      this.fechaF = sdf.parse(fechaF);
      this.inventarioF = new BigDecimal(inventarioF).setScale(2, RoundingMode.HALF_UP);

      this.ventas = new BigDecimal(ventas).setScale(2, RoundingMode.HALF_UP);
      this.reb_deb_ventas = new BigDecimal(reb_deb_ventas).setScale(2, RoundingMode.HALF_UP);
      this.compras = new BigDecimal(compras).setScale(2, RoundingMode.HALF_UP);
      this.gastos_compras = new BigDecimal(gastos_compras).setScale(2, RoundingMode.HALF_UP);
      this.reb_deb_compras = new BigDecimal(reb_deb_compras).setScale(2, RoundingMode.HALF_UP);
      this.inventarioI = new BigDecimal(inventarioI).setScale(2, RoundingMode.HALF_UP);
      this.gast_admon = new BigDecimal(gast_admon).setScale(2, RoundingMode.HALF_UP);
      this.gast_vent = new BigDecimal(gast_vent).setScale(2, RoundingMode.HALF_UP);
      this.gast_fin = new BigDecimal(gast_fin).setScale(2, RoundingMode.HALF_UP);
      this.otros_gast = new BigDecimal(otros_gast).setScale(2, RoundingMode.HALF_UP);
      this.otros_ingre = new BigDecimal(otros_ingre).setScale(2, RoundingMode.HALF_UP);
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

   public BigDecimal VentasNetas() {
      return this.ventas.subtract(this.reb_deb_ventas).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal ComprasTotales() {
      return this.compras.add(this.gastos_compras).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal ComprasNetas() {
      return ComprasTotales().subtract(this.reb_deb_compras).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal MercaderiaDisponible() {
      return ComprasNetas().add(this.inventarioI).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal CostoVenta() {
      return MercaderiaDisponible().subtract(this.inventarioF).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal UtilidadBruta() {
      return VentasNetas().subtract(CostoVenta()).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal UtilidadAIR() {
      return UtilidadBruta().subtract(this.gast_admon.add(this.gast_vent).add(this.gast_fin)).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal ReservaLegal() {
      return this.UtilidadAIR().multiply(new BigDecimal("0.07")).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal UtilidadAI() {
      return UtilidadAIR().subtract(ReservaLegal()).setScale(2, RoundingMode.HALF_UP);
   }

   public BigDecimal ImpuestoRenta() {
      if (this.ventas.doubleValue() <= 150000) {
         return UtilidadAI().multiply(new BigDecimal("0.25")).setScale(2, RoundingMode.HALF_UP);
      } else {
         return UtilidadAI().multiply(new BigDecimal("0.30")).setScale(2, RoundingMode.HALF_UP);
      }
   }

   public BigDecimal UtilidadEjercicio() {
      return UtilidadAI().subtract(ImpuestoRenta()).setScale(2, RoundingMode.HALF_UP);
   }
}
