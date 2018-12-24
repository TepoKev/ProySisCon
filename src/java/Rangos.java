
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

    public static void main(String[] ar) {
        try {
            Rangos rangos = new Rangos("25(0,150000)30(150000,300000000)",'I');
        } catch (Exception ex) {
            Logger.getLogger(Rangos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private ArrayList<RangoPorcentaje> lista;

    public Rangos(String str, char extremoDeAplicacion) throws Exception {
        lista = new ArrayList<>();
        RangoPorcentaje rp;

        int indice, i, length = str.length();
        char c;
        String numero = "";
        float limiteInferior, limiteSuperior, porcentaje;
        try {
            for (i = 0; i < length; i++) {
                /*
                un ( indica que un rango va a empezar
                 */
                indice = str.indexOf("(", i);
                if (indice == -1) {
                    numero = str.substring(i);
                    porcentaje = Float.parseFloat(numero);
                    rp = new RangoPorcentaje(0, Float.MAX_VALUE, porcentaje, extremoDeAplicacion);
                    add(rp);
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
                    numero = str.substring(i, indice);
                    limiteInferior = Float.parseFloat(numero);
                    //poner el indice actual i, adelante de la ","
                    i = indice + 1;
                    //limite superior
                    indice = str.indexOf(")", indice);
                    numero = str.substring(i, indice);
                    limiteSuperior = Float.parseFloat(numero);
                    //poner el indice actual i, JUSTO EN EL ")", para que el incremento del for lo adelante al caracter correcto
                    i = indice;
                    rp = new RangoPorcentaje(limiteInferior, limiteSuperior, porcentaje, extremoDeAplicacion);
                    add(rp);
                }
            }
        } catch (Exception e) {
            throw e;
        }

    }

    private void add(RangoPorcentaje rangoPorcentaje) throws Exception {
        if (lista.isEmpty()) {
            lista.add(rangoPorcentaje);
        } else {
            //determinar si el elemento va al principio o al final

            int i, len = lista.size();
            RangoPorcentaje rpActual, rpSiguiente, primero, ultimo;
            primero = lista.get(0);
            ultimo = lista.get(len - 1);
            //va a la izquierda del primero o lo que es lo mismo: va al principio de la lista
            if (primero.compareTo(rangoPorcentaje) == -1) {
                lista.add(0, rangoPorcentaje);
                return;
            } else if (ultimo.compareTo(rangoPorcentaje) == 1) {
                lista.add(rangoPorcentaje);
                return;
            }
            //buscar donde debe ir insertado el rango
            //el rango no puede ir al principio porque ya se determino en el if anterior
            //el rango no puede ir al final porque ya se determino en el if anterior
            for (i = 0; i < len - 1; i++) {
                //determinar si va entre el actual y el siguiente
                rpActual = lista.get(i);
                rpSiguiente = lista.get(i + 1);
                if (rangoPorcentaje.estaEnMedioDe(rpActual, rpSiguiente) == true) {
                    //insertar en medio
                    //i+1 es pasado a add() para indicar que sera insertado despues del actual. 
                    lista.add(i + 1, rangoPorcentaje);
                    return;
                }

            }
        }
    }
}
