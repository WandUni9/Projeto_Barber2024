<%@ page import="usuariodao.UsuarioDao" %>
<jsp:useBean id="u" class="usuario.Bean.Usuario"></jsp:useBean>
<jsp:setProperty property="*" name="u"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Obtém a data e hora do formulário e converte para o formato adequado (dd/MM/yyyy HH:mm)
    String dataHoraAgendamentoStr = request.getParameter("Data");
    out.println("Data e hora fornecidas pelo formulário: " + dataHoraAgendamentoStr); // Adicione esta linha para depuração

    // Tentar analisar a data e hora com dois formatos diferentes
    java.util.Date dataHoraAgendamentoUtil = null;
    java.text.SimpleDateFormat dateFormatWithColon = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
    java.text.SimpleDateFormat dateFormatWithLetterH = new java.text.SimpleDateFormat("dd/MM/yyyy HH'h'");

    try {
        // Tenta analisar a data e hora com o formato "dd/MM/yyyy HH:mm"
        dataHoraAgendamentoUtil = dateFormatWithColon.parse(dataHoraAgendamentoStr);
    } catch (java.text.ParseException e) {
        try {
            // Se a primeira tentativa falhar, tenta analisar com o formato "dd/MM/yyyy HH'h'"
            dataHoraAgendamentoUtil = dateFormatWithLetterH.parse(dataHoraAgendamentoStr);
        } catch (java.text.ParseException ex) {
            // Ambas as tentativas falharam, trate o erro aqui
            ex.printStackTrace();
        }
    }

    // Verifique se dataHoraAgendamentoUtil não é nula antes de usá-la
    if (dataHoraAgendamentoUtil != null) {
        java.sql.Timestamp dataHoraAgendamento = new java.sql.Timestamp(dataHoraAgendamentoUtil.getTime());

        // Define os atributos do objeto Usuario
        u.setData_agenda(dataHoraAgendamento);
        u.setEspecialista(request.getParameter("Especialista"));
        u.setNome_cliente(request.getParameter("NomeCliente"));
        u.setTipo_servico(request.getParameter("TipoServico"));
        u.setValor_servico(request.getParameter("ValorServico"));
        u.setCelular(request.getParameter("Celular"));
        
        int i = UsuarioDao.salvarUsuario(u);

        if (i > 0) {
            response.sendRedirect("agendamento.jsp");
        } else {
            out.println("Erro ao salvar o usuário. Por favor, tente novamente.");
        }
    } else {
        out.println("Formato de data inválido. Por favor, forneça uma data no formato dd/MM/yyyy HH:mm ou dd/MM/yyyy HH'h'.");
    }
%>
