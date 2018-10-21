<%-- 
    Document   : mostrar-partidas-registradas
    Created on : 10-14-2018, 06:01:16 AM
    Author     : Student
--%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.CargoAbono"%>
<%@page import="modelo.Partida"%>
<%@page import="java.util.ArrayList"%>
<!--
Contenido del modal
-->
<%
    ArrayList<Partida> partidas = (ArrayList<Partida>) request.getAttribute("listaPartidas");
    ArrayList<CargoAbono> cargosAbonos = (ArrayList<CargoAbono>) request.getAttribute("listaCargosAbonos");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    if (partidas == null || cargosAbonos == null) {
%>
<div class="modal-header" >Un error ha ocurrido</div>
<div class="modal-body">parece que has llamada esta página sin ser autorizado por el servidor</div>
<div class="modal-footer"></div>
<%
        return;
    }
    Partida partida;

%>
<div class="modal-header bg-success">
    <h4 class="text-white" style="text-align:center;">Partidas</h4>
</div>
<div class="modal-body">
    <% for (int i = 0; i < partidas.size(); i++) {
            partida = partidas.get(i);
    %>
    <h4>Partida # <%=partida.getContador()%> - <%=partida.getFecha()==null? "<span class=\"text-danger font-weight-bold\">fecha nula</span>":sdf.format(partida.getFecha())%></h4>
    <table class="table table-sm">
        <thead>
            <tr>
                <th scope="col">Codigo</th>
                <th scope="col">Nombre</th>
                <th scope="col">Cargo</th>
                <th scope="col">Abono</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (CargoAbono ca : cargosAbonos) {
                    if (partida.getId() == ca.getPartida().getId()) {
            %>
            <tr>
                <td><%=ca.getCuenta().getCodigo()%></td>
                <td><%=ca.getCuenta().getNombre()%></td>
                <td><%=("c".equalsIgnoreCase(ca.getOperacion())) ? ca.getMonto() : ""%></td>
                <td><%=("a".equalsIgnoreCase(ca.getOperacion())) ? ca.getMonto() : ""%></td>
            </tr>  

            <%
                    }
                }
            %>

        </tbody>
    </table>
    <p><%=partida.getDescripcion()%></p>
    <%}%>
</div>
<div class="modal-footer">
    <%=partidas.size()%> partidas registradas, con <%=cargosAbonos.size()%> cargos o abonos
</div>