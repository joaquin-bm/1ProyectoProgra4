/*
    Programación 4
    I Ciclo - 2021
    Proyecto 1 - Cursos Libres.com
    117440348 - Joaquin Barrientos Monge
    A00144883 - Kathy Sandoval Blandon
 */
package Database;

import Logic.Estudiante;
import Logic.matricula;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Joaquin
 */
public class EstudiantesDAO {
    public Estudiante create(Estudiante cl) throws SQLException, Exception{
        String sqlcommand =  "insert into estudiante(id_estudiante, usuario_id, apellido1, apellido2, nombre, telefono, e_mail)"
                + "values(?,?,?,?,?,?,?)";
        PreparedStatement stm = Database.instance().prepareStatement(sqlcommand);       
        stm.setString(1,Integer.toString(cl.getId_estudiante()));
        stm.setString(2,cl.getUsuario_id());
        stm.setString(3,cl.getApellido1());
        stm.setString(4,cl.getApellido2());
        stm.setString(5,cl.getNombre());
        stm.setString(6,cl.getTelefono());
        stm.setString(7,cl.getE_mail());    
        System.out.println(stm);
        int count = Database.instance().executeUpdate(stm);
        if (count == 0) {            
            throw new Exception("Ya existe un estudiante con esa información");
        }
        return cl;
        
    }
    
    public Estudiante read(String id) throws Exception{        
        String sqlcommand = "select * from estudiante where usuario_id = ?";
        PreparedStatement stm = Database.instance().prepareStatement(sqlcommand);
        stm.setString(1, id);
        ResultSet rs =  Database.instance().executeQuery(stm);           
        if (rs.next()) {            
            return from(rs);
        }
        else{
            throw new Exception ("No se encontró el estudiante");
        }
    }
    
    
    
    public Estudiante from (ResultSet rs){
        try {
            Estudiante e = new Estudiante();     
            e.setId_estudiante(rs.getInt("id_estudiante"));
            e.setUsuario_id(rs.getString("usuario_id"));
            e.setApellido1(rs.getString("apellido1"));
            e.setApellido2(rs.getString("apellido2"));
            e.setNombre(rs.getString("nombre"));
            e.setTelefono(rs.getString("telefono"));
            e.setE_mail(rs.getString("e_mail"));    
            System.out.println("Estudiante registrado");
            return e;
        } catch(SQLException ex){
            return null;
        }
    }
}