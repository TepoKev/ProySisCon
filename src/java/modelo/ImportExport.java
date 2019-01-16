/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/**
 *
 * @author Student
 */
public class ImportExport {
 

    private Process proceso;
    private ProcessBuilder constructor;

    public static String host = "localhost";
    public static String puerto="5432";
    public static String usuario = "postgres";
    public static String clave = "root";
    public static String bd="proy-siscon-db";
    public static String formato="custom";
    
    public void iniciar() {
        ImportExport ie =  new ImportExport();
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String salida =  sdf.format(date) + ".backup";
        System.out.println("nombre: "+salida);
        ie.exportar(salida);
    } 
    public boolean exportar(String destino){
        boolean hecho=false;
        String pgdumpPath = "C:\\Program Files\\PostgreSQL\\10\\bin\\pg_dump.exe";
        try{
            File pgdump= new File(pgdumpPath);
            if(pgdump.exists()){
                if(!destino.equalsIgnoreCase("")) {
                    constructor = new ProcessBuilder(pgdumpPath, "--verbose", "--format", formato, "-f", destino);
                } else {                             
                    constructor = new ProcessBuilder(pgdumpPath, "--verbose", "--inserts", "--column-inserts", "-f", destino);
                    System.out.println("ERROR");
                }
                constructor.environment().put("PGHOST", host);
                constructor.environment().put("PGPORT", puerto);
                constructor.environment().put("PGUSER", usuario);
                constructor.environment().put("PGPASSWORD", clave);
                constructor.environment().put("PGDATABASE", bd);
                constructor.redirectErrorStream(true);
                proceso= constructor.start();
                escribirProcess(proceso);
                System.out.println("terminado backup " + destino);
                hecho=true;
            }
        }catch(Exception ex){
            System.err.println(ex.getMessage()+ "Error de backup");
            hecho=false;
        }
        return hecho;
    }


    public boolean importar(String path) {
        boolean hecho=false;
        String pgrestorePath ="C:\\Program Files\\PostgreSQL\\10\\bin\\pg_restore.exe";
        try {
            File pgrestore = new File(pgrestorePath);
            if(pgrestore.exists()){
                constructor = new ProcessBuilder(pgrestorePath, "-i", "-h", host, "-p", puerto, "-U", usuario, "-d", bd, "-v", path);
                constructor.environment().put("PGPASSWORD", clave);
                constructor.redirectErrorStream(true);
                proceso=constructor.start();
                escribirProcess(proceso);
                hecho=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            hecho=false;
        }
        return hecho;
    }

    private void escribirProcess(Process proceso) {
        
    }   
}
