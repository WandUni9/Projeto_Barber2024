package LoginBean;
public class Main {
    public static void main(String[] args) {
        String jdbcURL = "jdbc:mysql://localhost:3306/seu_banco_de_dados"; // Substitua pelo URL do seu banco de dados
        String jdbcUsername = "seu_usuario"; // Substitua pelo seu nome de usuário do banco de dados
        String jdbcPassword = "sua_senha"; // Substitua pela sua senha do banco de dados

        UsuarioDao usuarioDao = new UsuarioDao(jdbcURL, jdbcUsername, jdbcPassword);

        // Criar um novo usuário com os dados fornecidos
        Usuario novoUsuario = new Usuario();
        novoUsuario.setNome("Christyan");
        novoUsuario.setEmail("christyan_anastacio@hotmail.com");

        try {
            boolean sucesso = usuarioDao.insertUsuario(novoUsuario);
            if (sucesso) {
                System.out.println("Usuário inserido com sucesso!");
            } else {
                System.out.println("Falha ao inserir o usuário.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
