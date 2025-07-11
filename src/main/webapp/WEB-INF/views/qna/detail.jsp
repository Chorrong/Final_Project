<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 상세</title>
    <!-- 공통 헤더 -->
    <c:import url="/WEB-INF/views/templates/header.jsp"/>
    <style>
        body.sb-nav-fixed {
            padding-top: 60px;    /* 탑바 높이 */
            padding-left: 240px;  /* 사이드바 너비 */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }
        h2 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        .secret-lock {
            color: #e03e2f;
            margin-left: 6px;
        }
        .info-line {
            margin: 4px 0;
            color: #666;
            font-size: 14px;
        }
        hr {
            border: none;
            border-bottom: 1px solid #ddd;
            margin: 20px 0;
        }
        .content {
            white-space: pre-wrap;
            line-height: 1.6;
            font-size: 16px;
        }
        .error-msg {
            background-color: #ffe6e6;
            border: 1px solid #e03e2f;
            padding: 12px 16px;
            border-radius: 6px;
            color: #b00000;
            font-weight: 600;
            margin-bottom: 20px;
            max-width: 400px;
        }
        form.secret-password-form {
            margin-top: 16px;
            max-width: 400px;
        }
        form.secret-password-form input[type="password"] {
            width: calc(100% - 110px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            font-size: 15px;
            transition: border-color 0.2s;
        }
        form.secret-password-form input[type="password"]:focus {
            border-color: #2663eb;
        }
        form.secret-password-form button {
            width: 100px;
            padding: 10px 0;
            border: none;
            background-color: #2663eb;
            color: white;
            font-weight: 600;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        form.secret-password-form button:hover {
            background-color: #1d51bc;
        }
        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .action-buttons a,
        .action-buttons form button {
            background-color: #2663eb;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 600;
            font-size: 14px;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .action-buttons a:hover,
        .action-buttons form button:hover {
            background-color: #1d51bc;
        }
        .action-buttons form { margin: 0; display: inline; }
    </style>
</head>
<body class="sb-nav-fixed d-flex flex-column min-vh-100">
    <!-- 탑바 -->
    <c:import url="/WEB-INF/views/templates/topbar.jsp"/>
    <div id="layoutSidenav" class="d-flex flex-grow-1">
        <!-- 사이드바 -->
        <c:import url="/WEB-INF/views/templates/sidebar.jsp"/>
        <div id="layoutSidenav_content" class="d-flex flex-column flex-grow-1">
            <main class="flex-grow-1">
                <div class="container">
                    <c:choose>
                        <c:when test="${not empty errorMsg}">
                            <div class="error-msg">${errorMsg}</div>
                            <form class="secret-password-form" action="${pageContext.request.contextPath}/qna/detail" method="get">
                                <input type="hidden" name="boardNum" value="${boardNum}" />
                                <input type="password" name="secretPassword" placeholder="비밀글 비밀번호 입력" required />
                                <button type="submit">확인</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <h2>${qna.boardTitle}
                                <c:if test="${qna.isSecret}">
                                    <span class="secret-lock">🔒</span>
                                </c:if>
                            </h2>
                            <div class="info-line"><strong>작성자:</strong> ${qna.userName}</div>
                            <div class="info-line"><strong>작성일:</strong> ${qna.boardDate}</div>
                            <hr />
                            <div class="content"><c:out value="${qna.boardContents}"/></div>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/qna/list">목록으로</a>
                                <a href="${pageContext.request.contextPath}/qna/update/${qna.boardNum}">수정</a>
                                <form action="${pageContext.request.contextPath}/qna/delete/${qna.boardNum}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                    <button type="submit">삭제</button>
                                </form>
                                <a href="${pageContext.request.contextPath}/qna/reply?ref=${qna.boardRef}&step=${qna.boardStep}&depth=${qna.boardDepth}">답글쓰기</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
            <!-- 푸터 -->
            <c:import url="/WEB-INF/views/templates/footer.jsp"/>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
