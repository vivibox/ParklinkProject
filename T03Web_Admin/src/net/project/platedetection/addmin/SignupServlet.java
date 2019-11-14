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
				
				//��������ܼ�request.getParameter("name")
				String userName = request.getParameter("UserName");
				String pwd = request.getParameter("pwd");
				String email = request.getParameter("email");
				
				
				//���o�Wť��Ʈw�b��
				ServletContext ctx = getServletContext();
				Connection con = (Connection) ctx.getAttribute("mycon");
				
				try {
					//��ܸ�Ʈw���
					PreparedStatement ps = con.prepareStatement("select * from account",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = ps.executeQuery();
					
					//������Ʈw���Ҧ����
					boolean rightAcc= true ;
					while(rs.next()) {
						//���W�ٻP�b��
						if((rs.getString("name")).equals(userName)){
							rightAcc= false ;
							out.print("�w���ۦP�b��!!<br>");
							request.getRequestDispatcher("signup.jsp").include(request, response);
//							String rightName = rs.getString("name") ;
						}
					}
					if(rightAcc == true) {
						//�N��Ʒs�W�ܸ�Ʈw
						String sql = "insert into account(name,password,email) values('"+userName+"','"+pwd+"','"+email+"')";
						ps.executeUpdate(sql);
//						�N��Ʒs�W��session
						HttpSession session = request.getSession();
						session.setAttribute("name", userName);
						out.print("���U���\<br>Welcome,"+ userName);
						request.getRequestDispatcher("login_signup.jsp").include(request, response);
					}
//					����[con.close();
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
