/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Student
 */
import java.util.ArrayList;
public class Configuracion {
    private ArrayList<Parametro> parametros;
    
    public Configuracion() {
        parametros = new ArrayList<>();
    }
    public Parametro contains() {
        Parametro par;
        for (Parametro parametro : parametros) {
            
        }
        return null;
    
    }
    public boolean add(Parametro par) {
        
        for (Parametro parametro : parametros) {
            if(parametro.getNombre().equalsIgnoreCase(par.getNombre())) {
                return false;
            }
        }
        parametros.add(par);
        return true;
    }
}
