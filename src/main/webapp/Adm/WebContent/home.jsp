<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BARBEARIA UNIBARBER</title>
    <link rel="stylesheet" type="text/css" href="home.css">
</head>
<body>
    <div id="MenuPrincipal" class="MenuPrincipal ocultar">
        <div class="MenuItem">
            <a href="consultaragenda.jsp" target="fprincipal" class="BtnMenuItem">Agendamento</a>
            <a href="./Fornecedores/Fornecedores.html" target="fprincipal" class="BtnMenuItem">Estátiscas</a>
            <a href="./Estoque/Estoque.html" target="fprincipal" class="BtnMenuItem">Estoque</a>
            <a href="./Produção/Movimentação.html" target="fprincipal" class="BtnMenuItem">Movimentação</a>
            <a href="#" class="BtnMenuItem">Estoque</a>
        </div>
        <div>
            <img src="imagens/Menu.png" id="BtnMenuPrincipal" class="BtnMenuPrincipal">
        </div>
    </div>
    
    <div id="topo" class="topo">
        <div class="topo-content">
            <div class="logo-container">
            
            <div class="info-container">
                <h2>Barbearia UniBarber</h2>
                <p>"Seu estilo, nossa paixão!"</p>
            </div>
            <div class="contact-container">
                
            </div>
        </div>
        <div id="config" class="config">
            <div>
                <div>ID: 12345</div>
                <div>Nome: João Silva</div>
            </div>
            
            <div>
                <img src="../Backoffice/Imagens/config.svg" id="Btnconfig" class="Btnconfig">
            </div>
            <div>
               <img src="imagens/Logo.png" class="logo logo-sobreposta">
			</div>
        </div>
  	  </div>
    </div>
    
    <div>
        <img alt="" class="ImgTela" src="imagens/TelaHome.png">
    </div>

    <div id="Principal" class="Principal">
        <div id="Principal" class="Principal"></div>
    </div>
    
    <script>
        const BtnMenuPrincipal = document.querySelector("#BtnMenuPrincipal");
        const MenuPrincipal = document.querySelector("#MenuPrincipal");
        const TodosMenusPrincipais = [...document.querySelectorAll(".BtnMenuItem")];

        BtnMenuPrincipal.addEventListener("click", (evt) => {
            MenuPrincipal.classList.toggle("ocultar");
        });

        TodosMenusPrincipais.forEach(e => {
            e.addEventListener("click", (evt) => {
                MenuPrincipal.classList.add("ocultar");
            });
        });
    </script>
</body>
</html>
