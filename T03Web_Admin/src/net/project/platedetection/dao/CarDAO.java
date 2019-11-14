package net.project.platedetection.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import net.project.platedetection.model.Place;

public class CarDAO {
//	public final String DATABASE_NAME = "project_t03_plat" ;
//	private String jdbcURL = "jdbc:mysql://db4free.net:3306/" + DATABASE_NAME + "?useSSL=false&serverTimezone=CST";
//	private String jdbcUsername = "project_t03";
//	private String jdbcPassword = "12345t03";

	public final String DATABASE_NAME = "project_t03_platedetection" ;
	private String jdbcURL = "jdbc:mysql://localhost:3306/" + DATABASE_NAME + "?useSSL=false&serverTimezone=CST";
	private String jdbcUsername = "root";
	private String jdbcPassword = "12345678";
	
	private static final String INSERT_PLACE_SQL = "INSERT INTO place_management" + "  (place_name, car_plate, isEmpty,enter_time) VALUES "
			+ " (?, ?, ?);";

	private static final String SELECT_CAR_BY_PLACE = "select place_name,car_plate, enter_time, isEmpty from place_management where place_name =?";
	private static final String SELECT_PLACE_BY_PLATE = "select id,place_name,car_plate, enter_time, isEmpty from place_management where car_plate =?";
	private static final String SELECT_ALL_PLACE = "select * from place_management";
//	private static final String DELETE_CAR_SQL = "delete from place_management where place_name = ?;";
	private static final String UPDATE_PLACE_SQL = "update place_management set place_name = ?,car_plate= ?, isEmpty =? ,enter_time =? where place_name = ?;";

	public CarDAO() {
	}
	
	protected Connection getConnection() {
		Connection connection = null;
		try {
//			Class.forName("com.mysql.jdbc.Driver");
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	
	}
	
	public List<Place> selectAll() {

		// using try-with-resources to avoid closing resources (boiler plate code)
		List<Place> places = new ArrayList<>();
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();

				// Step 2:Create a statement using connection object
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PLACE);) {
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				int id = rs.getInt("id");
				String place_name = rs.getString("place_name");
				String car_plate = rs.getString("car_plate");
				Boolean isEmpty = rs.getBoolean("isEmpty");
				String enter_time = rs.getString("enter_time");
				places.add(new Place(id, car_plate, place_name, isEmpty ,enter_time));
			}

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return places;
	}
	
	public List<String> selectAllPlates() {

		// using try-with-resources to avoid closing resources (boiler plate code)
		List<String> allPlates = new ArrayList<>();
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();

				// Step 2:Create a statement using connection object
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PLACE);) {
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				int id = rs.getInt("id");
				String place_name = rs.getString("place_name");
				String car_plate = rs.getString("car_plate");
				Boolean isEmpty = rs.getBoolean("isEmpty");
				String enter_time = rs.getString("enter_time");
				allPlates.add(car_plate);
			}
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return allPlates;
	}
	
	
	public Place selectPlate(String car_plate) throws SQLException {
		Place place = null;
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();
				// Step 2:Create a statement using connection object
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PLACE_BY_PLATE);) {
			//(1, car_plate) 在 SELECT_PLACE_BY_PLATE 內第一個?的資料
			preparedStatement.setString(1, car_plate);
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				int id = rs.getInt("id");
				String place_name = rs.getString("place_name");
				Boolean isEmpty = rs.getBoolean("isEmpty");
				String enter_time = rs.getString("enter_time");
				place = new Place(id, car_plate ,place_name, isEmpty ,enter_time);
			}
		} 
		return place;
	}
	
}
