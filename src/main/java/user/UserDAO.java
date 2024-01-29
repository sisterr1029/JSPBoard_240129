package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO { //DAO란 데이터 접근 객체의 약자로 실질적으로 데이터베이스에서 회원정보를 불러오거나 데이터베이스에 회원정보를 넣고자 할 때 사용하는 것.

    private Connection conn; //데이터베이스에 접근하게 해주는 하나의 객체.
    private PreparedStatement pstmt; //자바는 쿼리문을 사용할 때 java.sql에 있는 statement를 사용하는데, 이는 SQL문을 실행할 때 사용하는 인터페이스임.
    // Statement는 select * from user > parse(구문 분석) > bind(치환) > execute(실행) > patch(인출) 의 방식을 가짐. 즉 쿼리문을 읽어오는 것이라 볼 수 있음.
    // 여기서 Prepared가 붙게되면 1단계인 parse가 캐싱되어 보다 빠른 속도로 성능이 향상되며, SQL Injection(악성해킹)을 방어할 수 있다.
    private ResultSet rs; // 어떠한 정보를 담을 수 있는 하나의 객체. 결과저장

    public  UserDAO() { // 하나의 객체로 만들었을 때 자동으로 데이터베이스 커넥션이 이루어질 수 있게 해줘야함.
        try{
            String dbURL = "jdbc:mysql://localhost:3306/BBSS?useUnicode=true&characterEncoding=UTF-8"; // 내 컴퓨터 3306 포트에 BBSS에 접속할 수 있게 해줌. BBSS?serverTimezone=UTC
            String dbID = "root"; // root라는 아이디에 접속할 수 있게 해줌.
            String dbPassword = "0000";
            Class.forName("com.mysql.cj.jdbc.Driver"); // mysql의 드라이버를 찾을 수 있도록함. 드라이버란 mysql에 접속할 수 있도록 매개체역할을 해주는 라이브러리임.
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 커넥션은 드라이버매니저를 통해 url과 id, password를 통해 접속할 수 있도록 한다.
        } catch (Exception e) {
            e.printStackTrace(); // 오류가 무엇인지 출력해주는 것.
        }
    }

    public  int login(String userID, String userPassword) { //userID와 패스워드를 받아서 처리할 수 있도록 함
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; // 실제로 데이터베이스에 입력할 명령어를 SQL 문장으로 만들어줌. ?는 사용자의 아이디를 입력받아 해당 아이디가 실재하는지,
        // 존재한다면 아이디에 해당하는 비밀번호가 무엇인지 가져와준다.
        // USER테이블에서 해당 사용자의 비밀번호를 가져올 수 있게함.
        try {
            pstmt = conn.prepareStatement(SQL); //PreparedStatement에 어떠한 정해진 SQL문장을 데이터베이스에 삽입하는 형식으로 인터페이스를 가져옴.
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery(); // 결과를 담을 수 있는 하나의 객체에다가 실행한 결과를 담아줌. 여기서 executeQuery란 결과를 반환해주는 객체임.
            if (rs.next()) {
                if(rs.getString(1).equals(userPassword))  // getString(1) 은 결과로 나온 Password를 받아서 equals 접속을 시도한 userPassword와 동일하다면
                    return 1; // return 1을 반환해줌. (로그인 성공), 결과가 존재한다면 이 곳이 실행되고,
                else
                    return 0;
            }
            return -1; // (로그인 실패), 존재하지않는다면 이 곳이 실행됨. return-1이란 아이디가 없다는 것을 알려주는 것.
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류를 의미함
    }

    public int join(User user) { //한 명의 사용자를 입력받을 수 있게 함. User클래스를 이용해서 만들어질 수 있는 하나의 인스턴스가 됨.
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate(); //해당 스테이트먼트를 실행한 그 결과를 넣어줄 수 있또록 함.
        } catch(Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터 베이스 오류
    }
}
