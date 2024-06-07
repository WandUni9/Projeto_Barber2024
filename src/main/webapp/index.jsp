<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Agendamento</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <div id="topo" class="topo">
        <div class="topo-content">
            <div class="logo-container">
                <img src="imagens/Logo.png" class="logo logo-sobreposta">
            </div>
            <div class="info-container">
                <h2>Barbearia UniBarber</h2>
                <p>"Seu estilo, nossa paixão!"</p>
            </div>
            <div class="contact-container">
                <p>
                    <img src="imagens/Whats.png" alt="WhatsApp" class="ImagemWhats"> Whats: (11) 99999 - 9999
                </p>
                <p>
                    <img src="imagens/Instagram.png" alt="Instagram" class="ImagemInstagram"> Instagram: @UniBarber
                </p>
                <p class="operating-hours">Horário de Funcionamento: Seg-Sex 9:00h ás 19:00 / Sábado: 09:00h ás 16:00h</p>
            </div>
        </div>
    </div>
   
    <div>
        <img alt="" class="ImgTela" src="imagens/ImagemTela.png">
    </div>

    <div id="Principal" class="Principal">
        <div id="Principal" class="Principal"></div>
    </div>
        
    <div class="Agendamento">
        <a href="agenda1.jsp">
            <button  class="BtnAgendamento">Faça agora seu agendamento. Clique Aqui!</button>
        </a>
    </div>
    
    <div class="services">
        <div class="imgagendar">
            <img src="imagens/Agenda.png">
            <button class="BtnAgendar">Escolha seu dia e horário</button>
        </div>

        <div class="imgservico">
            <img src="imagens/Serviço.png">    
            <button class="BtnServico">Escolha seu Serviço</button>
        </div>    

        <div class="imgespecialista">
            <img src="imagens/Especia.png">
            <button type="submit" class="BtnEspecialista">Escolha seu Especialista</button>
        </div>
    </div>
</body>
</html>
