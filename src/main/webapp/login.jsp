<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/custom.css">

<%--  <link href="WEB-INF/css/bootstrap.css">--%>
  <title>JSP 게시판 웹 사이트</title>
</head>
<body>
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
            <a class="nav-link" href="bbs.jsp">게시판</a>
          </li>

        </ul>
        <ul class="nav navbar-nav navbar-right d-flex">
          <li class="dropdown">
            <a class="nav-link dropdown-toggle caret" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              접속하기
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item active" href="login.jsp">로그인</a></li>
              <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
            </ul>
          </li>
        </ul>
<%--        <form class="d-flex" role="search">--%>
<%--          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">--%>
<%--          <button class="btn btn-outline-success" type="submit">Search</button>--%>
<%--        </form>--%>
      </div>
    </div>
  </nav>

  <div class="container d-flex">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
      <div class="jumbotron" style="padding-top: 20px;">
        <form method="post" action="loginAction.jsp">
          <h3 style="text-align: center;">로그인 화면</h3>
          <div class="form-group pb-3">
            <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
          </div>
          <div class="form-group pb-3">
            <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
          </div>
          <input type="submit" class="btn btn-primary form-control" value="로그인">
        </form>
      </div>
    </div>
    <div class="col-lg-4"></div>
  </div>

  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>