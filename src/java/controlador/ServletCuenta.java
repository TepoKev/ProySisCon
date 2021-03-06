/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;

/**
 *
 * @author kedut
 */
public class ServletCuenta extends HttpServlet {

    private int act, nue;//Estas 2 variables almacenaran la cantidad de datos guardados y actualizados (Podrian eliminarse)   

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        /**
         * *******************************************************************
         * Ojo: request.setCharacterEncoding("UTF-8") ha permitido solucionar
         * problemas con caracteres especiales como las tildes fuente:
         * https://donnierock.com/2015/06/09/javajsp-al-enviar-formulario-por-metodo-post-los-caracteres-utf-8-no-aparecen-bien-representados/
         * *******************************************************************
         */
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Controlador ctr = new Controlador();
            String[] nombre_cuenta = request.getParameterValues("nombre-cuenta");
            String[] codigo_cuenta = request.getParameterValues("codigo-cuenta");
            String[] descripcion_cuenta = request.getParameterValues("descripcion-cuenta");
            String[] saldo = request.getParameterValues("saldo");
            String[] id_cuenta = request.getParameterValues("id-cuenta");
            if (validar(nombre_cuenta, codigo_cuenta, descripcion_cuenta, saldo, id_cuenta)) {

                guardar(nombre_cuenta, codigo_cuenta, descripcion_cuenta, saldo, id_cuenta, ctr);
            } else {
                out.print(""
                        + "<script type=\"text/javascript\">"
                        +   "window.alert(\"Ha ocurrido un error: Durante el registro se encontraron errores por lo que no se guardaran los datos :( \")"
                        + "</script>"
                        + "");
            }

            response.sendRedirect("registrar-catalogo.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void guardar(String[] nombre_cuenta, String[] codigo_cuenta, String[] descripcion_cuenta, String[] saldo, String[] id_cuenta, Controlador ctr) {
        Cuenta cue,padre;
        for (int i = 0; i < nombre_cuenta.length; i++) {
            cue = new Cuenta();
            
            if (id_cuenta[i].isEmpty()) {

                //cuentas principales como activo, pasivo, patrimonio, etc. 
                //Estas cuentas no tienen cuenta padre
                if (codigo_cuenta[i].length() == 1) {
                    cue.setCuenta(null);
                } else {
                    
                    if (codigo_cuenta[i].length() == 2) {
                        padre = ctr.recuperarCuenta(codigo_cuenta[i].substring(0, 1));
                        cue.setCuenta(padre);
                    } else {
                        if (codigo_cuenta[i].length() > 2) {
                            padre = ctr.recuperarCuenta(codigo_cuenta[i].substring(0, (codigo_cuenta[i].length() - 2)));
                            cue.setCuenta(padre);
                        }
                    }
                }
                cue.setNombre(nombre_cuenta[i]);
                cue.setCodigo(codigo_cuenta[i]);
                cue.setTipo(saldo[i]);
                cue.setDescripcion(descripcion_cuenta[i]);
                ctr.guardar(cue);
                nue++;
            } else {
                if (codigo_cuenta[i].length() == 1) {
                    cue.setCuenta(null);
                } else {
                    if (codigo_cuenta[i].length() == 2) {
                        padre = ctr.recuperarCuenta(codigo_cuenta[i].substring(0, 1));
                        cue.setCuenta(padre);
                    } else {
                        if (codigo_cuenta[i].length() > 2) {
                            padre = ctr.recuperarCuenta(codigo_cuenta[i].substring(0, (codigo_cuenta[i].length() - 2)));
                            cue.setCuenta(padre);
                        }
                    }
                }
                cue.setId(Integer.parseInt(id_cuenta[i]));
                cue = ctr.recuperarCuenta(cue);
                cue.setNombre(nombre_cuenta[i]);
                cue.setCodigo(codigo_cuenta[i]);
                cue.setTipo(saldo[i]);
                cue.setDescripcion(descripcion_cuenta[i]);
                ctr.actualizar(cue);
                act++;
            }
        }
    }

    //Esta funcion valida los datos de el formulario de registro de catalogo y devuelve verdadero si no se encuentra ninguna anomalia
    private boolean validar(String[] nombre_cuenta, String[] codigo_cuenta, String[] descripcion_cuenta, String[] saldo, String[] id_cuenta) {
        if (nombre_cuenta.length == codigo_cuenta.length
                && nombre_cuenta.length == descripcion_cuenta.length
                && nombre_cuenta.length == saldo.length
                && nombre_cuenta.length == id_cuenta.length) {
            for(int i = 0 ; i<nombre_cuenta.length ; i++){
                if("".equals(nombre_cuenta[i]) || "".equals(codigo_cuenta[i]) || "".equals(saldo[i])){
                    return false;
                }
            }
            return true;
        } else {
            return false;
        }
    }

}
