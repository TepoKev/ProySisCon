/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.CargoAbono;
import modelo.Cuenta;
import modelo.Partida;

/**
 *
 * @author deb
 */
public class ServletPartida extends HttpServlet {

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
	try (PrintWriter out = response.getWriter()) {
	  /**
	   *
	   * El registro de partidas consiste debe recibir los siguientes datos
	   * numeros-partidas[] un arreglo con los números de partida
	   * descripciones[] un arreglo con las descripciones para cada partida
	   * fechas[] un arreglo con las fechas en las que se realizan cada partida
	   *
	   * A cada partida se le asignaran sus cargos y abonos. El registro de
	   * partidas necesita los siguientes datos para esto: montos[] un arreglo
	   * con las cantidades que se asignan en cargo o abono ops[] un arreglo con
	   * las operaciones respectivas. "c" indica cargo, "a" indica abono
	   * num-partidas[] el numero de partida respectivo al que pertenece cada
	   * cargo / abono codigos-cuentas
	   */

	  //para crear cada objeto Partida
	  String numeroPartidas[];
	  String descripciones[];
	  String fechas[];
	  int cantPartidas = 0;
	  float cargo = 0, abono = 0;

	  //para crear cada cargo / abono y asignarlos a sus respectivas partidas
	  String numPartidas[];
	  String codigoCuentas[];
	  String montos[];
	  String ops[];
	  int cantCargosAbonos = 0;

	  //objetos necesarios para el registro de datos
	  ArrayList<Partida> partidas = new ArrayList();
	  ArrayList<CargoAbono> cargosAbonos = new ArrayList();
	  Cuenta cuenta;
	  Partida partida;
	  CargoAbono ch;

	  //captura de los datos del formulario
	  numeroPartidas = request.getParameterValues("numerospartidas[]");
	  descripciones = request.getParameterValues("descripciones[]");
	  fechas = request.getParameterValues("fechas[]");
	  numPartidas = request.getParameterValues("numpartidas[]");
	  codigoCuentas = request.getParameterValues("codigoscuentas[]");
	  montos = request.getParameterValues("montos[]");
	  ops = request.getParameterValues("ops[]");

	  //validar los tamaños de numeroPartidas, descripciones, fechas
	  if (!(numeroPartidas.length == descripciones.length && numeroPartidas.length == fechas.length)) {
		out.print("Un error fatal ha ocurrido. Alguna fuente externa o un programa malicioso ha modificado internamente los datos");
		return;
	  }

	  //validar los tamaños de numPartidas, codigoCuentas, montos, ops
	  if (!(numPartidas.length == codigoCuentas.length && numPartidas.length == montos.length && numPartidas.length == ops.length)) {
		out.print("Un error fatal ha ocurrido. Alguna fuente externa o un programa malicioso ha modificado internamente los datos");
		return;
	  }

	  //validacion de los tipos de datos
	  /*
		 #####################3##################
		 #  NO OLVIDAR LA VALIDACION DE FECHAS  #
		 ########################################
	   */
	  cantPartidas = numeroPartidas.length;
	  cantCargosAbonos = numPartidas.length;

	  int i;
	  //crear las partidas
	  for (i = 0; i < cantPartidas; i++) {
		partida = new Partida();
		partida.setContador(Integer.parseInt(numeroPartidas[i]));
		partida.setDescripcion(descripciones[i]);
		partida.setFecha(fechas[i]);
		partidas.add(partida);
	  }

	  Controlador ctl;
	  ctl = new Controlador();
	  //asignar a cada partida sus cargos y abonos
	  for (i = 0; i < cantCargosAbonos; i++) {
		ch = new CargoAbono();
		ch.setCuenta(ctl.recuperarCuenta(codigoCuentas[i]));
		ch.setMonto(Float.parseFloat(montos[i]));
		ch.setOperacion(ops[i]);
		partida = getPartida(Integer.parseInt(numPartidas[i]), partidas);
		if (partida == null) {
		  out.print("Un error ha ocurrido. Un cargo / abono no tiene un contador de partida asignado No se registrarán");
		  return;
		}
		ch.setPartida(partida);
		cargosAbonos.add(ch);
	  }
	  cargosAbonos = quickSortCH(cargosAbonos);
	  for (CargoAbono ca : cargosAbonos) {
		if ("c".equals(ca.getOperacion())) {
		  cargo += ca.getMonto();
		} else if ("a".equals(ca.getOperacion())) {
		  abono += ca.getMonto();
		}
	  }
	  if (cargo != abono) {
		out.print("<p style=\"color:red\">Esta partida no se puede procesada el cargo y el abono no son iguales</p>");
		return;
	  }
	  ctl.registrarPartidas(partidas, cargosAbonos);
	  out.println("Se han registrado satisfactoriamente las partidas");
	}
  }//Fin processRequest 

  public Partida getPartida(int contador, ArrayList<Partida> lista) {
	//este metodo busca la partida que concida con el contador enviado como parametro
	int len = lista.size();
	Partida partida;
	for (int i = 0; i < len; i++) {
	  partida = lista.get(i);
	  if (partida.getContador() == contador) {
		return partida;
	  }
	}
	return null;
  }

  public ArrayList<CargoAbono> quickSortCH(ArrayList<CargoAbono> lista) {
	Collections.sort(lista, (CargoAbono ch1, CargoAbono ch2) -> {
	  int c1 = ch1.getPartida().getContador();
	  int c2 = ch2.getPartida().getContador();
	  if (c1 == c2) {
		return 0;
	  } else if (c1 > c2) {
		return 1;
	  } else {
		return -1;
	  }
	});
	return lista;
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

}
