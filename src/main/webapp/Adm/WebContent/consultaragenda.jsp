<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usuario.Bean.Usuario, usuariodao.UsuarioDao" %>
<%@ page import="usuariodao.UsuarioDao, usuario.Bean.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Agendamento</title>
    <link rel="stylesheet" href="consultaagenda.css">
    <link rel="stylesheet" href="editaagendamento.css">
</head>
<body>

<%
    List<Usuario> list = UsuarioDao.getAllagendamento();
    request.setAttribute("list", list);
%>

<h1>Agendamento</h1>

<table class="excel-table" style="overflow-y: auto;  overflow-x: hidden;">
    <thead>
    <tr>
        <th class="text-center" style="width: 0%; font-size: 20px;">Id Agendamento</th>
        <th class="text-center" style="width: 2%; font-size: 20px;">Data/Hora Agendamento</th>
        <th class="text-center" style="width: 6%; font-size: 20px;">Especialista</th>
        <th class="text-center" style="width: 6%; font-size: 20px;">Nome Cliente</th>
        <th class="text-center" style="width: 5%; font-size: 20px;">Tipo do Serviço</th>
        <th class="text-center" style="width: 2%; font-size: 20px;">Valor do Serviço</th>
        <th class="text-center" style="width: 2%; font-size: 20px;">Celular</th>
        <th class="text-center" style="width: 1%;font-size: 20px;">Operações</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="agendamento">
    <tr>
        <td>${agendamento.getId()}</td>
        <td>
            <fmt:formatDate value="${agendamento.getData_agenda()}" pattern="dd/MM/yyyy"/> às <fmt:formatDate value="${agendamento.getData_agenda()}" pattern="HH:mm"/>
        </td>
        <td>${agendamento.getEspecialista()}</td>
        <td>${agendamento.getNome_cliente()}</td>
        <td>${agendamento.getTipo_servico()}</td>
        <td>${agendamento.getValor_servico()}</td>
        <td>${agendamento.getCelular()}</td>
        <td>
            <a href="agendamento.jsp?id=${agendamento.getId()}">
                <img src="imagens/Editar.png" class="editar" style="cursor:pointer" id="<c:out value='${agendamento.getId()}' />" title="Editar">
            </a>
            <img src="imagens/Deletar.png" class="excluir" style="cursor:pointer" id="<c:out value='${agendamento.getId()}' />" title="Excluir">
        </td>
    </tr>
</c:forEach>
    </tbody>
</table>

<%-- Verifique se houve uma atualização bem-sucedida do agendamento e exiba um alerta correspondente --%>
<%
    String atualizacaoSucesso = request.getParameter("atualizacaoSucesso");
    if (atualizacaoSucesso != null) {
        if (atualizacaoSucesso.equals("true")) {
%>
            <script>
                alert('Agendamento atualizado com sucesso!');
            </script>
<%
        } else if (atualizacaoSucesso.equals("false")) {
%>
            <script>
                alert('Falha ao atualizar o agendamento.');
            </script>
<%
        }
    }
%>




<!--------------------------------- Estrutura da janela oculta não precisa estar dentro de um formulário --------------------------------------------------->
<form action="editform.jsp" method="Post">

<div id="TopoJanela" class="TopoJanela"  ></div>
<div id="NovoAgendamento" class="Popup OcultarPopup" style="opacity: 0; z-index: -1;">

    <div class="JanelaPopup" style="width: 500px;">
            <div class="CampoForm">
               <input type="hidden" name="id" id="id" value="<%= request.getParameter("id") %>">
               
               
            </div>
        <div class="TituloPopup">
            <div id="TituloPopup">Novo Agendamento</div>
            <img src="imagens/Close.png" style="background-color: #f9f9f9;" id="BtnFecharPopup" class="BtnJanelaOper">
        </div>
        <div class="CorpoPopup" style="width: 500px;">
            <div class="CampoForm">
                <label>Data/Hora de agendamento</label>
                <input type="text" name="Data" id="Data" value="<%= request.getParameter("Data") %>">
            </div>
            <div class="CampoForm">
                <label>Especialista</label>
               <input type="text" name="Especialista" id="Especialista" value="<%= request.getParameter("Especialista") %>">
            </div>
            <div class="CampoForm">
                <label>Nome Cliente</label>
                <input type="text" name="NomeCliente" id="NomeCliente"  value="<%= request.getParameter("NomeCliente") %>">
            </div>
            <div class="CampoForm">
                <label>Tipo do Serviço</label>
                <input type="text" name="TipoServico" id="TipoServico" value="<%= request.getParameter("TipoServico") %>">
            </div>
            <div class="CampoForm">
                <label>Valor do Serviço</label>
                <input type="text" name="ValorServico" id="ValorServico" value="<%= request.getParameter("ValorServico") %>">
            </div>
            <div class="CampoForm">
                <label>Celular</label>
                <input type="text" name="Celular" id="Celular" value="<%= request.getParameter("Celular") %>">
            </div>
            <div class="RodaPePopup">
                <button  type="submit"   id="BtnSalvarPopup" class="BtnComandoPopup">Salvar</button>
                <button id="BtnCancelarPopup"  class="BtnComandoPopup">Cancelar</button>
            </div>
        </div>
    </div>
