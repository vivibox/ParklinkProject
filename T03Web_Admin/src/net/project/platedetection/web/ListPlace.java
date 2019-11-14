package net.project.platedetection.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.project.platedetection.dao.CarDAO;
import net.project.platedetection.model.Place;
import utils.service.client.Client;
import utils.service.client.Detect;



/**
 * Servlet implementation class ListPlace
 */
@WebServlet("/ListPlace")
public class ListPlace extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CarDAO carDAO;   
    /**
     * @throws Exception 
     * @see HttpServlet#HttpServlet()
     */
    public ListPlace() throws Exception {
        super();
        carDAO = new CarDAO();
      
        
    }
   
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().setAttribute("userPlace", "¿é¤J½d¨Ò:ABC1234");
		
		List<Place> listPlace = carDAO.selectAll();
		int conEmpty = 0 ;
		for(int i = 0 ;i<listPlace.size();i++) {
			String place_name = listPlace.get(i).getPlace_name();
			Boolean isEmpty = listPlace.get(i).isEmpty();
			if(isEmpty == true) {
				conEmpty+=1 ;
				request.getSession().setAttribute("listPlace"+i, place_name);
			}
			else {
				request.getSession().setAttribute("listPlace"+i, "notEmpty");
			}
		}
		request.getSession().setAttribute("placeSize", listPlace.size());
		request.getSession().setAttribute("conEmpty", conEmpty);
		RequestDispatcher dispatcher = request.getRequestDispatcher("homePage.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
