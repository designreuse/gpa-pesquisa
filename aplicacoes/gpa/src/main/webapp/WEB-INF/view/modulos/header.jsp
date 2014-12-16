<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header class="clearfix">
	<span>GPA-Pequisa</span></span>
	<h1>Gestão de Programas Acadêmicos</h1>
</header>
<div class="main">
	<nav class="cbp-hsmenu-wrapper" id="cbp-hsmenu-wrapper">
		<div class="cbp-hsinner">
			<ul class="cbp-hsmenu">
				<li>
					<a href="<c:url value="/projeto/listar" />"><i class="fa fa-briefcase fa-2x"></i>&nbsp; Projetos</a>
				</li>
				<li>
					<a href="<c:url value="/projeto/cadastrar" />"><i class="fa fa-plus-circle fa-2x"></i>&nbsp; Novo Projeto</a>
				</li>
				<li style="float: right;">
					<a href="<c:url value="/j_spring_security_logout" />"><i class="fa fa-power-off fa-2x"></i>&nbsp;</a>
				</li>
			</ul>
		</div>
		<div class="cbp-hsmenubg"></div>
	</nav>
</div>