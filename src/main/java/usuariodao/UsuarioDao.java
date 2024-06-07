package usuariodao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.sql.SQLException;
import usuario.Bean.Usuario;

public class UsuarioDao {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/system_barbearia?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "diego238563");
        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }

    public static int salvarUsuario(Usuario u) {
        int status = 0;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO agendamento (data_agenda, especialista, nome_cliente, tipo_servico, valor_servico, celular) VALUES (?, ?, ?, ?, ?, ?)")) {
            Timestamp timestamp = new Timestamp(u.getData_agenda().getTime());
            ps.setTimestamp(1, timestamp);
            ps.setString(2, u.getEspecialista() != null ? u.getEspecialista() : "");
            ps.setString(3, u.getNome_cliente() != null ? u.getNome_cliente() : "");
            ps.setString(4, u.getTipo_servico() != null ? u.getTipo_servico() : "");
            ps.setString(5, u.getValor_servico() != null ? u.getValor_servico() : "");
            ps.setString(6, u.getCelular() != null ? u.getCelular() : "");
            status = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public boolean updateAgendamento(Usuario u) {
        int status = 0;
        if (u != null && u.getId() != 0) {
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement("UPDATE agendamento SET data_agenda=?, especialista=?, nome_cliente=?, tipo_servico=?, valor_servico=?, celular=? WHERE id=?")) {
                Timestamp timestamp = new Timestamp(u.getData_agenda().getTime());
                ps.setTimestamp(1, timestamp);
                ps.setString(2, u.getEspecialista());
                ps.setString(3, u.getNome_cliente());
                ps.setString(4, u.getTipo_servico());
                ps.setString(5, u.getValor_servico());
                ps.setString(6, u.getCelular());
                ps.setInt(7, u.getId());
                status = ps.executeUpdate();
            } catch (SQLException e) {
                System.out.println(e);
            }
        } else {
            System.out.println("ID do agendamento é zero ou objeto de agendamento é nulo. Atualização não foi realizada.");
        }
        return status > 0;
    }

    public static List<Usuario> getAllagendamento() {
        List<Usuario> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM agendamento");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario agendamento = new Usuario();
                agendamento.setId(rs.getInt("id"));
                agendamento.setData_agenda(new Date(rs.getTimestamp("data_agenda").getTime()));
                agendamento.setEspecialista(rs.getString("especialista"));
                agendamento.setNome_cliente(rs.getString("nome_cliente"));
                agendamento.setTipo_servico(rs.getString("tipo_servico"));
                agendamento.setValor_servico(rs.getString("valor_servico"));
                agendamento.setCelular(rs.getString("celular"));
                list.add(agendamento);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static int deletarUsuario(Usuario u) {
        int status = 0;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM agendamento WHERE id=?")) {
            ps.setInt(1, u.getId());
            status = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}
