<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adm Unibarber Login</title>
    <link rel="stylesheet" href="Login.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
</head>
<body>
    <div class="login-container">
        <div class="image-container">
            <img src="imagens/Logo.png" alt="Imagem 1">
        </div>
       
        <form action="login.jsp" method="post" onsubmit="return encryptPassword()">
            <input type="text" placeholder="Digite seu login" name="username" id="username" required>
            <input type="password" placeholder="Digite sua senha" name="password" id="password" required>
            <button type="submit">Entrar</button>
            <div class="Esqueceu a Senha">
                <a href="SenhasEsquecida.jsp">Esqueceu a senha?</a> <!-- Link para a página de redefinição de senha -->
            </div>
        </form>
    </div>

    <script>
        function encryptPassword() {
            var passwordField = document.getElementById('password');
            var password = passwordField.value;
            var encryptedPassword = CryptoJS.MD5(password).toString();
            passwordField.value = encryptedPassword;

            // Verifica se a senha está correta
            var senhaCorreta = "5f4dcc3b5aa765d61d8327deb882cf99"; // Senha "password" criptografada com MD5
            if (encryptedPassword === senhaCorreta) {
                // Senha correta, exibe alerta de acesso permitido
                alert("Acesso permitido!");
                return true; // Permite o envio do formulário
            } else {
                // Senha incorreta, exibe alerta de senha incorreta
                alert("Senha incorreta. Tente novamente.");
                return false; // Impede o envio do formulário
            }
        }
    </script>
</body>
</html>


