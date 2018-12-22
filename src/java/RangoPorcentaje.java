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

    public RangoPorcentaje(float limiteInferior, float limiteSuperior, float porcentaje) throws Exception {
        try {
            setLimites(limiteInferior, limiteSuperior);
            setPorcentaje(porcentaje);
        } catch (Exception e) {
            throw e;
        }

    }

    public void setLimites(float limiteInferior, float limiteSuperior) throws Exception {
        if (limiteInferior < limiteSuperior) {
            this.limiteInferior = limiteInferior;
            this.limiteSuperior = limiteSuperior;
        } else {
            throw new Exception("El limite inferior es mayor que el limite superior");
        }
    }

    public void setPorcentaje(float porcentaje) throws Exception {
        if (porcentaje >= 0 && porcentaje <= 100) {
            this.porcentaje = porcentaje;
        } else {
            throw new Exception();
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

    public boolean enRango(float valor) {
        if (valor >= limiteInferior && valor <= limiteSuperior) {
            return true;
        } else {
            return false;
        }
    }

    public float aplicarPorcentaje(float valor) {
        if (enRango(valor)) {
            return (porcentaje / (float) 100) * valor;
        } else {
            return -1;
        }
    }
}
