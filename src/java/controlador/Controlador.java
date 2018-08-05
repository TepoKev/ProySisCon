/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import modelo.*;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.type.StandardBasicTypes;

/**
 *
 * @author kedut
 */
public class Controlador {

   private Session session;
   private SessionFactory factory;

   public Controlador() {

   }

   private void openSession() {
	  this.factory = HibernateUtil.getSessionFactory();
	  this.session = factory.openSession();
   }

   public Serializable guardar(Object obj) {
	  Serializable c = null;
	  try {
		 openSession();
		 this.session.beginTransaction();
		 c = (Serializable) this.session.save(obj);
		 this.session.getTransaction().commit();
	  } catch (HibernateException e) {
              System.out.println("");
	  } finally {
		 this.session.close();
	  }
	  return c;
   }

   public void actualizar(Object obj) {
	  try {
		 openSession();
		 this.session.beginTransaction();
		 this.session.update(obj);
		 this.session.getTransaction().commit();
	  } catch (HibernateException e) {

	  } finally {
		 this.session.close();
	  }

   }

   public void eliminar(Object obj) {
	  try {
		 openSession();
		 this.session.beginTransaction();
		 this.session.delete(obj);
		 this.session.getTransaction().commit();
	  } catch (HibernateException e) {

	  } finally {
		 this.session.close();
	  }

   }

   public List buscarPorNombreOCodigo(String busqueda) {
	  List cuentas = new ArrayList();
	  try {
		 openSession();
		 Query q = this.session.createQuery("FROM Cuenta c where c.codigo = ? or lower(c.nombre) LIKE lower(?)");
		 q.setString(0, busqueda);
		 q.setString(1, "%" + busqueda + "%");
		 cuentas = q.list();
	  } catch (HibernateException h) {

	  } finally {
		 this.session.close();
	  }

	  return cuentas;
   }

   public Cuenta recuperarCuenta(String cod) {
	  Cuenta c = null;
	  try {
		 openSession();
		 Query q = this.session.createQuery("FROM Cuenta c WHERE c.codigo = ?");
		 q.setString(0, cod);
		 c = (Cuenta) q.list().get(0);
	  } catch (HibernateException e) {

	  } finally {
		 this.session.close();
	  }
	  return c;
   }
   
   public List<Partida> recuperarPartidas(){
      List<Partida> p = null;
      try {
		 openSession();
		 p = (List<Partida>) this.session.createQuery("from Partida p").list();
	  } catch (HibernateException e) {
              System.out.println("");
	  } finally {
		 this.session.close();
	  }
          if(p == null){
              return new ArrayList();
          }
      return p;
   }

   public List<Cuenta> recuperarCuentaPrimerN() {
	  List<Cuenta> c = null;
	  try {
		 openSession();
		 c = (List<Cuenta>) this.session.createQuery("from Cuenta c where LENGTH(c.codigo)='1' order by c.codigo asc").list();
	  } catch (HibernateException e) {
              System.out.println("");
	  } finally {
		 this.session.close();
	  }
          if(c == null){
              return new ArrayList();
          }
	  return c;
   }
   public void resetContador() {
       //Este metodo reinicia las secuancia de las tablas cuenta y partida actualmente tienes que 
       //descomentar solo la consulta que vas a usar y comentar las otras solo se puede una a la vez
	  try {
		 openSession();
		 session.beginTransaction();
//		 SQLQuery sql = session.createSQLQuery("ALTER SEQUENCE partidas_id_seq restart WITH 1;");
//                 sql.executeUpdate();

//		 SQLQuery sql = session.createSQLQuery("ALTER SEQUENCE cuentas_id_seq restart WITH 0;");
//                 sql.executeUpdate();

		 SQLQuery sql = session.createSQLQuery("ALTER SEQUENCE partidas_contador_seq restart WITH 2;");
                 sql.executeUpdate();
	  }catch(HibernateException he) {
		 
	  }finally{
		 session.close();
	  }
   }
   
   public Long sigContador(){
	  long i = 0;
	  try {
		 openSession();
		 session.beginTransaction();
		 String query = "select nextval('partidas_contador_seq') as contador";
		 SQLQuery sql = session.createSQLQuery(query);
		 sql.addScalar("contador",StandardBasicTypes.LONG);
		 i = (Long) sql.uniqueResult();
	  }catch(HibernateException he) {
		 
	  }finally {
		 session.close();
	  }
	  return i;
   }
   public void registrarPartidas(ArrayList<Partida> partidas, ArrayList<CargoAbono> cargosAbonos) {
	  int i = 0;
	  int len;
	  CargoAbono ch;
	  Partida partida;
	  Serializable id;
	  try {
		 openSession();
		 
		 len = partidas.size();

		 
		//comienza la transaccion
		 this.session.beginTransaction();
		 //insercion en la base de datos
		 for (i = 0; i < len; i++) {
			id = this.session.save(partidas.get(i));
			partidas.get(i).setId((Integer) id);
		 }
		 //fin de la transaccion
		 this.session.getTransaction().commit();
		 
		 len = cargosAbonos.size();
		 //comienza la transaccion
		 this.session.beginTransaction();
		 //insercion en la base de datos
		 for (i = 0; i < len; i++) {
			this.session.save(cargosAbonos.get(i));
		 }
		 //fin de la transaccion
		 this.session.getTransaction().commit();
		 
		 
		 
	  } catch (HibernateException e) {
		 System.out.println("");
	  } finally {
		 this.session.close();
	  }
   }
   public Integer nextValPartida() {
	  Integer next = 0;
	  try {
		 this.openSession();
		 SQLQuery sql = this.session.createSQLQuery("select NEXTVAL()");
		 sql.uniqueResult();
	  }catch(HibernateException he) {
		 
	  }finally {
		 this.session.close();
	  }
	  return next;
   }
   
}
