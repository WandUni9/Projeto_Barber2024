<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="usuario.Bean.Usuario, usuariodao.UsuarioDao" %>
<%@ page import="usuariodao.UsuarioDao, usuario.Bean.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    List<Usuario> list = UsuarioDao.getAllagendamento();
    request.setAttribute("list", list);
    String idAgendamento = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Detalhes do Agendamento</title>
    <link rel="stylesheet" href="agendamento.css">
</head>
<body>
    <div class="container">
    	<h1>SEU AGENDAMENTO</h1>
        <p><strong>Data:</strong> <%= new String(request.getParameter("Data").getBytes("ISO-8859-1"), "UTF-8") %></p>
        <p><strong>Especialista:</strong> <%= new String(request.getParameter("Especialista").getBytes("ISO-8859-1"), "UTF-8") %></p>
        <p><strong>Nome do Cliente:</strong> <%= new String(request.getParameter("NomeCliente").getBytes("ISO-8859-1"), "UTF-8") %></p>
        <p><strong>Tipo de Serviço:</strong> <%= new String(request.getParameter("TipoServico").getBytes("ISO-8859-1"), "UTF-8") %></p>
        <p><strong>Valor do Serviço:</strong> <%= new String(request.getParameter("ValorServico").getBytes("ISO-8859-1"), "UTF-8") %></p>
        <p><strong>Celular:</strong> <%= new String(request.getParameter("Celular").getBytes("ISO-8859-1"), "UTF-8") %></p>
        <h4>SE DESEJAR FAZER ALGUMA ALTERAÇÃO NO SEU AGENDAMENTO. EXCLUA SUA AGENDA ATUAL, E FAÇA UM REAGENDAMENTO.</h4>
        <div style="text-align: center;">
	        <a href="javascript:void(0);" onclick="excluir-agendamento()" style="text-decoration: none;">
	        <img src="imagens/ExcluirAgendamento.png" style="width: 50px; height: 50px;">
	        <p style="margin: 0; color: black;" >Cancelar Agendamento</p>
         	</a>
    	</div>
    </div>
    
    	<script>
            
         // Adiciona um evento de clique ao ícone de exclusão
            document.querySelector('.excluir-agendamento').addEventListener('click', function() {
                // Confirmação para excluir o agendamento
                if (confirm('Deseja realmente excluir o agendamento?')) {
                    // Obtém o ID do agendamento que será excluído
                    var idAgendamento = ""; // Adicione o código para obter o ID do agendamento aqui

                    // Envia uma solicitação para excluir o agendamento
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (this.readyState == 4 && this.status == 200) {
                            // Verifica se a exclusão foi bem-sucedida
                            if (this.responseText === "success") {
                                // Recarrega a página para atualizar os dados
                                location.reload();
                            } else {
                                // Exibe uma mensagem de erro
                                alert('Falha ao excluir o agendamento.');
                            }
                        }
                    };
                    xhttp.open("GET", "excluirAgendamento.jsp?id=" + idAgendamento, true);
                    xhttp.send();
                }
            });
            
            </script>
</body>
</html>


