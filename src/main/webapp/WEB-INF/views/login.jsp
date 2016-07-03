<%--
  Created by IntelliJ IDEA.
  User: sonny
  Date: 2015/11/14
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
  <title>Welcome to Connectf</title>
  <!-- Bootstrap -->
  <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
  <link href="resources/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
  <link href="resources/assets/styles.css" rel="stylesheet" media="screen">
  <link href="resources/bootstrap/css/new-style.css" rel="stylesheet" media="screen">
  <script src="resources/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
  <script src="resources/vendors/jquery-1.9.1.min.js"></script>
  <script src="resources/bootstrap/js/bootstrap.min.js"></script>
</head>
<body id="login" onload='document.loginForm.username.focus();'>
<div id="container">
  <form name='loginForm' action="<c:url value='/j_spring_security_check' />" method='POST' class="form-signin">
    <h2 class="form-signin-heading form-tit">请登录</h2>
    <div class="input_mgbox">
      <c:if test="${not empty error}">
        <div class="error">${error}</div>
      </c:if>
      <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
      </c:if>
    </div>
    <input type="text" class="input-block-level" name='username' placeholder="请输入用户名">
    <input type="password" class="input-block-level" name='password' placeholder="请输入密码">
    <label class="checkbox form-me">
      <input type="checkbox" value="remember-me form-me">请记住我的用户名密码
    </label>
    <button class="btn btn-large btn-primary form-but" type="submit">登 录</button>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="hidden_name" value="">
  </form>
</div>
</body>
</html>
