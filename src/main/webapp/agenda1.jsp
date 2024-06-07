<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usuario.Bean.Usuario, usuariodao.UsuarioDao" %>
<%@ page import="usuariodao.UsuarioDao, usuario.Bean.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8"> <!-- Define a codificação de caracteres do documento -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Define como o documento deve ser exibido em dispositivos móveis -->
    <title>Calendário Interativo</title> <!-- Título da página -->
    <link rel="stylesheet" href="agend.css"> <!-- Link para o arquivo CSS -->
</head>
<body>
    <div id="container" >
        <div id="header" >
            <div  id="monthDisplay" style="width: -1vw;"></div> <!-- Exibe o mês atual -->
            <div>
                <button id="backButton">Voltar</button> <!-- Botão para voltar ao mês anterior -->
                <button id="nextButton">Próximo</button> <!-- Botão para avançar para o próximo mês -->
            </div>
        </div>
        <div class="weekdays" style="width: 41vw; font-size: -1vw; color: white; margin-left: -1vw; height: 2vw; align-items: center; " id="weekdays"> <!-- Dias da semana -->
            <div><h4>Domingo</h4></div>
            <div><h4>Segunda-feira</h4></div>
            <div><h4>Terça-feira</h4></div>
            <div><h4>Quarta-feira</h4></div>
            <div><h4>Quinta-feira</h4></div>
            <div><h4>Sexta-feira</h4></div>
            <div><h4>Sábado</h4></div>
		
        </div>
        <div id="calendar" style="margin-left: -1vw;"></div> <!-- Calendário onde os dias serão exibidos -->
    </div>

    <!-- Modal para novo agendamento -->
    <div id="newEventModal">
        <h2>Novo Agendamento</h2>
        <div class="container">
            <div class="dia"></div>
            <div class="horas">
                <!-- Seção de horários disponíveis -->
                <div class="Header" style="text-align: center">
                    <h3>Manhã</h3>
                    <button id="08_00" class="hora" onclick="mostrarDetalhes(this)">08:00h</button>
                    <button id="08_30" class="hora" onclick="mostrarDetalhes(this)">08:30h</button>
                    <button id="09_00" class="hora" onclick="mostrarDetalhes(this)">09:00h</button>
                    <button id="09_30" class="hora" onclick="mostrarDetalhes(this)">09:30h</button>
                    <button id="10_00" class="hora" onclick="mostrarDetalhes(this)">10:00h</button>
                    <button id="10_30" class="hora" onclick="mostrarDetalhes(this)">10:30h</button>
                    <button id="11_00" class="hora" onclick="mostrarDetalhes(this)">11:00h</button>
                    <button id="11_30" class="hora" onclick="mostrarDetalhes(this)">11:30h</button>
                </div>
                <div class="Header" style="text-align: center">
                    <h3>Tarde</h3>
                    <button id="12_00" class="hora" onclick="mostrarDetalhes(this)">12:00h</button>
                    <button id="13_00" class="hora" onclick="mostrarDetalhes(this)">13:00h</button>
                    <button id="13_30" class="hora" onclick="mostrarDetalhes(this)">13:30h</button>
                    <button id="14_00" class="hora" onclick="mostrarDetalhes(this)">14:00h</button>
                    <button id="14_30" class="hora" onclick="mostrarDetalhes(this)">14:30h</button>
                    <button id="15_00" class="hora" onclick="mostrarDetalhes(this)">15:00h</button>
                    <button id="15_30" class="hora" onclick="mostrarDetalhes(this)">15:30h</button>
                    <button id="16_00" class="hora" onclick="mostrarDetalhes(this)">16:00h</button>
                    <button id="16_30" class="hora" onclick="mostrarDetalhes(this)">16:30h</button>
                    <button id="17_00" class="hora" onclick="mostrarDetalhes(this)">17:00h</button>
                    <button id="17_30" class="hora" onclick="mostrarDetalhes(this)">17:30h</button>
                </div>
                <div class="Header" style="text-align: center">
                    <h3>Noite</h3>
                    <button id="18_00" class="hora" onclick="mostrarDetalhes(this)">18h</button>
                    <button id="19_00" class="hora" onclick="mostrarDetalhes(this)">19h</button>
                    <button id="20_00" class="hora" onclick="mostrarDetalhes(this)">20h</button>
                </div>
            </div>
            <div class="detalhes-hora" hidden="" id="detalhes-hora">
                <p>Hora marcada às ...</p>
            </div>
        </div>
        <button class="saveButton" id="saveButton" onclick="selecionarServico()">Selecione o serviço</button>
        <button class="cancelaButton" id="cancelButton" onclick="closeModal()">Cancelar</button>
    </div>

    <!-- Modal para deletar evento -->
    <div id="deleteEventModal">
        <h2>Evento</h2>
        <div id="eventText"></div>
    </div>
    
    

    <div id="modalBackDrop"></div>
    
    <!-- Recupera a lista de agendamentos do banco de dados -->
    <%
        List<Usuario> list = UsuarioDao.getAllagendamento();
        
        SimpleDateFormat formatador = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // Formata a data para yyyy-MM-dd HH:mm
        SimpleDateFormat formatadorHora = new SimpleDateFormat("HH_mm"); // Formata a hora para HH_mm
        out.print("<script>");
        
        for (Usuario usuario : list) {
            String formattedDate = formatador.format(usuario.getData_agenda());
            String formattedHour = formatadorHora.format(usuario.getData_agenda());
            out.print("var agendamento_" + formattedHour + " = { date: '" + formattedDate.split(" ")[0] + "', hour: '" + formattedHour + "' };"); // Cria um objeto para cada agendamento
        }
        
        out.print("</script>");
    %>

    <script>
        let nav = 0; // Variável para navegação entre meses
        let clicked = null; // Armazena a data clicada
        let events = localStorage.getItem('events') ? JSON.parse(localStorage.getItem('events')) : []; // Recupera eventos do localStorage
        const newEvent = document.getElementById('newEventModal'); // Modal para novo agendamento
        const deleteEventModal = document.getElementById('deleteEventModal'); // Modal para deletar evento
        const backDrop = document.getElementById('modalBackDrop'); // Fundo do modal
        const eventTitleInput = document.getElementById('eventTitleInput'); // Input para título do evento
        const calendar = document.getElementById('calendar'); // Elemento do calendário
        const weekdays = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado']; // Dias da semana

        function openModal(date) {
            const today = new Date(); // Obtém a data atual
            const selectedDate = new Date(date); // Converte a data clicada para um objeto Date

            // Define a data de ontem
            const yesterday = new Date();
            yesterday.setDate(today.getDate() - 1);

            // Verifica se a data clicada é anterior a ontem
            if (selectedDate < yesterday.setHours(0, 0, 0, 0)) {
                alert('Agendamento não disponível para esse dia.'); // Exibe um alerta
                return; // Interrompe a função se a data for anterior a ontem
            }

            clicked = date; // Define a data clicada
            const eventDay = events.find((event) => event.date === clicked); // Procura o evento no dia clicado

            if (eventDay) { // Se há evento no dia clicado
                document.getElementById('eventText').innerText = eventDay.title; // Exibe o título do evento
                deleteEventModal.style.display = 'block'; // Exibe o modal de deletar evento
            } else { // Se não há evento no dia clicado
                newEvent.style.display = 'block'; // Exibe o modal de novo agendamento
            }

            const allDays = document.querySelectorAll('.day'); // Seleciona todos os elementos de dia
            allDays.forEach(day => {
                day.removeAttribute('id'); // Remove o atributo id de todos os dias
            });

            const selectedDay = document.querySelector(`.day[data-date="${clicked}"]`); // Seleciona o dia clicado
            if (selectedDay) {
                selectedDay.id = 'currentDay'; // Define o id do dia clicado como currentDay
            }

            backDrop.style.display = 'block'; // Exibe o fundo do modal

            // Redefine a visibilidade dos horários
            document.querySelectorAll('.hora').forEach(button => {
                button.style.display = 'inline-block'; // Torna todos os botões de hora visíveis
            });

            // Ocultar horários já agendados para o dia selecionado
            const dateStr = clicked;
            <% for (Usuario usuario : list) {
                String formattedDate = formatador.format(usuario.getData_agenda());
                String formattedHour = formatadorHora.format(usuario.getData_agenda());
                out.print("if(dateStr === '" + formattedDate.split(" ")[0] + "') {"); // Se a data do agendamento coincide com a data clicada
                out.print("document.getElementById('" + formattedHour + "').style.display = 'none';"); // Oculta o botão do horário agendado
                out.print("}");
            } %>
        }


        function formatNumber(number) { // Formata número para dois dígitos
            return number < 10 ? '0' + number : number.toString();
        }

        function load() { // Carrega o calendário
            const date = new Date();

            if (nav !== 0) {
                date.setMonth(new Date().getMonth() + nav); // Ajusta o mês de acordo com a navegação
            }

            const day = date.getDate();
            const month = date.getMonth();
            const year = date.getFullYear();

            const daysMonth = new Date(year, month + 1, 0).getDate(); // Número de dias no mês
            const firstDayMonth = new Date(year, month, 1); // Primeiro dia do mês

            const dateString = firstDayMonth.toLocaleDateString('pt-br', {
                weekday: 'long',
                year: 'numeric',
                month: 'numeric',
                day: 'numeric',
            });

            const paddinDays = weekdays.indexOf(dateString.split(', ')[0]); // Dias de preenchimento antes do primeiro dia do mês

            const monthYearString = date.toLocaleDateString('pt-br', { month: 'long', year: 'numeric' });
            const capitalizedMonth = monthYearString.charAt(0).toUpperCase() + monthYearString.slice(1); // Capitaliza o nome do mês
            document.getElementById('monthDisplay').innerText = capitalizedMonth; // Exibe o mês e ano atual

            calendar.innerHTML = ''; // Limpa o calendário

            for (let i = 1; i <= paddinDays + daysMonth; i++) {
                const dayS = document.createElement('div');
                dayS.classList.add('day'); // Cria elementos de dia no calendário

                if (i > paddinDays) {
                    const yearStr = year.toString();
                    const monthStr = formatNumber(month + 1);
                    const dayStr = formatNumber(i - paddinDays);
                    const dayString = yearStr + '-' + monthStr + '-' + dayStr;

                    dayS.innerText = i - paddinDays; // Define o texto do dia
                    dayS.setAttribute('data-date', dayString); // Define o atributo data-date para o dia

                    const eventDay = events.find(event => event.date === dayString); // Procura evento no dia

                    if (i - paddinDays === day && nav === 0) {
                        dayS.id = 'currentDay'; // Define o dia atual
                    }

                    if (eventDay) {
                        const eventDiv = document.createElement('div');
                        eventDiv.classList.add('event');
                        eventDiv.innerText = eventDay.title; // Exibe o título do evento no dia
                        dayS.appendChild(eventDiv);
                    }

                    dayS.addEventListener('click', () => openModal(dayString)); // Adiciona evento de clique ao dia
                } else {
                    dayS.classList.add('padding'); // Adiciona preenchimento para dias do mês anterior
                }

                calendar.appendChild(dayS); // Adiciona o dia ao calendário
            }
        }

        function closeModal() { // Fecha o modal
            const eventTitleInput = document.getElementById('eventTitleInput');
            if (eventTitleInput) {
                eventTitleInput.classList.remove('error');
                eventTitleInput.value = ''; // Limpa o input do título do evento
            }
            if (newEvent) newEvent.style.display = 'none';
            if (backDrop) backDrop.style.display = 'none';
            if (deleteEventModal) deleteEventModal.style.display = 'none';
            clicked = null;
            load(); // Recarrega o calendário
        }

        function buttons() { // Adiciona eventos aos botões
            document.getElementById('saveButton').addEventListener('click', () => saveEvent());
            document.getElementById('cancelButton').addEventListener('click', () => closeModal());
            document.getElementById('backButton').addEventListener('click', () => {
                nav--;
                load();
            });
            document.getElementById('nextButton').addEventListener('click', () => {
                nav++;
                load();
            });
        }

        buttons(); // Chama a função para adicionar eventos aos botões
        load(); // Carrega o calendário

        let selectedDate = null;
        let selectedTime = null;

        function mostrarDetalhes(hora) { // Mostra detalhes do agendamento
            const detalhesHora = document.getElementById("detalhes-hora");
            detalhesHora.style.display = "block"; // Exibe os detalhes do horário

            // Armazena os detalhes do agendamento
            selectedDate = clicked;
            selectedTime = hora.textContent;

            console.log("Selected Date: ", selectedDate);
            console.log("Selected Time: ", selectedTime);

            // Exibe os detalhes do agendamento
            const conteudoDinamico = detalhesHora.querySelector("p");
            conteudoDinamico.textContent = "Hora marcada às " + hora.textContent;
        }

        function selecionarServico() { // Seleciona o serviço e envia o formulário
            if (selectedDate && selectedTime) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'servico.jsp';

                const dataInput = document.createElement('input');
                dataInput.type = 'hidden';
                dataInput.name = 'data';
                dataInput.value = selectedDate; // Define a data selecionada
                form.appendChild(dataInput);

                const horaInput = document.createElement('input');
                horaInput.type = 'hidden';
                horaInput.name = 'hora';
                horaInput.value = selectedTime; // Define a hora selecionada
                form.appendChild(horaInput);

                document.body.appendChild(form);
                form.submit(); // Envia o formulário
            } else {
                console.error('Nenhum horário foi selecionado.');
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() { // Função para buscar agendamentos e atualizar a interface
            function buscarAgendamentos() {
                const xhr = new XMLHttpRequest();
                xhr.open('GET', 'consultaragenda.jsp', true); // Requisição para consultar agendamentos
                xhr.onload = function() {
                    if (this.status === 200) {
                        const agendamentos = JSON.parse(this.responseText);
                        desabilitarHorariosAgendados(agendamentos); // Desabilita horários agendados
                    }
                };
                xhr.send();
            }

            function desabilitarHorariosAgendados(agendamentos) { // Função para desabilitar os botões de horário já agendados
                agendamentos.forEach(agendamento => {
                    const date = new Date(agendamento.data_agenda); // Converte a data do agendamento para um objeto Date
                    const dateString = date.toISOString().split('T')[0]; // Formata a data para yyyy-MM-dd
                    if (dateString === clicked) { // Verifica se a data do agendamento coincide com a data clicada
                        const hours = String(date.getHours()).padStart(2, '0'); // Formata a hora para dois dígitos
                        const minutes = String(date.getMinutes()).padStart(2, '0'); // Formata os minutos para dois dígitos
                        const horarioId = `${hours}_${minutes}`; // Cria o id do horário
                        const horarioBtn = document.getElementById(horarioId); // Seleciona o botão do horário
                        if (horarioBtn) {
                            horarioBtn.style.display = 'none'; // Oculta o botão de horário já agendado
                        }
                    }
                });
            }

            buscarAgendamentos(); // Inicia a busca dos agendamentos
        });
    </script>
</body>
</html>
