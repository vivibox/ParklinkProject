package net.project.platedetection.addmin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class SignupCodeFilter
 */
@WebFilter("/SignupServlet")
public class SignupCodeFilter extends HttpServlet implements Filter {
	private static final String CHECK_CODE_KEY="CHECK_CODE_KEY" ;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupCodeFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		HttpServletRequest req;
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String parameterCode = request.getParameter("checkcode");
		String company_code = request.getParameter("code");
		HttpSession session = ((HttpServletRequest) request).getSession();
		String sessionCode = (String) session.getAttribute(CHECK_CODE_KEY);
		if(parameterCode != null && parameterCode.equalsIgnoreCase(sessionCode) && company_code.equals("t03project")) {
			System.out.println("success");
			session.removeAttribute(CHECK_CODE_KEY);
			// pass the request along the filter chain
			chain.doFilter(request, response);
		} else {
			out.print("ÅçÃÒ¿ù»~!!<br>");
			session.setAttribute("errorMessage", "failed");
			request.getRequestDispatcher("signup.jsp").include(request, response);
			
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
