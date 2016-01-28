package com.urbau.feeders;

import com.urbau.beans.OrdenPagoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Util;

import java.sql.Connection;
import java.sql.Statement;

/**
 * Created by xumakgt on 1/27/16.
 */
public class OrdenesPagoOrdenMain {

    private String allColumnNamesNoId = " ID_CREDITO,FECHA,MONTO,TIPO_PAGO,NO_AUTORIZACION,NO_CHEQUE,ID_BANCO,TIPO_TARJETA,NO_TARJETA,ID_USUARIO ";

    public static int getProgramId(){
        return -2;
    }

    public boolean add( OrdenPagoBean bean ){
        Connection con = null;
        Statement stmt= null;
        String sql = "INSERT INTO CLIENTES_CREDITOS_PAGOS " +
                "(" + allColumnNamesNoId + ") " +
                "VALUES " +
                "( " +
                bean.getOrden_id() + ", " +
                "NOW(), " +
                bean.getMonto() + ", " +
                Util.vs(bean.getTipo_pago()) + ", " +
                Util.vs( bean.getNumero_autorizacion() ) + ", " +
                Util.vs( bean.getNumero_cheque() ) + ", " +
                bean.getId_banco() + ", " +
                Util.vs( bean.getTipo_tarjeta() ) + ", " +
                Util.vs( bean.getNumero_tarjeta() ) + ", " +
                bean.getId_usuario() + ")";
        try {
            con = ConnectionManager.getConnection();
            stmt= con.createStatement();

            int total = stmt.executeUpdate( sql );
            return total>0;

        } catch (Exception e) {
            System.out.println( sql );
            e.printStackTrace();
            return false;
        } finally {
            ConnectionManager.close( con, stmt, null );
        }
    }

}
