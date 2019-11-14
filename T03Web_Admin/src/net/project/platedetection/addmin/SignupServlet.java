package net.project.platedetection.addmin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				// set UTF-8
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				
				//接收表單變數request.getParameter("name")
				String userName = request.getParameter("UserName");
				String pwd = request.getParameter("pwd");
				String email = request.getParameter("email");
				
				
				//取得增聽資料庫帳號
				ServletContext ctx = getServletContext();
				Connection con = (Connection) ctx.getAttribute("mycon");
				
				try {
					//選擇資料庫表單
					PreparedStatement ps = con.prepareStatement("select * from account",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = ps.executeQuery();
					
					//探索資料庫中所有表單
					boolean rightAcc= true ;
					while(rs.next()) {
						//比對名稱與帳號
						if((rs.getString("name")).equals(userName)){
							rightAcc= false ;
							out.print("已有相同帳號!!<br>");
							request.getRequestDispatcher("signup.jsp").include(request, response);
//							String rightName = rs.getString("name") ;
						}
					}
					if(rightAcc == true) {
						//將資料新增至資料庫
						String sql = "insert into account(name,password,email) values('"+userName+"','"+pwd+"','"+email+"')";
						ps.executeUpdate(sql);
//						將資料新增至session
						HttpSession session = request.getSession();
						session.setAttribute("name", userName);
						out.print("註冊成功<br>Welcome,"+ userName);
						request.getRequestDispatcher("login_signup.jsp").include(request, response);
					}
//					不能加con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				out.close();
}
		
		
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
