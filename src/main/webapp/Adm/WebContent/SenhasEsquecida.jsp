<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Esqueci a senha</title>
    <link rel="stylesheet" href="SenhasEsquecida.css">
</head>
<body>
    <h2>Esqueci a senha</h2>
    <form action="reset_password.jsp" method="post">
        <label for="email">Digite seu e-mail ou nome de usuário:</label>
        <input type="text" id="email" name="email" required>
        <button type="submit">Enviar instruções de redefinição de senha</button>
    </form>

    <%-- Alerta de senha atualizada --%>
    <%
        String senhaAtualizada = request.getParameter("senhaAtualizada");
        if (senhaAtualizada != null && senhaAtualizada.equals("true")) {
    %>
            <script>
                alert("Sua senha foi atualizada com sucesso!");
            </script>
    <% } %>
</body>
</html>
