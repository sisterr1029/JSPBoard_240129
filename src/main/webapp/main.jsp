<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/custom.css">
  <title>JSP 게시판 웹 사이트</title>
</head>
<body>
  <%
    String userID = null; //로그인이 된 사람들은 로그인 정보를 담을 수 있게 함.
    if (session.getAttribute("userID") != null) { //현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있게 함.
      userID = (String) session.getAttribute("userID"); // 스트링 형변환을 해서 윗줄, 세션에 있는 값을 그대로 가져올 수 있게 함.
    }
  %>
<%--  <nav class="navbar navbar-expand-lg bg-body-tertiary">--%>
<%--    <div class="navbar-header">--%>
<%--      <button type="button" class="navbar-brand" data-toggle="collapse" data-target="#bs=example-navbar-collapse-1" aria-expanded="false">--%>
<%--        <span class="icon-bar"></span>--%>
<%--        <span class="icon-bar"></span>--%>
<%--        <span class="icon-bar"></span>--%>
<%--      </button>--%>
<%--      <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>--%>
<%--    </div>--%>
<%--  </nav>--%>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">JSP 게시판 웹 사이트</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="main.jsp">메인</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="bbss.jsp">게시판</a>
        </li>

      </ul>
      <%
        if(userID == null) { // 즉 로그인이 되어있지 않다면,
      %>
      <ul class="nav navbar-nav navbar-right d-flex">
        <li class="dropdown">
          <a class="nav-link dropdown-toggle caret" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            접속하기
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
          </ul>
        </li>
      </ul>

      <%
          } else {
      %>

      <ul class="nav navbar-nav navbar-right d-flex">
        <li class="dropdown">
          <a class="nav-link dropdown-toggle caret" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            회원관리
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
          </ul>
        </li>
      </ul>

      <%
        }
      %>
    </div>
  </div>
</nav>
<div class="container mainJumbo">
  <div class="jumbotron">
    <div class="container">
      <h1>웹 사이트 소개</h1>
      <p>이 웹사이트는 앞으로의 성장을 위해 model1으로 만든 게시판입니다. 최소한의 간단한 로직만을 이용해 개발하였으며, 디자인 템플릿으로는 부트스트랩을 이용하였습니다.</p>
      <p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
    </div>
  </div>
</div>
  <div class="container">
    <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
      <ol class="carousel-indicators">
        <li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active"></li>
        <li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
        <li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="img/1.jpg" class="d-block w-100" alt="First slide">
        </div>
        <div class="carousel-item">
          <img src="img/2.jpg" class="d-block w-100" alt="Second slide">
        </div>
        <div class="carousel-item">
          <img src="img/3.jpg" class="d-block w-100" alt="Third slide">
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    </div>
  </div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>