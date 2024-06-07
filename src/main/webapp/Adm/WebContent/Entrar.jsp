<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>

<%
// Obtenha a ID do usu�rio a partir de onde voc� armazenou na sess�o ou onde estiver dispon�vel
// Por exemplo, voc� pode ter armazenado na sess�o durante o login.
int usuario_id = 1; // Voc� deve substituir por uma maneira de obter a ID do usu�rio

// Configura��es de conex�o ao banco de dados
String url = "jdbc:mysql://localhost:3306/seu_banco_de_dados";
String username = "seu_usuario";
String password = "sua_senha";

Connection conn = null;
PreparedStatement stmt = null;

try {
    // Estabelece a conex�o com o banco de dados
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);

    // Insere um registro na tabela registros_login
    String sql = "INSERT INTO registros_login (usuario_id) VALUES (?)";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, usuario_id);
    stmt.executeUpdate();
    
    out.println("Registro de login inserido com sucesso.");

} catch (SQLException | ClassNotFoundException e) {
    out.println("Erro ao inserir registro de login: " + e.getMessage());
} finally {
    // Fecha os recursos
    try {
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        out.println("Erro ao fechar conex�o: " + e.getMessage());
    }
}
%>
