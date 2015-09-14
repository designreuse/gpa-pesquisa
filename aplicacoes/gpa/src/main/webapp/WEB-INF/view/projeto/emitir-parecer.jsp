<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
	<head>
		<title>Emitir Parecer</title>
		<jsp:include page="../modulos/header-estrutura.jsp" />
	</head>
<body>
	<jsp:include page="../modulos/header.jsp" />
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Emitir Parecer</h3>
			</div>
			<div class="panel-body">
				<c:if test="${not empty erro}">
					<div class="alert alert-danger alert-dismissible" role="alert">
						<button type="button" class="close" data-dismiss="alert">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<c:out value="${erro}"></c:out>
					</div>
				</c:if>
				<form:form id="emitirParecerForm" enctype="multipart/form-data" servletRelativeAction="/projeto/emitir-parecer"
					commandName="parecer" method="POST" cssClass="form-horizontal">
					<input type="hidden" name="id-projeto" value="${projeto.id }"/>
					<div class="form-group">
						<label class="col-sm-2 control-label">Projeto:</label>
						<div class="col-sm-8 value-label">
							<label>${projeto.nome }</label>
						</div>
					</div>
					
					<div class="form-group">
						<label for="autor" class="col-sm-2 control-label">Autor:</label>
						<div class="col-sm-8 value-label">
							<label><a href="<c:url value="/pessoa/${projeto.autor.id}/detalhes" ></c:url>">${projeto.autor.nome}</a></label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">Observação</label>
						<div class="col-sm-10 value-label">
							<c:if test="${empty projeto.parecer.observacao }">
								<label>-</label>
							</c:if>
							<label>${projeto.parecer.observacao }</label>
						</div>
					</div>
					
					<div class="form-group form-item">
						<label for="posicionamento" class="col-sm-2 control-label">Posicionamento:</label>
						<div class="col-sm-4">
							<select id="posicionamento" name="posicionamento" class="form-control">
								<c:forEach items="${posicionamento}" var="pos">
									<option value="${pos}">${pos.descricao}</option>
								</c:forEach>
							</select>
						</div>
					</div>
	
					<div class="form-group form-item">
						<label for="parecer" class="col-sm-2 control-label"><span class="required">*</span> Parecer:</label>
						<div class="col-sm-10">
							<textarea id="parecer" name="parecer" class="form-control" rows="8" placeholder="Parecer" required="required"></textarea>
						</div>
						<c:if test="${not empty erro_parecer}">
							<div class="error-validation">
								<span>${erro_parecer}</span>
							</div>
						</c:if>
					</div>
	
					<div class="form-group">
						<label for="anexo" class="col-sm-2 control-label">Anexo:</label>
						<div class="col-sm-10 files">
							<input type="file" id="anexos" name="anexo" class="anexo file-loading"></input>
						</div>
					</div>
	
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<span class="campo-obrigatorio"><span class="required">*</span> Campos obrigatórios</span>
						</div>
					</div>
	
					<div class="controls">
						<input name="salvar" type="submit" class="btn btn-primary" value="Salvar" />
						<a href="<c:url value="/projeto/index"></c:url>" class="btn btn-default">Cancelar</a>
					</div>
					
					<!-- <!-- Modal de confirmação e emição do parecer
					<div class="modal fade" id="confirm-parecer" tabindex="-1"
						role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title" id="confirm-parecerLabel">Emitir Parecer</h4>
								</div>
								<div class="modal-body"></div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button type="submit" class="btn btn-primary">Save</button>
								</div>
							</div>
						</div>
					</div> -->
				</form:form>
			</div><!-- /panel-body -->
		</div><!-- /panel -->
	</div><!-- /container -->
	
	<jsp:include page="../modulos/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		$('#menu-projetos').addClass('active');
	</script>
</body>
</html>