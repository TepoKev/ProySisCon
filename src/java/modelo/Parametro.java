package modelo;
// Generated 01-03-2019 05:54:03 PM by Hibernate Tools 4.3.1



/**
 * Parametro generated by hbm2java
 */
public class Parametro  implements java.io.Serializable {


     private int id;
     private Periodo periodo;
     private String nombre;
     private String valor;

    public Parametro() {
    }
    
    public Parametro(String nombre) {
       this.nombre = nombre;
    }
	
    public Parametro(int id) {
        this.id = id;
    }
    public Parametro(int id, Periodo periodo, String nombre, String valor) {
       this.id = id;
       this.periodo = periodo;
       this.nombre = nombre;
       this.valor = valor;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public Periodo getPeriodo() {
        return this.periodo;
    }
    
    public void setPeriodo(Periodo periodo) {
        this.periodo = periodo;
    }
    public String getNombre() {
        return this.nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getValor() {
        return this.valor;
    }
    
    public void setValor(String valor) {
        this.valor = valor;
    }

}


