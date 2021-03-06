<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>Informações do Usuário</title>
	<jsp:include page="../modulos/header-estrutura.jsp" />
</head>

<body>
	<jsp:include page="../modulos/header.jsp" />
	<div class="container">

		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Informações do usuário</h3>
			</div>
			<div class="panel-body">
				<div class="bs-component">
					<h3>${pessoa.nome }
						<small class="text-muted">${pessoa.email}</small>
					</h3>

					<ul class="nav nav-tabs">
						<li class="active">
							<a aria-expanded="false" href="#aba_coordena" data-toggle="tab">
								<span class="visible-md-inline visible-lg-inline">Projetos que </span>Coordena <span class="badge">${projetosCoordena.size()}</span>
							</a>
						</li>
						<li class="">
							<a aria-expanded="false" href="#aba_participa" data-toggle="tab">
								<span class="visible-md-inline visible-lg-inline">Projetos que </span>Participa <span class="badge">${projetosParticipa.size()}</span>
							</a>
						</li>
						<li class="">
							<a aria-expanded="false" href="#aba_coordenou" data-toggle="tab">
								<span class="visible-md-inline visible-lg-inline">Projetos que </span>Coordenou <span class="badge">${projetosCoordenou.size()}</span>
							</a>
						</li>
						<li class="">
							<a aria-expanded="false" href="#aba_participou" data-toggle="tab">
								<span class="visible-md-inline visible-lg-inline">Projetos que </span>Participou <span class="badge">${projetosParticipou.size()}</span>
							</a>
						</li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade active in" id="aba_coordena">
							<div class="well well-sm">
								Projetos <b>em andamento</b> que este usuário <b>coordena</b>
							</div>
							
							<table class="participanteCoordena display">
								<thead>
									<tr>
										<th>Código</th>
										<th>Projeto</th>
										<th>Início</th>
										<th>Término</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${projetosCoordena}" var="projeto">
									<tr>
										<td class="center" style="vertical-align:middle;">${projeto.codigo }</td>
										<td>
											${projeto.nome }<br>
											<small class="visible-md-inline visible-lg-inline">${fn:substring(projeto.descricao, 0, 250)}...</small>
										</td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.inicio }" /></td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.termino }" /></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="tab-pane fade" id="aba_participa">
							<div class="well well-sm">
								Projetos <b>em andamento</b> que este usuário <b>participa</b>
							</div>
							
							<table class="participanteParticipa display">
								<thead>
									<tr>
										<th>Código</th>
										<th>Projeto</th>
										<th>Coordenador</th>
										<th>Início</th>
										<th>Término</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${projetosParticipa }" var="projeto">
									<tr>
										<td class="center" style="vertical-align:middle;">${projeto.codigo }</td>
										<td>
											${projeto.nome }<br>
											<small class="visible-md-inline visible-lg-inline">${fn:substring(projeto.descricao, 0, 280)}...</small>
										</td>
										<td style="vertical-align:middle;"><span style="white-space: nowrap;">${projeto.coordenador.nome }</span></td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.inicio }" /></td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.termino }" /></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="tab-pane fade" id="aba_coordenou">
							<div class="well well-sm">
								Projetos <b>concluídos</b> que este usuário <b>coordenou</b>
							</div>
							
							<table class="participanteCoordena display">
								<thead>
									<tr>
										<th>Código</th>
										<th>Projeto</th>
										<th>Início</th>
										<th>Término</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${projetosCoordenou }" var="projeto">
									<tr>
										<td class="center" style="vertical-align:middle;">${projeto.codigo }</td>
										<td>
											${projeto.nome }<br>
											<small class="visible-md-inline visible-lg-inline">${fn:substring(projeto.descricao, 0, 370)}...</small>
										</td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.inicio }" /></td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.termino }" /></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="tab-pane fade" id="aba_participou">
							<div class="well well-sm">
								Projetos <b>concluídos</b> que este usuário <b>participou</b>
							</div>
							
							<table class="participanteParticipa display">
								<thead>
									<tr>
										<th>Código</th>
										<th>Projeto</th>
										<th>Coordenador</th>
										<th>Início</th>
										<th>Término</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${projetosParticipou }" var="projeto">
									<tr>
										<td class="center" style="vertical-align:middle;">${projeto.codigo }</td>
										<td>
											${projeto.nome }<br>
											<small class="visible-md-inline visible-lg-inline">${fn:substring(projeto.descricao, 0, 270)}...</small>
										</td>
										<td style="vertical-align:middle;"><span style="white-space: nowrap;">${projeto.coordenador.nome }</span></td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.inicio }" /></td>
										<td style="vertical-align:middle;"><fmt:formatDate pattern="dd/MM/yyyy" value="${projeto.termino }" /></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../modulos/footer.jsp" />
</body>
</html>
