<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"   %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"    %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko" class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
  <meta charset="UTF-8"/>
  <title>공지사항</title>
  <c:import url="/WEB-INF/views/templates/header.jsp"></c:import>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    .main-container {
      max-width: 900px;
      margin: 40px auto;
      background: #fff;
      border-radius: 14px;
      box-shadow: 0 6px 32px rgba(20,30,50,0.09);
      padding: 38px;
    }
    h2 {
      margin-bottom: 28px;
      letter-spacing: -1px;
    }
    .btn-group {
      float: right;
      margin-bottom: 18px;
    }
    .modern-btn {
      display: inline-flex;
      align-items: center;
      gap: 7px;
      border: none;
      padding: 10px 28px;
      border-radius: 999px;
      font-size: 16px;
      font-weight: 500;
      background: linear-gradient(90deg, #6366f1 15%, #6d9cf6 100%);
      color: #fff;
      box-shadow: 0 2px 8px rgba(100,120,230,0.10);
      cursor: pointer;
      text-decoration: none;
      margin-left: 8px;
      transition: transform .1s, box-shadow .1s, background .2s;
    }
    .modern-btn:hover {
      transform: translateY(-2px) scale(1.03);
      background: linear-gradient(90deg, #3c47b5 10%, #93b4fa 100%);
      box-shadow: 0 4px 16px rgba(100,120,230,0.13);
      color: #fff;
      text-decoration: none;
    }
    .notice-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 14px;
    }
    .notice-table th, .notice-table td {
      padding: 13px 7px;
      text-align: center;
      border-bottom: 1px solid #e0e3ef;
      vertical-align: middle;
    }
    .notice-table th {
      background: #f5f7fa;
      color: #2c387e;
    }
    .notice-table tr:hover {
      background: #f9fafc;
    }
    .title-col {
      text-align: left;
    }
    .title-col a {
      color: #333;
      text-decoration: none;
    }
    .title-col a:hover {
      color: #6366f1;
      text-decoration: underline;
    }
    .paging {
      margin: 22px 0 0 0;
      text-align: center;
    }
    .paging a {
      margin: 0 3px;
      padding: 5px 10px;
      color: #555;
      text-decoration: none;
      border-radius: 4px;
      transition: all 0.3s;
    }
    .paging a:hover {
      background: #f5f7fa;
      color: #6366f1;
    }
    .paging .cur {
      font-weight: bold;
      color: #fff;
      background: #6366f1;
      padding: 5px 10px;
      border-radius: 4px;
    }
    /* 삭제 버튼 별도 색상 */
    .btn-delete {
      padding: 6px 14px;
      font-size: 14px;
      background: linear-gradient(90deg, #ef4444 20%, #f59e42 100%);
      box-shadow: none;
    }
    .btn-delete:hover {
      background: linear-gradient(90deg, #dc2626 20%, #f97316 100%);
    }
  </style>
</head>
<body class="sb-nav-fixed d-flex flex-column min-vh-100">
<c:import url="/WEB-INF/views/templates/topbar.jsp"></c:import>
<div id="layoutSidenav" class="d-flex flex-grow-1">
    <c:import url="/WEB-INF/views/templates/sidebar.jsp"></c:import>
    <div id="layoutSidenav_content" class="d-flex flex-column flex-grow-1">
        <main class="flex-grow-1">
            <div class="container-fluid">
                <div class="main-container">
                    <h2>공지사항</h2>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/" class="modern-btn">
                            <i class="fas fa-home"></i> 홈
                        </a>
                        <sec:authorize access="hasRole('ADMIN')">
                            <a href="${pageContext.request.contextPath}/notice/add" class="modern-btn">
                                <i class="fas fa-pen"></i> 글쓰기
                            </a>
                        </sec:authorize>
                    </div>
                    <table class="notice-table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>수정일</th>
                                <th>조회수</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="notice" items="${list}">
                                <tr>
                                    <td><c:out value="${notice.boardNum}" /></td>
                                    <td class="title-col">
                                        <a href="${pageContext.request.contextPath}/notice/detail?boardNum=${notice.boardNum}">
                                            <c:out value="${notice.boardTitle}"/>
                                        </a>
                                    </td>
                                    <td><c:out value="${notice.userName}" /></td>
                                    <td><fmt:formatDate value="${notice.boardDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <c:if test="${not empty notice.updateAt}">
                                            <fmt:formatDate value="${notice.updateAt}" pattern="yyyy-MM-dd"/>
                                        </c:if>
                                    </td>
                                    <td><c:out value="${notice.boardHits}" /></td>
                                    <td>
                                        <sec:authorize access="hasRole('ADMIN')">
                                            <a href="${pageContext.request.contextPath}/notice/update?boardNum=${notice.boardNum}" class="modern-btn" style="padding: 6px 14px; font-size: 14px;">
                                                <i class="fas fa-edit"></i> 수정
                                            </a>
                                            <form action="${pageContext.request.contextPath}/notice/delete" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제할까요?');">
                                                <input type="hidden" name="boardNum" value="${notice.boardNum}" />
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="modern-btn btn-delete">
                                                    <i class="fas fa-trash-alt"></i> 삭제
                                                </button>
                                            </form>
                                        </sec:authorize>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="7">등록된 공지사항이 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div class="paging">
                        <c:if test="${pager.startPage > 1}">
                            <a href="?curPage=${pager.startPage - 1}">&laquo;</a>
                        </c:if>
                        <c:forEach var="i" begin="${pager.startPage}" end="${pager.lastPage}">
                            <a href="?curPage=${i}" class="${pager.curPage == i ? 'cur' : ''}">${i}</a>
                        </c:forEach>
                        <c:if test="${pager.lastPage < pager.totalPage}">
                            <a href="?curPage=${pager.lastPage + 1}">&raquo;</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>