/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import controlador.Controlador;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author tepokev
 */
public class Mayor {

   private Cuenta cuenta;
   private float cargo, abono, saldoD, saldoA;
   private ArrayList<CargoAbono> transacciones;
   private Controlador ctr = new Controlador();

   public Mayor() {
      this.cargo = 0;
      this.abono = 0;
      this.saldoD = 0;
      this.saldoA = 0;
      this.transacciones = new ArrayList<>();
   }

   public Mayor(Cuenta cuenta, ArrayList<CargoAbono> transacciones, float cargo, float abono, float saldoD, float saldoA) {
      this.cuenta = cuenta;
      this.transacciones = transacciones;
      this.cargo = cargo;
      this.abono = abono;
      this.saldoD = saldoD;
      this.saldoA = saldoA;
   }

   public Cuenta getCuenta() {
      return cuenta;
   }

   public void setCuenta(Cuenta cuenta) {
      this.cuenta = cuenta;
   }

   public ArrayList<CargoAbono> getTransacciones() {
      Collections.sort(this.transacciones, (CargoAbono o1, CargoAbono o2) -> new Integer(o1.getId()).compareTo(new Integer(o2.getId())));
      return transacciones;
   }

   public void setTransacciones(ArrayList<CargoAbono> transacciones) {
      this.transacciones = transacciones;
   }

   public float getCargo() {
      return cargo;
   }

   public void setCargo(float cargo) {
      this.cargo = cargo;
   }

   public float getAbono() {
      return abono;
   }

   public void setAbono(float abono) {
      this.abono = abono;
   }

   public float getSaldoD() {
      return saldoD;
   }

   public void getSaldoD(BigDecimal saldoD) {
      saldoD = new BigDecimal(this.saldoD).setScale(2, RoundingMode.HALF_UP);
   }

   public void setSaldoD(float saldoD) {
      this.saldoD = saldoD;
   }

   public float getSaldoA() {
      return saldoA;
   }

   public void getSaldoA(BigDecimal saldoA) {
      saldoA = new BigDecimal(this.saldoA).setScale(2, RoundingMode.HALF_UP);
   }

   public void setSaldoA(float saldoA) {
      this.saldoA = saldoA;
   }

   public void add(CargoAbono c) {
      this.transacciones.add(c);
   }

   /*
	Este metodo realiza la suma de cargos y abonos de la cuenta, 
	para ello, se basa en la lista de transacciones
	finalmente determina el saldo de la cuenta,
	y lo asigna a saldoD o a saldoA si el saldo es deudor o acreedor respectivamente. 
	
    */
   public void generarSaldos() {
      //variables para los totales de cargo y abono
      BigDecimal c = new BigDecimal(this.cargo);
      BigDecimal a = new BigDecimal(this.abono);
      Periodo actual = ctr.periodoNow();
      //recorrer cada transaccion
      this.transacciones = ctr.ordenarCA(this.transacciones);
      try {
         if (actual.getFinalizado() == true) {
	int maxval = ctr.obtenerMaxValue();
	int lent = this.transacciones.size();
	ArrayList<CargoAbono> aux = new ArrayList<>();
	int linInf = maxval - 11;
	int linSup = maxval;
	int idpart;
	for (int i = 0; i < lent; i++) {
	   idpart = this.transacciones.get(i).getPartida().getId();
	   if (!(idpart >= linInf && idpart <= linSup)) {
	      aux.add(this.transacciones.get(i));
	   }
	}
	this.transacciones = aux;

         }
         for (CargoAbono ca : this.transacciones) {
	//es cargo
	if ("c".equalsIgnoreCase(ca.getOperacion())) {
	   if (actual != null) {
	      if (ca.getPartida().getPeriodo().getId() == actual.getId()) {
	         c = c.add(new BigDecimal(ca.getMonto()).setScale(2, RoundingMode.HALF_UP));
	      }
	   }

	}//o es abono
	else if ("a".equalsIgnoreCase(ca.getOperacion())) {
	   if (actual != null) {
	      if (ca.getPartida().getPeriodo().getId() == actual.getId()) {
	         a = a.add(new BigDecimal(ca.getMonto()).setScale(2, RoundingMode.HALF_UP));
	      }
	   }

	}
         }
      } catch (Exception e) {
      }
      //asignar cargo y abono a las variables globales
      this.cargo = c.floatValue();
      this.abono = a.floatValue();
      //determinacion del saldo resultante de la cuenta
      if (c.floatValue() > a.floatValue()) {
         this.saldoD = c.subtract(a).floatValue();
      } else {
         this.saldoA = a.subtract(c).floatValue();
      }

   }

}
