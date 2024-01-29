<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbss.Bbss" %>
<%@ page import="bbss.BbssDAO" %>
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
  <%
    String userID = null; //로그인이 된 사람들은 로그인 정보를 담을 수 있게 함.
    if (session.getAttribute("userID") != null) { //현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있게 함.
      userID = (String) session.getAttribute("userID"); // 스트링 형변환을 해서 윗줄, 세션에 있는 값을 그대로 가져올 수 있게 함.
    }

    if(userID == null) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('로그인이 필요합니다.')");
      script.println("location.href = 'login.jsp'");
      script.println("</script>"); // bbssID가 아무것도 없다면 alert 발생
    }

    int bbssID = 0;

    if (request.getParameter("bbssID") != null) { // 만약 매개변수로 넘어온 bbssID라는 매개변수가 존재한다면
      bbssID = Integer.parseInt(request.getParameter("bbssID")); // 아래 뷰 페이지 안에서 처리가 가능함.
    }

    if (bbssID == 0) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('유효하지 않은 글입니다.')");
      script.println("location.href = 'bbss.jsp'");
      script.println("</script>"); // bbssID가 아무것도 없다면 alert 발생
    }

    Bbss bbss = new BbssDAO().getBbss(bbssID); // 현재 작성한 글이 작성자 본인인지 확인할 필요가 있음. 이때 세션 관리가 필요함.
    // 현재 넘어온 bbssID값으로 bbss 해당 글을 가져온 다음
    if(!userID.equals(bbss.getUserID())) { //실제로 이 글을 작성한 사람이 맞는 지 확인함.
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('권한이 없습니다.')");
      script.println("location.href = 'bbss.jsp'");
      script.println("</script>");
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
          <a class="nav-link" href="main.jsp">메인</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active"  aria-current="page" href="bbss.jsp">게시판</a>
        </li>

      </ul>

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


    </div>
  </div>
</nav>
  <div class="container">
    <div class="row">
      <form method="post" action="updateAction.jsp?bbssID=<%= bbssID %>"> <%--액션페이지로 보내지는 용도. 보내지는 내용이 숨겨질 수 있도록 post--%>
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;" > <%-- table-striped는 테이블 층층 색이 달라보이게 하는 것--%>
          <thead>
            <tr>
              <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><input type="text" class="form-control" placeholder="글 제목" name="bbssTitle" maxlength="50" value="<%= bbss.getBbssTitle()%>"></td>
            </tr>
            <tr>
              <td><textarea class="form-control" placeholder="글 제목" name="bbssContent" maxlength="2048" style="height: 350px;"><%= bbss.getBbssContent()%></textarea></td>
            </tr>
          </tbody>
        </table>
        <div>
          <input type="submit" href="write.jsp" class="btn btn-primary" style="float: right" value="글수정">
        </div>
      </form>
    </div>
  </div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>