<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
  :root {
    --club-yellow: #ffe600;
    --club-sidebar: #23232a;
  }
  .club-sidebar {
    position: fixed;
    left: 0; top: 64px;  /* 탑바 높이만큼 아래로 */
    width: 240px; height: calc(100vh - 64px);
    background: var(--club-sidebar);
    color: var(--club-yellow);
    border-right: 3px solid var(--club-yellow);
    z-index: 120;
    font-size: 1.06em;
    box-shadow: 2px 0 10px rgba(0,0,0,0.07);
    padding-top: 1.5rem;
    display: flex; flex-direction: column;
  }
  .club-sidebar .sb-sidenav-menu-heading {
    padding: 1rem 2rem 0.5rem 2rem;
    font-size: 1.08em;
    font-weight: bold;
    color: var(--club-yellow);
    letter-spacing: 0.02em;
  }
  .club-sidebar .nav-link {
    display: flex; align-items: center;
    color: #fff;
    padding: 12px 2.3rem;
    font-weight: 500; font-size: 1em;
    border-left: 3px solid transparent;
    text-decoration: none;
    transition: background .15s, border-color .15s;
  }
  .club-sidebar .nav-link:hover,
  .club-sidebar .nav-link.active {
    background: #24242e;
    color: var(--club-yellow);
    border-left: 3px solid var(--club-yellow);
  }
  .club-sidebar .sb-nav-link-icon {
    margin-right: 12px;
    font-size: 1.22em;
    display: flex; align-items: center;
  }
  .club-sidebar .sb-sidenav-footer {
    margin-top: auto;
    background: #1d1d23;
    color: #bdbdbd;
    padding: 18px 2rem;
    font-size: 0.93em;
    border-top: 1px solid #333;
  }
</style>

<!-- 🟨 사이드바 메뉴 (경로/권한 모두 유지) -->
<div class="club-sidebar">
  <div class="sb-sidenav-menu">
    <div class="sb-sidenav-menu-heading">COMMUNITY</div>
    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
      <div class="sb-nav-link-icon"><i class="bi bi-journal-text"></i></div>
      게시판
      <div class="sb-sidenav-collapse-arrow"><i class="bi bi-chevron-down"></i></div>
    </a>
    <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
      <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
        <a class="nav-link" href="/board/list">
          <div class="sb-nav-link-icon"><i class="bi bi-globe"></i></div>
          자유게시판
        </a>
        <a class="nav-link" href="/notice/list">
          <div class="sb-nav-link-icon"><i class="bi bi-info-circle-fill"></i></div>
          공지사항
        </a>
        <a class="nav-link" href="/qna/list">
          <div class="sb-nav-link-icon"><i class="bi bi-patch-question-fill"></i></div>
          QNA
        </a>
      </nav>
    </div>
    <a class="nav-link" href="/chat/list">
      <div class="sb-nav-link-icon"><i class="bi bi-chat-fill"></i></div>
      채팅
    </a>
    <a class="nav-link" href="/friend/list">
      <div class="sb-nav-link-icon"><i class="bi bi-people-fill"></i></div>
      친구
    </a>
    <div class="sb-sidenav-menu-heading">ADDONS</div>
    <a class="nav-link" href="charts.html">
      <div class="sb-nav-link-icon"><i class="bi bi-bar-chart-line-fill"></i></div>
      Charts
    </a>
    <a class="nav-link" href="tables.html">
      <div class="sb-nav-link-icon"><i class="bi bi-table"></i></div>
      Tables
    </a>
    <sec:authorize access="hasRole('TRAINER')">
      <div class="sb-sidenav-menu-heading">결재</div>
      <a class="nav-link" href="/approval/addDocument">
        <div class="sb-nav-link-icon"><i class="bi bi-folder-fill"></i></div>
        결재신청
      </a>
    </sec:authorize>
    <sec:authorize access="hasRole('ADMIN')">
      <a class="nav-link" href="/approval/formList">
        <div class="sb-nav-link-icon"><i class="bi bi-person-bounding-box"></i></div>
        결재양식(관리자)
      </a>
    </sec:authorize>
  </div>
  <div class="sb-sidenav-footer">
    <div class="small">Logged in as:</div>
    <span style="font-family:'Bebas Neue',sans-serif;letter-spacing:0.02em;">SPORTS CLUB</span>
  </div>
</div>
