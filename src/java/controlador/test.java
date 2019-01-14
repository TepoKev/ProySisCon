/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;


import java.text.ParseException;
import java.time.LocalDate;
import java.util.Date;
import java.util.Set;
import modelo.CargoAbono;
import modelo.Partida;
import modelo.Periodo;
import modelo.partidasCierre;


/**
 *
 * @author kedut
 */
public class test {
    
    public static void main(String [] args) throws ParseException{
        
//        int result=(8-4)/2+1;
//        System.out.println(result);
//        result =  (int) (Math.round(3.5)+1);
//        System.out.println(result);
//        result = (7/2)+2;
//         Partida p = new Partida();
//         p.setFecha("");
//         System.out.println("");
         
//         Periodo p = new Periodo("01-01-2017","31-12-2017",false,true);
//         Controlador ctr = new Controlador();
//         ctr.guardar(p);
         LocalDate.now().getYear();
         partidasCierre par = new partidasCierre();
         par.generarPartidasCierre();
         for(Partida p : par.partidas){
	System.out.println("\n Descripcion: "+p.getDescripcion()+"\n");
	for(CargoAbono ca : (Set<CargoAbono>)p.getCargosAbonos()){
	   System.out.print("Cuenta :"+ca.getCuenta().getNombre()+" Monto :"+ ca.getMonto());
	   if("c".equals(ca.getOperacion())){
	      System.out.println(" Cargo");
	   }else{
	      if("a".equals(ca.getOperacion())){
	         System.out.println(" Abono");
	      }
	   }
	}
         }
         System.exit(0);
    }
//    public static void main(String[] args) {
//        //Cuenta c = new Cuenta();
//        ArrayList<Cuenta> cts = new ArrayList();
//        try {
//            Controlador ctr = new Controlador();
////            c = ctr.recuperarCuenta("11");
////			cts = (ArrayList<Cuenta>) ctr.recuperarCuentaPrimerN();
//            ctr.resetContador();
//        } catch (HibernateException e) {
//            System.out.println(e.getMessage());
//        }
//        System.exit(0);
//    }

//    public static void main(String[] args) throws ParseException {
//        String fecha = "2018/07/28";
//        String fecha1 = "2018-07-28";
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
//        java.util.Date fech1 = sdf.parse(fecha);
//        java.sql.Date fesql = new Date(fech1.getTime());
//        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//        java.util.Date fech = sdf1.parse(fecha1);
//        java.sql.Date fesq = new Date(fech.getTime());
//        System.out.println("Con Diagonal /n");
//        System.out.println("Fecha java.util.Date "+ fech1.toString());
//        System.out.println("Fecha java.sql.Date "+ fesql.toString());
//        
//        System.out.println("Con Guion /n");
//        System.out.println("Fecha java.util.Date "+ fech.toString());
//        System.out.println("Fecha java.sql.Date "+ fesq.toString());
//    }
//    public static void main(String[] args) {
//        Float num = new Float("1.9953563");
//        BigDecimal numero = new BigDecimal(num);
//        numero = numero.setScale(2, RoundingMode.HALF_UP);
//        System.out.println(numero);
//        System.out.println(numero.doubleValue());
//    }
}
