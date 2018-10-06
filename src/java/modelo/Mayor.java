/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.ArrayList;

/**
 *
 * @author tepokev
 */
public class Mayor {
    private Cuenta cuenta;
    private float cargo, abono, saldoD,saldoA;
    private ArrayList<CargoAbono> transacciones;

    public Mayor() {
        this.cargo = 0;
        this.abono = 0;
        this.saldoD = 0;
        this.saldoA = 0;
        this.transacciones = new ArrayList<>();
    }

    public Mayor(Cuenta cuenta, ArrayList<CargoAbono> transacciones,float cargo, float abono, float saldoD, float saldoA) {
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

    public void setSaldoD(float saldoD) {
        this.saldoD = saldoD;
    }

    public float getSaldoA() {
        return saldoA;
    }

    public void setSaldoA(float saldoA) {
        this.saldoA = saldoA;
    }
    
    
    
    public void add(CargoAbono c){
        this.transacciones.add(c);
    }
    /*
	Este metodo realiza la suma de cargos y abonos de la cuenta, 
	para ello, se basa en la lista de transacciones
	finalmente determina el saldo de la cuenta,
	y lo asigna a saldoD o a saldoA si el saldo es deudor o acreedor respectivamente. 
	
	*/
    public void generarSaldos(){
	  //variables para los totales de cargo y abono
        float cargo = 0, abono = 0;
		//recorrer cada transaccion
        for(CargoAbono ca : this.transacciones){
		  //es cargo
            if("c".equalsIgnoreCase(ca.getOperacion())){
                cargo += ca.getMonto();
            }//o es abono
			else if("a".equalsIgnoreCase(ca.getOperacion())){
                abono += ca.getMonto();
            }
        }
		//asignar cargo y abono a las variables globales
        this.cargo = cargo;
        this.abono = abono;
		//determinacion del saldo resultante de la cuenta
        if(cargo > abono){
            this.saldoD = cargo - abono;
        }else{
            this.saldoA = abono - cargo;
        }
        
    }
    
}
