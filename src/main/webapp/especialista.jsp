<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="Imagens">
    <link rel="stylesheet" href="especia.css">
    <title>Especialista - Detalhes do Agendamento</title>
</head>
<body>
<header>
    <div class="logo">
        <div class="imgLogo">
            <img src="imagens/Logo.png" style="width: 300px; height: 200px;" alt="Logo da Barbearia">
        </div>
    </div>
</header>
<main>
    <div class="Detalhes"></div>
    <!-- Seção para exibir detalhes do agendamento -->
    <section class="data-hora">
        <span id="data-hora"></span>
    </section>
    
    <section class="especialistas">
        <h2>Escolha um especialista</h2>
        <ul>
            <li class="especialista-item">
                <div class="foto">
                    <img src="imagens/homerimg.png" alt="Foto do Especialista 1" style="width: 100px; height: 110px;">
                </div>
                <div class="info">
                    <h2>Hommer</h2>
                    <button class="botao-agendar" style="cursor: pointer;" onclick="abrirEspecialista('Hommer')">Agendar</button>
                </div>
            </li>
            <li class="especialista-item">
                <div class="foto">
                    <img src="imagens/SeuMadruga.jpeg" alt="Foto do Especialista 2" style="width: 150px; height: 150px;">
                </div>
                <div class="info">
                    <h2>Seu Madruga</h2>
                    <button class="botao-agendar" style="cursor: pointer;" onclick="abrirEspecialista('Seu Madruga')">Agendar</button>
                </div>
            </li>
        </ul>
    </section>

    <div id="detalhesEInputs" class="detalhes" style="text-align: center; margin-left: 800px; padding: 0px;">
        <form id="agendamentoForm" accept-charset="UTF-8" method="post">
    <% 
        request.setCharacterEncoding("UTF-8"); 
        
        String detalhes = request.getParameter("detalhes");
        String especialista = request.getParameter("especialista");
        String nomeCliente = request.getParameter("nome_cliente");
        String celularCliente = request.getParameter("celular_cliente");
                    
        String[] linhasDetalhes = null;
        
        if (detalhes != null) {
            linhasDetalhes = detalhes.split("<br>");
        }

        if (linhasDetalhes != null) {
            for (int i = 0; i < linhasDetalhes.length - 4; i++) {
                out.println("<p>" + linhasDetalhes[i] + "</p><br>");
            }
        }

        out.println("<p id='especialistaEscolhido'>Especialista escolhido: " + (especialista != null ? especialista : "") + "</p><br>");
        out.println("<p id='nomeDoCliente'>Nome do cliente: " + (nomeCliente != null ? nomeCliente : "") + "</p><br>");
        if (linhasDetalhes != null && linhasDetalhes.length >= 4) {
            out.println("<p>" + linhasDetalhes[linhasDetalhes.length - 4] + "</p><br>");
        }
        if (linhasDetalhes != null && linhasDetalhes.length >= 3) {
            out.println("<p>" + linhasDetalhes[linhasDetalhes.length - 3] + "</p><br>");
        }
        if (linhasDetalhes != null && linhasDetalhes.length >= 2) {
            out.println("<p>" + linhasDetalhes[linhasDetalhes.length - 2] + "</p>");
        }

        out.println("<p id='celularDoCliente'>Celular do cliente: " + (celularCliente != null ? celularCliente : "") + "</p>");
    %>        
           
        <div class="CampoForm" style="display: none;">
        	<input type="text" name="Data" id="Data" placeholder="dd/mm/aaaa" value="<%= linhasDetalhes != null ? linhasDetalhes[0].substring(linhasDetalhes[0].indexOf(':') + 2) : "" %>"> 
        	
            <div>
                <input type="text" name="Especialista" id="Especialista" value="<%= especialista %>">
            </div>
            <div>
                <input type="text" name="NomeCliente" id="NomeCliente" value="<%= nomeCliente %>">
            </div>
            <div>
                <input type="text" name="TipoServico" id="TipoServico" value="<%= linhasDetalhes != null ? linhasDetalhes[linhasDetalhes.length - 4] : "" %>">
            </div>
            <div> 
                <input type="text" name="ValorServico" id="ValorServico" value="<%= linhasDetalhes != null ? linhasDetalhes[linhasDetalhes.length - 3] : "" %>">
            </div>
            <div> 
                <input type="text" name="Celular" id="Celular" value="<%= celularCliente %>">
            </div>
        </div>

        <div style="display: flex; justify-content: space-between;">
            <!-- Confirmação do agendamento -->
            <a href="javascript:void(0);" onclick="realizarAgendamento()" style="text-decoration: none;">
                <div style="text-align: center;">
                    <img src="imagens/ConfimarAgendamento.png" style="width: 50px; height: 50px; margin-left: 6vw;">
                    <p style="margin: 0; color: black; margin-left: 6vw">Confirmar Agendamento</p>
                </div>
            </a>

            
        </div>
        
    </form>
    </div>

    <div>
        <!-- CAMPOS PARA O NOME E CELULAR -->
        <label for="inputNome">Nome:</label>
        <input type="text" class="inputNome" style="width: 300px; height: 35px; font-size: 25px;" placeholder="Digite seu nome" id="inputNome" name="inputNome" value="<%= nomeCliente != null ? nomeCliente : "" %>" ><br><br>
        
        <label for="inputCelular">Celular:</label>
        <input type="text" class="inputCelular" style="width: 300px; height: 35px; font-size: 25px;" placeholder="Digite seu celular"  id="inputCelular" name="inputCelular" value="<%= celularCliente != null ? celularCliente : "" %>"  >
    </div> 
