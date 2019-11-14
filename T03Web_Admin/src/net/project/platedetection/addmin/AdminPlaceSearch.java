package net.project.platedetection.addmin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.project.platedetection.dao.CarDAO;
import net.project.platedetection.model.Place;

/**
 * Servlet implementation class AdminPlaceSearch
 */
@WebServlet("/AdminPlaceSearch")
public class AdminPlaceSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CarDAO carDAO;    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPlaceSearch() {
        super();
        carDAO = new CarDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String carPlate1 = request.getParameter("CarPlate");
		String carPlate2=carPlate1.replace(" ","").toUpperCase();
		String carPlate=carPlate2.replaceAll("[\\pP\\p{Punct}]","");
		List<Place> listPlace = carDAO.selectAll();
		Boolean carExist = false ;
		
		for(int i = 0 ;i<listPlace.size();i++) {
			String plate_all = listPlace.get(i).getCar_plate();
			if(carPlate.equals(plate_all)) {
				carExist = true ;
			}
		}
		
		String isUserPlace = null ;
		if(carExist == true) {
			try {
				Place userInfo = carDAO.selectPlate(carPlate);
				String userPlace = "您的車停放於"+userInfo.getPlace_name();
				isUserPlace = userInfo.getPlace_name() ;
				String userEnterTime = userInfo.getEnter_time();
				request.getSession().setAttribute("userPlace", userPlace);
				request.getSession().setAttribute("userEnterTime", userEnterTime);
				System.out.print(isUserPlace);
//				RequestDispatcher dispatcher = request.getRequestDispatcher("homePage.jsp");
//				dispatcher.forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else {
			request.getSession().setAttribute("isUserPlace", "noCar");
			request.getSession().setAttribute("userPlace", "無此車號/或是格式錯誤=>範例:ABC1234");	
		}
	
		
		
		
		
		int conEmpty = 0 ;
		for(int i = 0 ;i<listPlace.size();i++) {
			String place_name = listPlace.get(i).getPlace_name();
			Boolean isEmpty = listPlace.get(i).isEmpty();
			if(place_name.equals(isUserPlace)) {
				request.getSession().setAttribute("isUserPlace", place_name);
				request.getSession().setAttribute("listPlace"+i, "<img src='images/zone/car.jpg' alt='' class='img-responsive' style='border:2px darkorange dashed;'/>");
			}
			else if(isEmpty == true) {
				conEmpty+=1 ;
				request.getSession().setAttribute("listPlace"+i, place_name);
			}
			else {
				request.getSession().setAttribute("listPlace"+i, "notEmpty");
			}
		}
		request.getSession().setAttribute("placeSize", listPlace.size());
		request.getSession().setAttribute("conEmpty", conEmpty);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin_edit.jsp");
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
