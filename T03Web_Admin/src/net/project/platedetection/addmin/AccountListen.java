package net.project.platedetection.addmin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class AccountListen
 *
 */
@WebListener
public class AccountListen implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public AccountListen() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent event)  { 
    	//做資料庫的增聽
    	//資料庫名稱
    	try {
			Class.forName("com.mysql.jdbc.Driver");
			//
			Connection con = DriverManager.getConnection("jdbc:mysql://db4free.net:3306/project_t03_plat?useSSL=false&serverTimezone=CST","project_t03","12345t03");
			
			//連線資料庫
			ServletContext ctx = event.getServletContext();
			ctx.setAttribute("mycon", con);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }
	
}
