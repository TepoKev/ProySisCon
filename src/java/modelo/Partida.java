package modelo;
// Generated 12-26-2017 08:35:28 PM by Hibernate Tools 4.3.1

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Partidas generated by hbm2java
 */
public class Partida implements java.io.Serializable {

    private int id;
    private Date fecha;
    private String descripcion;
    private Integer contador;//Numero de Partida
    private Set cargosAbonos = new HashSet(0);

    public Partida() {
    }

    public Partida(int id) {
        this.id = id;
    }
    
    public Partida(Date fecha, String descripcion, Integer contador) {
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.contador = contador;
    }
    
    public Partida(Date fecha, String descripcion, Integer contador, Set cargosAbonos) {
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.contador = contador;
        this.cargosAbonos = cargosAbonos;
    }

    public Partida(int id, Date fecha, String descripcion, Integer contador, Set cargosAbonos) {
        this.id = id;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.contador = contador;
        this.cargosAbonos = cargosAbonos;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
	public void setFecha(String fecha) {
	   //cadenas vacias o nulas indicaran la fecha actual
	   //a la hora de insertar o modificar
	   if(fecha != null) {
		  
		  if(fecha.equals("")) {
			 //fecha actual
			 this.fecha = Calendar.getInstance().getTime();
		  } else {

			 SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			 try {
				this.fecha = sdf.parse(fecha);
			 }catch(Exception e) {
				
			 }
		  }
	   }
	}
    public String getDescripcion() {
        return this.descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getContador() {
        return this.contador;
    }

    public void setContador(Integer contador) {
        this.contador = contador;
    }

    public Set getCargosAbonos() {
        return this.cargosAbonos;
    }

    public void setCargosAbonos(Set cargosAbonos) {
        this.cargosAbonos = cargosAbonos;
    }

}
