<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
		<c:import url="/WEB-INF/views/templates/header.jsp"></c:import>
	</head>
	<body class="sb-nav-fixed bg-dark">
		<c:import url="/WEB-INF/views/templates/topbar.jsp"></c:import>
		<div id="layoutSidenav">
		<c:import url="/WEB-INF/views/templates/sidebar.jsp"></c:import>
			<div id="layoutSidenav_content">
                <main>
                    <div class="container">
						<sec:authentication property="principal" var="user"/>
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">정보 수정</h3></div>
                                    <div class="card-body">
										    <form:form modelAttribute="userVO" cssClass="user" method="post">
												<input hidden name="username" value="${user.username}">
											<div class="form-floating mb-3">
                                                <input class="form-control"name="password" type="password" placeholder="Password">
                                                <label for="inputEmail">비밀번호</label>
                                            </div>
											<!-- <div class="form-floating mb-3">
                                                <input class="form-control"name="password" type="password" placeholder="Password">
                                                <label for="inputEmail">비밀번호 재입력</label>
                                            </div>											 -->
											<div class="form-floating mb-3">
												<input class="form-control" value="${user.name}" type="text" name="name">
												<label for="inputEmail">이름</label>
											</div>
											<div class="form-floating mb-3">
												<input class="form-control" value="${user.email}" type="email" name="email">
												<label for="inputEmail">이메일</label>
											</div>
											<div class="form-floating mb-3">
												<input class="form-control" value="${user.phone}" type="text" name="phone">
												<label for="inputEmail">휴대폰 번호</label>
											</div>											
											<input type="date" name="birth"><br>																						
											<c:if test="${not empty param.error}">
												<p>${param.error}</p>
											</c:if>
											<div style="margin: 10px auto;">
												<button style="width: 400px; margin-top: 10px; margin-bottom: 10px;" class="btn btn-dark d-block mx-auto" type="submit">수정</button>
											</div>
											
											</form:form>
                                    </div>
                                    <c:import url="/WEB-INF/views/templates/footer.jsp"></c:import>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
	
	
	
	
		</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/login.js"></script>
	</body>
</html>