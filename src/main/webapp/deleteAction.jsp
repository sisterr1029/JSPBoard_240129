<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bbss.BbssDAO" %> <%-- 게시글을 작성할 수 있는 데이터베이스는 BbssDAO에 있는 객체를 이용해서 다룰 수 있기 때문. --%>
<%@ page import="bbss.Bbss" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %><%--자바스크립트를 문장을 작성하기위해--%>
<%--<% request.setCharacterEncoding("UTR-8"); %> &lt;%&ndash;건너오는 데이터들을 UTF-8으로 받을 수 있게 &ndash;%&gt;--%>
<!DOCTYPE html>
<html>
<head>
<%--    <meta name="viewport" content="width=device-width", initial-scale="1">--%>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");

        String userID = null;
        if(session.getAttribute("userID") != null) {//세션을 확인해서 userID라는 이름으로 세션이 존재하는 회원들은 이런식으로 userID에 해당 세션 값을 넣어줄 수 있도록 함.
            userID = (String) session.getAttribute("userID"); //String 형태로 바꿔서 정상적으로 userID라는 변수가 자신에게 할당된 아이디를 담을 수 있도록 만들어줌.
        }
        if(userID == null) {    //userID가 null값이 아닌 경우는 이미 로그인 됨을 출력, 메인링크로 바로 이동케함.
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인이 필요합니다.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
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
        } else {
            BbssDAO bbssDAO = new BbssDAO(); // UserDAO라는 하나의 인스턴스를 만들어주고
            int result = bbssDAO.delete(bbssID); //.
            // 이렇게 해서 로그인 페이지에서 userID와 userPassword 가 각각 사용자에 의해 입력이 된 값으로 이 곳으로 넘어와서 그 값을 login함수에 넣어서 실행을 해주는 것임.
            // PrintWriter 란 자바에서 출력 스트림을 다루기 위한 클래스
            // response.getWriter()는 웹에서 클라이언트로 텍스트를 전송하기 위한 출력 스트림을 얻기위한 메소드
            // response는 서블릿이나 JSP에서 사용되는 HttpServletResponse 객체를 나타냄. 이 객체를 통해 서버에서 클라이언트로 데이터 전송이 가능.

            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 수정이 실패하였습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'bbss.jsp'");
                script.println("</script>");
                }



        }


    %>
</body>
</html>