</main>   

<script>
function extrairDataEHora() {
    let texto = document.getElementById('Data').value;
    console.log("Texto:", texto);

    // Remover a string "às" do texto, se presente
    texto = texto.replace("às", "").trim();

    // Remover o ponto após o "h", se presente
    texto = texto.replace("h.", "h").trim();

    // Retorna o texto modificado
    return texto;
}

// Exemplo de uso da função
let resultado = extrairDataEHora();
console.log("Resultado:", resultado);

// Definir o texto modificado no valor do input
document.getElementById('Data').value = resultado;

function realizarAgendamento() {
    var form = document.getElementById('agendamentoForm');
    var nome = document.getElementById('inputNome').value.trim();
    var celular = document.getElementById('inputCelular').value.trim();
    var especialistaEscolhido = document.getElementById('especialistaEscolhido').innerText.trim().split(': ')[1];
    var nomeDoCliente = document.getElementById('nomeDoCliente').innerText.trim().split(': ')[1];
    var celularDoCliente = document.getElementById('celularDoCliente').innerText.trim().split(': ')[1];

    if (!nome || !celular || !especialistaEscolhido || !nomeDoCliente || !celularDoCliente) {
        alert('Existem campos vazios, favor preencher os campos Nome e Celular ou Especialista.');
        return;
    }

    alert('Agendamento feito com sucesso!');
    // Enviar para cadastro.jsp
    form.action = 'cadastro.jsp';
    form.target = 'cadastroFrame';
    form.submit();

    // Depois de enviar para cadastro.jsp, enviar para agendamento.jsp
    setTimeout(function() {
        form.action = 'agendamento.jsp';
        form.target = '';
        form.submit();
    }, 200); // tempo de espera reduzido para 200 milissegundos
}

function abrirEspecialista(especialista) {
    var inputNome = document.getElementById('inputNome').value;
    var inputCelular = document.getElementById('inputCelular').value;

    // Limpar os inputs de nome e celular
    document.getElementById('inputNome').value = '';
    document.getElementById('inputCelular').value = '';

    var detalhes = '<%= request.getParameter("detalhes") != null ? request.getParameter("detalhes").replaceAll("\n", "") : "" %>';

    var form = document.createElement('form');
    form.method = 'POST';
    form.action = 'especialista.jsp';

    var inputDetalhes = document.createElement('input');
    inputDetalhes.type = 'hidden';
    inputDetalhes.name = 'detalhes';
    inputDetalhes.value = detalhes;
    form.appendChild(inputDetalhes);

    var inputEspecialista = document.createElement('input');
    inputEspecialista.type = 'hidden';
    inputEspecialista.name = 'especialista';
    inputEspecialista.value = especialista;
    form.appendChild(inputEspecialista);

    var inputNomeCliente = document.createElement('input');
    inputNomeCliente.type = 'hidden';
    inputNomeCliente.name = 'nome_cliente';
    inputNomeCliente.value = inputNome;
    form.appendChild(inputNomeCliente);

    var inputCelularCliente = document.createElement('input');
    inputCelularCliente.type = 'hidden';
    inputCelularCliente.name = 'celular_cliente';
    inputCelularCliente.value = inputCelular;
    form.appendChild(inputCelularCliente);

    document.body.appendChild(form);
    form.submit();
}



</script>



<!-- Adiciona um iframe invisível para envio do cadastro sem mudar a página -->
<iframe name="cadastroFrame" style="display:none;"></iframe>

</body>
</html>
