/*
    Programación 4
    I Ciclo - 2021
    Proyecto 1 - Cursos Libres.com
    117440348 - Joaquin Barrientos Monge
    A00144883 - Kathy Sandoval Blandon
 */


package Services;


import Database.AdministradorDAO;
import Database.EstudiantesDAO;
import Database.GruposAuxDAO;
import Database.ProfesorDAO;
import Database.RolDAO;
import Database.UsuariosDAO;
import Database.area_tematicaDao;
import Database.cursoDao;
import Database.especialidadDao;
import Database.estadoDao;
import Database.grupoDao;
import Database.horarioDao;
import Database.matriculaDao;
import Logic.Estudiante;
import Logic.administrador;
import Logic.area_tematica;
import Logic.curso;
import Logic.grupo;
import Logic.grupo_aux;
import Logic.horario;
import Logic.profesor;
import Logic.usuario;
import java.util.List;
import Logic.matricula;
import Logic.estado;

/**
 *
 * @author Joaquin
 */
public class Service {
    private AdministradorDAO administrador_dao;
    private EstudiantesDAO estudiantes_dao;
    private ProfesorDAO profesor_dao;
    private RolDAO rol_dao;
    private UsuariosDAO usuarios_dao;
    private area_tematicaDao area_dao;
    private cursoDao curso_dao;
    private especialidadDao especialidad_dao;
    private estadoDao estado_dao;
    private grupoDao grupo_dao;
    private horarioDao horario_dao;
    private matriculaDao matricula_dao;
    private GruposAuxDAO grupoAux_dao;
    
    private static Service theInstance;
    
    public static Service instance(){
        if(theInstance==null){
            theInstance = new Service();
        }
        return theInstance;
    }
    
    public Service(){
        administrador_dao = new AdministradorDAO();
        estudiantes_dao = new EstudiantesDAO();
        profesor_dao = new ProfesorDAO();
        rol_dao = new RolDAO();
        usuarios_dao = new UsuariosDAO();
        area_dao = new area_tematicaDao();
        curso_dao = new cursoDao();
        especialidad_dao = new especialidadDao();
        estado_dao = new estadoDao();
        grupo_dao = new grupoDao();
        horario_dao = new horarioDao();
        matricula_dao = new matriculaDao();
        grupoAux_dao = new GruposAuxDAO();
        
    }
    public profesor buscar_profesor(String id) throws Exception{
        profesor result = null;
        result = profesor_dao.readbyuser(id);
        return result;        
    }
     public profesor buscar_profesor(int id) throws Exception{
        profesor result = null;
        result = profesor_dao.read(id);
        return result;        
    }
     public curso buscar_curso(int id) throws Exception{
        curso result = null;
        result = curso_dao.read(id);
        return result;        
    }
    
    public administrador buscar_administrador(String id) throws Exception{
        administrador result = null;
        System.out.println("ANTES");
        result = administrador_dao.read(id);
        System.out.println("DESPUES");
        return result;        
    }
    
    public Estudiante buscar_estudiante(String id) throws Exception{
        Estudiante result = null;
        result = estudiantes_dao.read(id);
        return result;        
    }

    public usuario login(usuario u) throws Exception{
        usuario result = null;
        
        result = usuarios_dao.read(u.getId());
        if(result == null)
            throw new Exception("Usuario no encontrado");
        if(!(result.getClave()).equals(u.getClave())){
            throw new Exception("Usuario con mala contrasenna");
        }
        
        return result;
    }
    
    
    // ------------ Cursos -------------    

    public List<curso> getCursos() {
        return curso_dao.findAll();
    }
    
    public List<curso> getCursosOferta(){
        return curso_dao.findEnOferta();
    }
    
    public void addCurso(curso o)throws Exception{
        curso_dao.create(o);
    }

    public curso getCurso(curso o) throws Exception{
        return curso_dao.read(o.getCurso());
    } 
    
    public curso getCurso_int(int o) throws Exception{
        return curso_dao.read(o);
    }

    public void updateCurso(curso o)throws Exception{
        curso_dao.update(o);
    }
    
    public List<curso> searchCurso(curso o){
        return curso_dao.findByDescripcion(o); 
    }
    // ------------ Grupos -------------    

    public List<grupo> getGrupos() {
        return grupo_dao.findAll();
    }
    public List<grupo> getGrupos(curso o) {
        return grupo_dao.findByCurso(o);
    }
    public void addGrupo(grupo o)throws Exception{
        grupo_dao.create(o);
    }

    public grupo getGrupo(grupo o) throws Exception{
        return grupo_dao.read(o.getNum_grupo(),o.getCurso_id());
    }  
    
    public grupo getGrupo_INTS(int g, int c) throws Exception{
        return grupo_dao.read(g,c);
    } 

    public void updateGrupo(grupo o)throws Exception{
        grupo_dao.update(o);
    }
    
    public List<grupo> searchGrupo_C(curso o){
        return grupo_dao.findByCurso(o); 
    }
    public List<grupo> searchGrupo_P(profesor o){
        return grupo_dao.findByProfesor(o); 
    }
    // ------------ Horarios -------------    

    public List<horario> getHorarios() {
        return horario_dao.findAll();
    }
    public List<horario> getGrupos(horario o) {
        return horario_dao.findByCurso(o);
    }
    public void addHorario(horario o)throws Exception{
        horario_dao.create(o);
    }
    
    public horario gethorario(int num_grupo, int curso_id ) throws Exception{
        return horario_dao.read(num_grupo,curso_id);
    }  

    public void updateHorario(horario o)throws Exception{
        horario_dao.update(o);
    }
    
    public List<horario> searchHorario(horario o){
        return horario_dao.findByCurso(o); 
    }
    // ------------ Area_Tematica -------------    

    public List<area_tematica> getArea_tematicas() {
        return area_dao.findAll();
    }
    
    public void add(area_tematica o)throws Exception{
        area_dao.create(o);
    }

    public area_tematica get(area_tematica o) throws Exception{
        return area_dao.read(o.getId_area());
    }  

    public void update(area_tematica o)throws Exception{
        area_dao.update(o);
        area_tematica stored=this.get(o);
    }
    
    public List<area_tematica> searchD(area_tematica o){
        return area_dao.findByDescripcion(o); 
    }
    
    public List<area_tematica> searchID(area_tematica o){
        return area_dao.findByDescripcion(o); 
    }
     public area_tematica buscar_at(int id) throws Exception{
        area_tematica result = null;
        result = area_dao.read(id);
        return result;        
    }
    
    public void crearEstudiante(Estudiante e) throws Exception{
        estudiantes_dao.create(e);    
    }
    
    
    public void crearUsuario(usuario u) throws Exception{
        usuarios_dao.create(u);
    }
    
    public void crearProfesor(profesor p) throws Exception{
        profesor_dao.create(p);
    }
    
    public List<curso> getCursosFiltro(String c){
        return curso_dao.findByDescripcion_String(c);
    }
    
    public List<grupo_aux> getGruposEspecifico(curso c) throws Exception{
        System.out.println("Entra al service");
        return grupoAux_dao.read(Integer.toString(c.getCurso()));
        
    }
    
     public List<profesor> getProfesores(){
        return profesor_dao.findAll();}
        
        public List<profesor> searchProfesor(String o){
        return profesor_dao.findByNombre(o); 
    }
    
    public void Matricular(matricula m) throws Exception{
        matricula_dao.create(m);    
    }
    
    public List<matricula> getHistorial(int e) throws Exception{
        return matricula_dao.findAll(e);
    
    }
    
    
    public estado getEstado(int e) throws Exception{
        return estado_dao.read(e);
    }
        
        
}
