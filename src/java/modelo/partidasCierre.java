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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 *
 * @author student
 */
public class partidasCierre {

   public ArrayList<Partida> partidas; 
   private Controlador ctr;
   private SimpleDateFormat sdf;

   public partidasCierre() {
      this.partidas = new ArrayList<>();
      this.ctr = new Controlador();
      this.sdf = new SimpleDateFormat("yyyy-MM-dd");
   }

   public void generarPartidasCierre() throws ParseException {
      
      //exportar la base de datos
      ImportExport ie =  new ImportExport();
      
      ie.iniciar();
      //Liquidacion de IVA      
      ArrayList<CargoAbono> ca = new ArrayList<>();
      Mayor m, m1;
      m = ctr.mayorizarCuenta("2109");
      m.generarSaldos();
      m1 = ctr.mayorizarCuenta("1112");
      m1.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("2109"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("1112"), new BigDecimal(m1.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      if (m.getSaldoA() > m1.getSaldoD()) {
         ca.add(new CargoAbono(ctr.recuperarCuenta("2106"), new BigDecimal((m.getSaldoA() - m1.getSaldoD())).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      }
      crearPartida("Liquidacion de IVA", ca);

      //Liquidacion de rebajas y devoluciones sobre ventas
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("4101");
      m.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("5101"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4101"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Liquidacion de rebajas y devoluciones sobre ventas", ca);

      //Liquidacion de gastos sobre compras
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("4203");
      m.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("4102"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4203"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Liquidacion de gastos sobre compras", ca);

      //Liquidacion de rebajas y devoluciones sobre compras
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("5105");
      m.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("5105"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4102"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Liquidacion de rebajas y devoluciones sobre compras", ca);

      //Liquidacion de inventario
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("1109");
      m.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("4102"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("1109"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Liquidacion de inventario", ca);

      Periodo actual = ctr.periodoNow();
      EstResult result = new EstResult(actual.getFechaInicial().toString(), actual.getFechaFinal().toString(), ctr.recuperarParamPer("INVENTARIO_FINAL",ctr.periodoNow().getId()).getValor());

      //Determinacion del costo de venta
      ca = new ArrayList<>();
      ca.add(new CargoAbono(ctr.recuperarCuenta("1109"), result.getInventarioF().floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4102"), result.getInventarioF().floatValue(), "a"));
      crearPartida("Determinacion del costo de venta", ca);

      //Liquidacion de la cuenta compras
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("4102");
      m.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("5101"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4102"), new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Liquidacion de la cuenta compras", ca);

      //Traspaso de impuesto y reserva como provision
      ca = new ArrayList<>();

      m = ctr.mayorizarCuenta("5101");
      m.generarSaldos();
      m1 = ctr.mayorizarCuenta("2104");
      m1.generarSaldos();
      Mayor m2 = ctr.mayorizarCuenta("2112");
      m2.generarSaldos();
      Mayor m3 = ctr.mayorizarCuenta("2106");
      m3.generarSaldos();
      BigDecimal ventas = new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP);
      ca.add(new CargoAbono(ctr.recuperarCuenta("5101"), ventas.floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("2112"), result.ImpuestoRenta().floatValue(), "a"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("3104"), result.ReservaLegal().floatValue(), "a"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("6101"), (ventas.subtract(result.ImpuestoRenta().add(result.ReservaLegal())).setScale(2, RoundingMode.HALF_UP).floatValue()), "a"));
      crearPartida("Traspaso de impuesto y reserva como provision", ca);
      //Liquidacion de otros ingresos
      m = ctr.mayorizarCuenta("5106");
      m.generarSaldos();
      if (m.getSaldoA() != 0) {
         ca = new ArrayList<>();
         ca.add(new CargoAbono(ctr.recuperarCuenta("5106"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
         ca.add(new CargoAbono(ctr.recuperarCuenta("6101"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
         crearPartida("Liquidacion de otros ingresos", ca);
      }

      //Liquidacion de otros gastos
      m = ctr.mayorizarCuenta("4205");
      m.generarSaldos();
      if (m.getSaldoD() != 0) {
         ca = new ArrayList<>();
         ca.add(new CargoAbono(ctr.recuperarCuenta("5106"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
         ca.add(new CargoAbono(ctr.recuperarCuenta("4205"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
         crearPartida("Liquidacion de otros gastos", ca);
      }

      //Liquidacion de gastos operativos
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("4201");
      m.generarSaldos();
      m1 = ctr.mayorizarCuenta("4202");
      m1.generarSaldos();
      m2 = ctr.mayorizarCuenta("4204");
      m2.generarSaldos();
      BigDecimal mGA = new BigDecimal(m.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      BigDecimal mGV = new BigDecimal(m1.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      BigDecimal mGF = new BigDecimal(m2.getSaldoD()).setScale(2, RoundingMode.HALF_UP);
      ca.add(new CargoAbono(ctr.recuperarCuenta("6101"), mGA.add(mGV.add(mGF)).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4201"), mGA.setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4202"), mGV.setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("4204"), mGF.setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Liquidacion de gastos operativos", ca);

      //Para determinar o trasladar la utilidad acuenta de capital
      ca = new ArrayList<>();
      m = ctr.mayorizarCuenta("6101");
      m.generarSaldos();
      ca.add(new CargoAbono(ctr.recuperarCuenta("6101"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "c"));
      ca.add(new CargoAbono(ctr.recuperarCuenta("3106"), new BigDecimal(m.getSaldoA()).setScale(2, RoundingMode.HALF_UP).floatValue(), "a"));
      crearPartida("Para determinar o trasladar la utilidad acuenta de capital", ca);

      //Cierre del ejercicio
      
      generarCI();
      
      Periodo p = ctr.periodoNow();
      p.setEncurso(false);
      p.setFinalizado(true);
      ctr.actualizar(p);
   }

   private Partida crearPartida(String descripcion, ArrayList<CargoAbono> ca){
      ca = ctr.ordenarCA(ca);
      Partida p = new Partida();
      p.setPeriodo(ctr.periodoNow());
      p.setFecha("");      
      p.setDescripcion(descripcion);
      ca.stream().map((cA) -> {
         cA.setPartida(p);
         return cA;
      }).forEachOrdered(p.getCargosAbonos()::add);
      ctr.registrarPartida(p);
      this.partidas.add(p);
      return p;
   }
   
   private void generarCI(){
      ArrayList<Mayor> may = ctr.mayorizarCuentas(4, "11");
      ArrayList<CargoAbono> caF = new ArrayList<>();
      ArrayList<CargoAbono> caI = new ArrayList<>();
      may.addAll(ctr.mayorizarCuentas(4, "12"));
      may.addAll(ctr.mayorizarCuentas(4, "21"));
      may.addAll(ctr.mayorizarCuentas(4, "22"));
      may.addAll(ctr.mayorizarCuentas(4, "31"));
      
      for (Mayor mayor : may) {
         mayor.generarSaldos();
         if ("-".equals(mayor.getCuenta().getTipo()) && mayor.getSaldoA() != 0) {
	caF.add(new CargoAbono(mayor.getCuenta(), mayor.getSaldoA(), "c"));
	caI.add(new CargoAbono(mayor.getCuenta(), mayor.getSaldoA(), "a"));
         } else {
	if ("+".equals(mayor.getCuenta().getTipo()) && mayor.getSaldoD() != 0) {
	   caF.add(new CargoAbono(mayor.getCuenta(), mayor.getSaldoD(), "a"));
	   caI.add(new CargoAbono(mayor.getCuenta(), mayor.getSaldoD(), "c"));
	}
         }
      }
      
      crearPartida("Cierre del ejercicio", caF);
      ctr.resetContador();
      caI = ctr.ordenarCA(caI);
      Partida p = new Partida();
      p.setPeriodo(null);
      p.setFecha("");
      p.setDescripcion("Balance Inicial");
      caI.stream().map((cA) -> {
         cA.setPartida(p);
         return cA;
      }).forEachOrdered(p.getCargosAbonos()::add);
      ctr.registrarPartida(p);
   }

}
