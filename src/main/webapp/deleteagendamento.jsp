<%@ page import="usuariodao.UsuarioDao" %>
<%
    String id = request.getParameter("id");
    boolean sucesso = UsuarioDao.deletarUsuarioPorId(Integer.parseInt(id));
    if (sucesso) {
        response.getWriter().write("success");
    } else {
        response.getWriter().write("failure");
    }
%>
