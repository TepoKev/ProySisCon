
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Student
 */
public class Rangos {

    public static void main(String []ar ) {
        try {
            Rangos rangos = new Rangos("7");
            rangos = new Rangos("25(0,150000)30(150000,300000000)");
        } catch (Exception ex) {
            Logger.getLogger(Rangos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private ArrayList<RangoPorcentaje> lista;

    public Rangos(String str) throws Exception {
        lista = new ArrayList<>();
        RangoPorcentaje rp;

        int indice, i, length = str.length();
        char c;
        String numero="";
        float limiteInferior, limiteSuperior, porcentaje;
        try {
         for (i = 0; i < length; i++) {
            /*
                un ( indica que un rango va a empezar
            */
            indice = str.indexOf("(", i);
            if(indice==-1) {
                numero = str.substring(i);
                porcentaje = Float.parseFloat(numero);
                rp = new RangoPorcentaje(0, Float.MAX_VALUE, porcentaje);
                lista.add(rp);
                return;
            } else {
                //encontrar el porcentaje
                
                numero = str.substring(i, indice);
                porcentaje = Float.parseFloat(numero);
                //poner el indice actual i, adelante del "("
                i = indice + 1;
                //buscar los limites del rango
                //limite inferior
                indice = str.indexOf(",", indice);
                numero = str.substring(i,indice);
                limiteInferior = Float.parseFloat(numero);
                //poner el indice actual i, adelante de la ","
                i = indice + 1;
                //limite superior
                indice = str.indexOf(")",indice);
                numero = str.substring(i,indice);
                limiteSuperior = Float.parseFloat(numero);
                //poner el indice actual i, JUSTO EN EL ")", para que el incremento del for lo adelante al caracter correcto
                i = indice;
                rp = new RangoPorcentaje(limiteInferior, limiteSuperior, porcentaje);
                lista.add(rp);
            }
        }   
        }catch(Exception e) {
           throw e;
        }
        
    }

    public void add(RangoPorcentaje rangoPorcentaje) throws Exception {

    }
}
