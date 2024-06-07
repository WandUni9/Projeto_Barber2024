<%@ page import="usuariodao.UsuarioDao"  %>
<jsp:useBean id="u" class="usuario.Bean.Usuario"></jsp:useBean>
<jsp:setProperty property="*" name="u"/>

<%
	UsuarioDao.deletarUsuario(u);
	response.sendRedirect("consultaragenda.jsp");


%>