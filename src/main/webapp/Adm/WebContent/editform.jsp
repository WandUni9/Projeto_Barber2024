<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usuariodao.UsuarioDao"%>
<%@ page import="usuario.Bean.Usuario"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.ParseException"%>

<jsp:useBean id="u" class="usuario.Bean.Usuario" />
<jsp:setProperty property="*" name="u" />

<%
    // Obtém a data do formulário e remove caracteres desnecessários
    String dataAgendamentoStr = request.getParameter("Data");
    // Verifica se o parâmetro não é nulo antes de manipulá-lo
    if (dataAgendamentoStr != null) {
        // Remova os caracteres indesejados
        dataAgendamentoStr = dataAgendamentoStr.replaceAll("[^0-9:/\\s]", "");
    }
    
    java.util.Date dataAgendamentoUtil = null;
    try {
        // Tente fazer o parse da data com o padrão esperado "dd/MM/yyyy HH:mm"
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        dataAgendamentoUtil = dateFormat.parse(dataAgendamentoStr);
    } catch (ParseException e) {
        // Se ocorrer um erro ao fazer o parse da data, imprima o erro no console
        e.printStackTrace();
    }

    // Se a data foi parseada com sucesso, prossiga com a atualização
    if (dataAgendamentoUtil != null) {
        // Define os atributos do objeto Usuario
        u.setData_agenda(new java.sql.Timestamp(dataAgendamentoUtil.getTime()));
        u.setEspecialista(request.getParameter("Especialista"));
        u.setNome_cliente(request.getParameter("NomeCliente"));
        u.setTipo_servico(request.getParameter("TipoServico"));
        u.setValor_servico(request.getParameter("ValorServico"));
        u.setCelular(request.getParameter("Celular"));
        
        // Capturar o ID do formulário
        String idEspecialista = request.getParameter("idEspecialista");

        // Verifica se o ID não é nulo antes de definir no objeto Usuario
        if (idEspecialista != null) {
            // Definir o ID no objeto Usuario
            u.setId(Integer.parseInt(idEspecialista));

            // Adicione um log para verificar se o ID está sendo definido corretamente
            System.out.println("ID do agendamento a ser atualizado: " + u.getId());
        } else {
            // Se o ID for nulo, imprima uma mensagem de erro
            System.out.println("ID do agendamento não foi recebido. Atualização não foi realizada.");
        }
        
        // Adicione um log para verificar se o método updateAgendamento está sendo chamado corretamente
        System.out.println("Chamando o método updateAgendamento para atualizar o agendamento com ID: " + u.getId());
        
        UsuarioDao usuarioDao = new UsuarioDao(); // Crie uma instância de UsuarioDao
        boolean sucesso = usuarioDao.updateAgendamento(u); // Chame o método updateAgendamento na instância criada

        // Converta o booleano em um valor inteiro (1 para sucesso, 0 para falha)
        int status = sucesso ? 1 : 0;

        // Após a atualização, redirecione de volta para a página consultaragenda.jsp
        response.sendRedirect("consultaragenda.jsp?atualizacaoSucesso=" + (status == 1));
    } else {
        // Se a data não pôde ser parseada, trate o erro
        // Por exemplo, exiba uma mensagem de erro para o usuário ou redirecione para uma página de erro
        System.out.println("Data não pôde ser parseada. Redirecionamento não foi executado.");
        // Adicione um redirecionamento para uma página de erro, se necessário
        // response.sendRedirect("pagina_de_erro.jsp");
    }
%>
