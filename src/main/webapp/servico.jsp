<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VB Barber Shop</title>
    <link rel="stylesheet" href="servico.css">
</head>
<body>
<div class="container">
    <div class="header">
        <div class="logo">
            <img src="imagens/ImagemBarber.png" alt="Logo da Barbearia" style=" margin-left: -2vw; width: 98vw; height: 40vw; margin-top: 7vw;">
        </div>
        <div class="menu"></div>
    </div>
    <div class="main">
        <img src="imagens/Logo.png" alt="Logo da Barbearia" style="text-align: center; margin-left: 900px; width: 350px; height: 300px; margin-top: -5vw;">
    </div>
    <div class="informacoes-servico">
        <p>Selecione os serviços</p>
        <ul class="lista-servicos">
            <li>
                <input type="checkbox" id="corte" name="servicos" descricao="Corte R$35,00" onchange="atualizarValorTotal(this)">
                <label for="corte">Corte</label>
                <span class="preco">R$ 35</span>
            </li>
            <li>
                <input type="checkbox" id="barba" name="servicos" descricao="Barba R$35,00" onchange="atualizarValorTotal(this)">
                <label for="barba">Barba</label>
                <span class="preco">R$ 35</span>
            </li>
            <li>
                <input type="checkbox" id="corte-barba" name="servicos" descricao="Corte-barba R$60,00" onchange="atualizarValorTotal(this)">
                <label for="corte-barba">Corte e Barba</label>
                <span class="preco">R$ 60</span>
            </li>
            <li>
                <input type="checkbox" id="novo-servico" name="servicos" descricao="Novo R$35,00">
                <label for="novo-servico">Novo Serviço</label>
                <span class="preco">R$ 50</span>
            </li>
        </ul>
        <div id="servicosAgendados">
            <p id="detalhesAgendamento">
                <%-- Lógica para pegar os parâmetros e formatar a data --%>
                <%
                    String data = request.getParameter("data");
                    String hora = request.getParameter("hora");

                    if (data != null && hora != null && !data.isEmpty() && !hora.isEmpty()) {
                        try {
                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Date date = dateFormat.parse(data);

                            SimpleDateFormat outputDateFormat = new SimpleDateFormat("dd/MM/yyyy");
                            String formattedDate = outputDateFormat.format(date);
                %>
                            Agendado para o dia: <%= formattedDate %> às <%= hora %>.
                <%
                        } catch (Exception e) {
                            out.println("Data inválida: " + e.getMessage());
                        }
                    } else {
                        out.println("Parâmetros de data e hora não foram fornecidos.");
                    }
                %>
            </p>
        </div>
        <div class="total">
            <span id="valorTotalSpan" class="valor">R$ 0</span>
        </div>
        <div class="botoes">
            <button class="BtnEspecialista" onclick="abrirEspecialista()">Escolher Especialista</button>
        </div>
    </div>
</div>

<script>
function atualizarValorTotal(checkbox) {
    var valorTotal = 0;
    var checkboxes = document.querySelectorAll('input[name="servicos"]:checked');
    checkboxes.forEach(function(checkbox) {
        if (checkbox.id === 'corte') {
            valorTotal += 35;
        } else if (checkbox.id === 'barba') {
            valorTotal += 35;
        } else if (checkbox.id === 'corte-barba') {
            valorTotal += 60;
        } else if (checkbox.id === 'novo-servico') {
            valorTotal += 50;
        }
    });
    document.getElementById('valorTotalSpan').innerText = 'R$ ' + valorTotal;
}

function abrirEspecialista() {
    var detalhes = "";
    var servicosSelecionados = "";

    detalhes += document.getElementById("detalhesAgendamento").innerHTML;
    detalhes += "<br>";
    
    var servicos = document.getElementsByName("servicos");
    for (i = 0; i < servicos.length; i++) {
        if (servicos[i].checked) {
            servicosSelecionados += servicos[i].nextElementSibling.textContent + "<br>";
            servicosSelecionados += servicos[i].getAttribute("descricao") + "<br>";
        }
    }

    detalhes += servicosSelecionados;
    detalhes += "<br>";
    var valorTotal = document.getElementById("valorTotalSpan").innerText;
    detalhes += valorTotal;

    document.location.href = "especialista.jsp?detalhes=" + encodeURIComponent(detalhes);
}
</script>
</body>
</html>
