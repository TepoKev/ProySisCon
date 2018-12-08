/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import modelo.*;
import java.util.Set;
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
    
    public Cuenta recuperarCuenta(Cuenta cuenta) {
        if (cuenta != null) {
            try {
                openSession();
                Query q = this.session.createQuery("FROM Cuenta c WHERE c.id=?");
                q.setInteger(0, cuenta.getId());
                cuenta = (Cuenta) q.uniqueResult();
            } catch (HibernateException he) {
                
            } finally {
                this.session.close();
            }
            
        }
        return cuenta;
    }
    
    public Cuenta recuperarCuenta(String cod) {
        Cuenta c = null;
        try {
            openSession();
            Query q = this.session.createQuery("FROM Cuenta c WHERE c.codigo = ?");
            q.setString(0, cod);
            c = (Cuenta) q.uniqueResult();
        } catch (HibernateException e) {
            
        } finally {
            this.session.close();
        }
        return c;
    }
    
    public List<Partida> recuperarPartidas() {
        List<Partida> p = null;
        try {
            openSession();
            p = (List<Partida>) this.session.createQuery("from Partida p").list();
        } catch (HibernateException e) {
            System.out.println("");
        } finally {
            this.session.close();
        }
        if (p == null) {
            return new ArrayList();
        }
        return p;
    }
    
    public List<Cuenta> recuperarCuentaPrimerN() throws Exception {
        List<Cuenta> c = null;
        try {
            openSession();
            //c = (List<Cuenta>) this.session.createQuery("from Cuenta c where LENGTH(c.codigo)='1'  order by c.codigo asc").list();
            c = (List<Cuenta>) this.session.createQuery("from Cuenta c  order by c.codigo asc").list();
        } catch (HibernateException e) {
            System.out.println("");
        } finally {
            this.session.close();
        }
        if (c == null) {
            return new ArrayList();
            
        }
        return listaAArbol(c);
    }
    
    public List<Cuenta> listaAArbol(List<Cuenta> cuentas) throws Exception {
        List<Cuenta> arbol = new ArrayList<Cuenta>();
        Cuenta actual = null, sig = null;
        String codigoActual = null, codigoSig = null;
        int lenActual = 0, lenSig = 0, nivel = 0;
        arbol.add(cuentas.get(0));
        Cuenta tmp = null;
        String msj = "";
        for (int i = 0; i < cuentas.size() - 1; i++) {
            actual = cuentas.get(i);
            msj = msj + "\n" + actual.getCodigo();
            actual.setCuentasHijas(new ArrayList<Cuenta>());
            sig = cuentas.get(i + 1);
            codigoActual = actual.getCodigo();
            codigoSig = sig.getCodigo();
            lenActual = codigoActual.length();
            lenSig = codigoSig.length();
            if (lenSig == 1) {
                arbol.add(sig);
            }
            if (lenSig > lenActual) //la cuenta siguiente es hija
            {
                if (actual.getCuentasHijas() != null) {
                    if (actual.getCuentasHijas().isEmpty()) {
                        actual.setCuentasHijas(new ArrayList<Cuenta>());
                    } else if (actual.getCuentasHijas().size() == 0) {
                        actual.setCuentasHijas(new ArrayList<Cuenta>());
                    }
                }
                
                actual.getCuentasHijas().add(sig);
                sig.setCuenta(actual);
            } else if (lenSig == lenActual) //la cuenta siguiente es hermana con actual
            {
                tmp = actual.getCuenta();
                sig.setCuenta(tmp);
                tmp.getCuentasHijas().add(sig);
            } else //la cuenta siguiente es de un nivel menos profundo que la actual
            {
                //basado en el codigo de cuenta, determinar cuantos niveles es necesario bajar

                nivel = (int) (Math.round((lenActual - lenSig) / (float) 2) + 1);
                tmp = actual;
                for (int f = 1; f <= nivel; f++) {
                    tmp = tmp.getCuenta();
                }
                if (tmp == null) {
                    arbol.add(sig);
                    sig.setCuenta(null);
                } else {
                    tmp.getCuentasHijas().add(sig);
                    sig.setCuenta(tmp);
                    
                }
                
            }
            
        }
        
        return arbol;
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
        } catch (HibernateException he) {
            
        } finally {
            session.close();
        }
    }
    
    public Long sigContador() {
        long i = 0;
        try {
            openSession();
            session.beginTransaction();
            String query = "select nextval('partidas_contador_seq') as contador";
            SQLQuery sql = session.createSQLQuery(query);
            sql.addScalar("contador", StandardBasicTypes.LONG);
            i = (Long) sql.uniqueResult();
        } catch (HibernateException he) {
            
        } finally {
            session.close();
        }
        return i;
    }
    
    public void registrarPartidas(ArrayList<Partida> partidas, ArrayList<CargoAbono> cargosAbonos) {
        int i;
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
                partidas.get(i).setContador(null);
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
        } catch (HibernateException he) {
            
        } finally {
            this.session.close();
        }
        return next;
    }
    
    public ArrayList<CargoAbono> ordenarCA(Set cargoAbono) {
        ArrayList<CargoAbono> cargo = new ArrayList();
        ArrayList<CargoAbono> abono = new ArrayList();
        CargoAbono aux;
        try {
            for (Object ca : cargoAbono) {
                aux = (CargoAbono) ca;
                if ("c".equals(aux.getOperacion())) {
                    cargo.add(aux);
                } else if ("a".equals(aux.getOperacion())) {
                    abono.add(aux);
                }
            }
            cargo.addAll(abono);
            Collections.sort(cargo, (CargoAbono o1, CargoAbono o2) -> new Integer(o1.getId()).compareTo(new Integer(o2.getId())));
        } catch (Exception e) {
        }
        return cargo;
    }
    
    public ArrayList<Mayor> mayorizarCuentas(int nivel) {
        //Este metodo hace la mayorizacion de todo el catalogo basado en el nivel de la cuenta
        List<Cuenta> listaC;
        ArrayList<Mayor> mayor = new ArrayList<>();
        Mayor m;
        try {
            openSession();
            //Mediante esta instruccion se obtiene las cuentas de nivel seleccionado
            listaC = (List<Cuenta>) this.session.createQuery("from Cuenta c where LENGTH(c.codigo)=" + nivel + " order by c.codigo asc").list();
            //Con este for se recorreran estas cuentas del nivel seleccionado y tambien sus subniveles 
            //se recojeran todos sus cargos o abonos mediante un metodo recursivo
            for (Cuenta c : listaC) {
                m = new Mayor();
                m.setCuenta(c);
                recursivo(c, m);
                mayor.add(m);
            }
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            this.session.close();
        }
        return mayor;
        
    }
    
    public void recursivo(Cuenta c, Mayor m) {
        List<CargoAbono> listCA = null;
        try {
            if (c != null) {
                m.getTransacciones().addAll(c.getCargosAbonos());
                if (c.getCuentas().size() > 0) {
                    c.getCuentas().forEach((Object aux) -> {
                        recursivo((Cuenta) aux, m);
                    });
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
