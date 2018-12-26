/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Student
 */
public class RangoPorcentaje {

    private float limiteInferior;
    private float limiteSuperior;
    private float porcentaje;
    /*
        extremo de aplicacion: 
        'I': aplicar si esta en el limite inferior
        'F': aplicar si esta en el limite superior
        'A': aplicar si esta en ambos limites
     */
    private char extremoDeAplicacion;

    public RangoPorcentaje(float limiteInferior, float limiteSuperior, float porcentaje, char extremoDeAplicacion) throws Exception {
        try {
            setLimites(limiteInferior, limiteSuperior);
            setPorcentaje(porcentaje);
            setExtremoDeAplicacion(extremoDeAplicacion);
        } catch (Exception e) {
            throw e;
        }

    }

    public void setLimites(float limiteInferior, float limiteSuperior) throws Exception {
        if (limiteInferior < limiteSuperior) {
            this.limiteInferior = limiteInferior;
            this.limiteSuperior = limiteSuperior;
        } else {
            throw new Exception("El limite inferior es mayor o igual que el limite superior");
        }
    }

    public void setPorcentaje(float porcentaje) throws Exception {
        if (porcentaje >= 0 && porcentaje <= 100) {
            this.porcentaje = porcentaje;
        } else {
            throw new Exception("Error: el porcentaje debe ser >=0 y <=100");
        }
    }

    public float getLimiteInferior() {
        return limiteInferior;
    }

    public float getLimiteSuperior() {
        return limiteSuperior;
    }

    public float getPorcentaje() {
        return porcentaje;
    }

    public char getExtremoDeAplicacion() {
        return extremoDeAplicacion;
    }

    public void setExtremoDeAplicacion(char extremoDeAplicacion) throws Exception {
        switch (extremoDeAplicacion) {
            case 'I':
            case 'S':
            case 'A':
                this.extremoDeAplicacion = extremoDeAplicacion;
                break;
            default:
                throw new Exception("Error para los rangos de aplicacion solo se aceptan: I (inferior), S (superior) o A (ambos)");
        }
    }

    public boolean estaEnRango(float valor) {
        switch (extremoDeAplicacion) {
            case 'I':
                if (valor >= limiteInferior && valor < limiteSuperior) {
                    return true;
                }
                break;
            case 'S':
                if (valor > limiteInferior && valor <= limiteSuperior) {
                    return true;
                }
                break;
            case 'A':
                if (valor >= limiteInferior && valor <= limiteSuperior) {
                    return true;
                }
                break;
        }
        return false;
    }

    public float aplicarPorcentaje(float valor) {
        if (estaEnRango(valor)) {
            return (porcentaje / (float) 100) * valor;
        } else {
            return -1;
        }
    }

    public boolean seIntersectaCon(RangoPorcentaje rp) throws Exception {
        if (rp == null) {
            throw new Exception("El rango pasado como parametro es nulo");
        }
        if (estaEnRango(rp.getLimiteInferior()) || estaEnRango(rp.getLimiteSuperior())) {
            return true;
        } else {
            return false;
        }
    }
    //Este metodo retorna 1 si el rango pasado como parametro esta situado a la derecha del este objeto
    //retorna -1 si el rango pasado como parametro esta situado a la izquierda de este objeto
    //devuelve 0 si esta dentro del actual

    public int compareTo(RangoPorcentaje rp) throws Exception {
        if (rp == null) {
            throw new Exception("El rango pasado como parametro es nulo");
        }

        if (limiteInferior < rp.getLimiteInferior() && limiteSuperior <= rp.getLimiteInferior()) {
            //el rango pasado como parametro va a la derecha
            return 1;
        } else if (rp.getLimiteInferior() < limiteInferior && rp.getLimiteSuperior() <= limiteInferior) {
            //el rango pasado como parametro va a la izquierda
            return -1;
        } else {
            return 0;
        }
    }

    public boolean estaEnMedioDe(RangoPorcentaje anterior, RangoPorcentaje siguiente) throws Exception {
        if (anterior == null || siguiente == null) {
            throw new Exception("Uno o los dos rangos: anterior y siguiente pasados como parametro son nulos");
        }
        if (limiteInferior >= anterior.getLimiteSuperior() && limiteSuperior <= siguiente.getLimiteInferior()) {
            return true;
        } else {
            return false;
        }
    }
}