</div>
</form>
<!--------------------------- ESTRUTURA JAVASCRIPT PARA ADICIONAR O SCRIPT PARA CHAMAR A FUNÇÃO ADICIONAR EVENTOSEDITAR() --------------------------------->

<script>
    function adicionarEventosEditar() {
        const iconesEditar = document.querySelectorAll('.editar');

        iconesEditar.forEach(icone => {
            icone.addEventListener('click', function () {
                if (confirm('Deseja realmente editar os dados?')) {
                    const idEspecialista = icone.getAttribute('id');
                    const data_agendamento = icone.parentElement.parentElement.querySelector('td:nth-child(2)').textContent.trim();
                    const especialista = icone.parentElement.parentElement.querySelector('td:nth-child(3)').textContent.trim();
                    const nome_cliente = icone.parentElement.parentElement.querySelector('td:nth-child(4)').textContent.trim();
                    const tipo_servico = icone.parentElement.parentElement.querySelector('td:nth-child(5)').textContent.trim();
                    const valor_servico = icone.parentElement.parentElement.querySelector('td:nth-child(6)').textContent.trim();
                    const celular = icone.parentElement.parentElement.querySelector('td:nth-child(7)').textContent.trim();
					
                    document.getElementById("Especialista").value = idEspecialista;
					document.getElementById("id").value = idEspecialista;
                    document.getElementById("Data").value = data_agendamento;
                    document.getElementById("Especialista").value = especialista;
                    document.getElementById("NomeCliente").value = nome_cliente;
                    document.getElementById("TipoServico").value = tipo_servico;
                    document.getElementById("ValorServico").value = valor_servico;
                    document.getElementById("Celular").value = celular;

                    const NovoAgendamento = document.getElementById("NovoAgendamento");
                    NovoAgendamento.style.opacity = "1";
                    NovoAgendamento.style.zIndex = "1";
                    NovoAgendamento.classList.remove("OcultarPopup");
                    document.getElementById("TituloPopup").innerHTML = "Editar Agendamento";

                    const BtnSalvarPopup = document.getElementById("BtnSalvarPopup");
                    // Adicionando o idEspecialista como um atributo data-
                    document.getElementById("Especialista").setAttribute('idEspecialista', idEspecialista);
                }
            });
        });
    }

    function editarAgendamento(idEspecialista) {
        const NovoAgendamento = document.getElementById("NovoAgendamento");
        if (NovoAgendamento) {
            NovoAgendamento.style.opacity = "1";
            NovoAgendamento.style.zIndex = "1";
            NovoAgendamento.classList.remove("OcultarPopup");

            const BtnSalvarPopup = document.getElementById("BtnSalvarPopup");
            BtnSalvarPopup.addEventListener("click", function () {
                atualizarAgendamento(idEspecialista);
            });
        }
    }

    
   
    // Defina a função atualizarAgendamento() no escopo global
    function atualizarAgendamento(idEspecialista) {
        const alerta = document.createElement('div');
        alerta.textContent = 'Agendamento atualizado com sucesso!';
        alerta.classList.add('alerta');
        document.body.appendChild(alerta);

        setTimeout(function() {
            alerta.remove();
        }, 3000);
    }




    // Chame a função para adicionar eventos aos novos elementos
    adicionarEventosEditar();

    // Adicione a funcionalidade aos botões BtnFecharPopup e BtnCancelarPopup
    document.getElementById("BtnFecharPopup").addEventListener("click", function() {
        const NovoAgendamento = document.getElementById("NovoAgendamento");
        NovoAgendamento.style.opacity = "0";
        NovoAgendamento.style.zIndex = "-1";
        NovoAgendamento.classList.add("OcultarPopup");
    });

    document.getElementById("BtnCancelarPopup").addEventListener("click", function() {
        const NovoAgendamento = document.getElementById("NovoAgendamento");
        NovoAgendamento.style.opacity = "0";
        NovoAgendamento.style.zIndex = "-1";
        NovoAgendamento.classList.add("OcultarPopup");
    });

    // Ocultar a janela de edição quando a página terminar de carregar
    window.onload = function() {
        const NovoAgendamento = document.getElementById("NovoAgendamento");
        NovoAgendamento.style.opacity = "0";
        NovoAgendamento.style.zIndex = "-1";
        NovoAgendamento.classList.add("OcultarPopup");
    };
    
    
 // Função para adicionar eventos de excluir aos ícones
    function adicionarEventosExcluir() {
        const iconesExcluir = document.querySelectorAll('.excluir');
        iconesExcluir.forEach(icone => {
            icone.addEventListener('click', function() {
                if (confirm('Deseja realmente excluir o agendamento?')) {
                    const idAgendamento = icone.getAttribute('id');
                    window.location.href = 'delete.jsp?id=' + idAgendamento; // Redirecionar para a página de exclusão
                }
            });
        });
    }

    // Chame a função para adicionar eventos aos novos elementos
    adicionarEventosExcluir();
    

</script>
</body>
</html>
