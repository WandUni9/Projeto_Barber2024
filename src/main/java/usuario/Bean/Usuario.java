package usuario.Bean;

import java.util.Date; // Importe a classe java.util.Date para trabalhar com data e hora

public class Usuario {
    private int id;
    private Date data_agenda; // Ajuste o tipo de dado para java.util.Date
    private String especialista;
    private String nome_cliente;
    private String tipo_servico;
    private String valor_servico;
    private String celular;
    
    // Getters e setters...

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public Date getData_agenda() {
        return data_agenda;
    }
    public void setData_agenda(Date data_agenda) {
        this.data_agenda = data_agenda;
    }
    public String getEspecialista() {
        return especialista;
    }
    public void setEspecialista(String especialista) {
        this.especialista = especialista;
    }
    public String getNome_cliente() {
        return nome_cliente;
    }
    public void setNome_cliente(String nome_cliente) {
        this.nome_cliente = nome_cliente;
    }
    public String getTipo_servico() {
        return tipo_servico;
    }
    public void setTipo_servico(String tipo_servico) {
        this.tipo_servico = tipo_servico;
    }
    public String getValor_servico() {
        return valor_servico;
    }
    public void setValor_servico(String valor_servico) {
        this.valor_servico = valor_servico;
    }
    public String getCelular() {
        return celular;
    }
    public void setCelular(String celular) {
        this.celular = celular;
    }
}
