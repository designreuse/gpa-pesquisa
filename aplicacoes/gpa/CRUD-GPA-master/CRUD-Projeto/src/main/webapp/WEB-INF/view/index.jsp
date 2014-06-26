<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="./modulos/header.jsp" />
	<div class="container">
		<h1>Gest�o de Projetos Acad�micos</h1>

		<a href="listar"><button class="btn btn-primary">Listar Projetos  <span class="glyphicon glyphicon-list"></span></button></a>
	
		<a href="cadastro"><button class="btn btn-primary">Cadastrar Projeto  <span class="glyphicon glyphicon-plus"></span></button></a>
		
		<a href="<c:url value='j_spring_security_logout' />" ><button class="btn btn-primary">Sair  <span class="glyphicon glyphicon-off"></span></button></a>
		
	</div>

<jsp:include page="./modulos/footer.jsp" />
</html>