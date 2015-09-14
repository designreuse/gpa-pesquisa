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
		<title>Avaliar Projeto</title>
		<jsp:include page="../modulos/header-estrutura.jsp" />
	</head>
<body>
	<jsp:include page="../modulos/header.jsp" />
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Avaliar</h3>
			</div>
			<div class="panel-body">
				<form:form id="avaliarProjetoForm" enctype="multipart/form-data" servletRelativeAction="/direcao/avaliar" method="POST" cssClass="form-horizontal">
					<input type="hidden" name="id" value="${projeto.id }"/>
					<div class="form-group">
						<label class="col-sm-2 control-label">Projeto:</label>
						<div class="col-sm-8 value-label">
							<label>${projeto.nome }</label>
						</div>
					</div>
					<div class="form-group">
						<label for="autor" class="col-sm-2 control-label">Parecerista:</label>
						<div class="col-sm-4 value-label">
							<label>${projeto.parecer.parecerista.nome }</label>
						</div>
						<label for="autor" class="col-sm-2 control-label">Autor:</label>
						<div class="col-sm-4 value-label">
							<label><a href="<c:url value="/pessoa/${projeto.autor.id}/detalhes" ></c:url>">${projeto.autor.nome}</a></label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Parecer:</label>
						<div class="col-sm-10 value-label">
							<label>${projeto.parecer.parecer }</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Posicionamento:</label>
						<div class="col-sm-10 value-label">
							<label>${projeto.parecer.status.descricao }</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Anexo:</label>
						<div class="col-sm-10 value-label">
							<a href="<c:url value="/documento/${projeto.id }/${projeto.parecer.documento.id }" />" class="col-sm-12" style="margin-top: 5px;">${projeto.parecer.documento.nome }</a>
						</div>
					</div>
					<div class="form-group form-item">
						<label class="col-sm-2 control-label">Status:</label>
						<div class="col-sm-4">
							<select id="avaliacao" name="avaliacao" class="form-control">
								<option value="APROVADO">APROVADO</option>
								<option value="APROVADO_COM_RESTRICAO">APROVADO COM RESTRIÇÃO</option>
								<option value="REPROVADO">REPROVADO</option>
							</select>
						</div>
					</div>
	
					<div class="form-group form-item">
						<label for="ata" class="col-sm-2 control-label"><span class="required">*</span> Ata de reunião:</label>
						<div class="col-sm-10">
							<input type="file" id="ata" name="ata" class="anexo file-loading" required="required"></input>
							<c:if test="${not empty erro_ata}">
								<div class="error-validation">
									<span>${erro_ata}</span>
								</div>
							</c:if>
						</div>
					</div>
					
					<div class="form-group form-item">
						<label for="oficio" class="col-sm-2 control-label"><span class="required">*</span> Ofício de aceitação:</label>
						<div class="col-sm-10">
							<input type="file" id="oficio" name="oficio" class="anexo file-loading" required="required"></input>
							<c:if test="${not empty erro_oficio}">
								<div class="error-validation">
									<span>${erro_oficio}</span>
								</div>
							</c:if>
						</div>
					</div>
	
					<div class="form-group">
						<label class="col-sm-2 control-label">Observação:</label>
						<div class="col-sm-10">
							<textarea id="observacao" name="observacao" class="form-control" rows="8" placeholder="Observação"></textarea>
						</div>
					</div>
					
					<div class="controls">
						<input name="salvar" type="submit" class="btn btn-primary" value="Salvar" />
						<a href="<c:url value="/projeto/index"></c:url>" class="btn btn-default">Cancelar</a>
					</div>
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