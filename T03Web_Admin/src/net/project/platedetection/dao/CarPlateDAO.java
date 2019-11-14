package net.project.platedetection.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.project.platedetection.model.Car;
import net.project.platedetection.model.Place;

public class CarPlateDAO {
//	public final String DATABASE_NAME = "project_t03_plat" ;
//	private String jdbcURL = "jdbc:mysql://db4free.net:3306/" + DATABASE_NAME + "?useSSL=false&serverTimezone=CST";
//	private String jdbcUsername = "project_t03";
//	private String jdbcPassword = "12345t03";
	
	public final String DATABASE_NAME = "project_t03_platedetection" ;
	private String jdbcURL = "jdbc:mysql://localhost:3306/" + DATABASE_NAME + "?useSSL=false&serverTimezone=CST";
	private String jdbcUsername = "root";
	private String jdbcPassword = "12345678";
	
	
	private static final String INSERT_CAR_SQL = "INSERT INTO car_management" + "  (car_plate, car_place, enter_time) VALUES "
			+ " (?, ?, ?);";

	
	private static final String SELECT_CAR_BY_PLATE = "select car_plate, car_place, enter_time from car_management where car_plate =?";
	private static final String SELECT_ALL_CARS = "select * from car_management ORDER BY car_management.enter_time DESC";
	private static final String DELETE_CAR_SQL = "delete from car_management where car_plate = ?;";
//	private static final String UPDATE_USERS_SQL = "update car_management set name = ?,email= ?, country =? where id = ?;";

	
	public CarPlateDAO() {
	}
	
	protected Connection getConnection() {
		Connection connection = null;
		try {
	//		Class.forName("com.mysql.jdbc.Driver");
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
	
	public void insertCar(Car car) throws SQLException {
		System.out.println(INSERT_CAR_SQL);
		// try-with-resource statement will auto close the connection.
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CAR_SQL)) {
			preparedStatement.setString(1, car.getCar_plate());
			preparedStatement.setString(2, car.getCar_place());
			preparedStatement.setString(3, car.getEnter_time());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			printSQLException(e);
		}
	}

	public List<Car> selectAllCars() {

		// using try-with-resources to avoid closing resources (boiler plate code)
		List<Car> cars = new ArrayList<>();
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();

				// Step 2:Create a statement using connection object
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CARS);) {
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				int id = rs.getInt("id");
				String car_plate = rs.getString("car_plate");
				String car_place = rs.getString("car_place");
				String enter_time = rs.getString("enter_time");
				String exit_time = rs.getString("exit_time");
				String url = rs.getString("url");
				Boolean isExit = rs.getBoolean("isExit");
				cars.add(new Car(id, car_plate, car_place, enter_time, exit_time, url, isExit));
			}

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		return cars;
	}
	
	public Car selectCar(String car_plate) {
		Car car = null;
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();
				// Step 2:Create a statement using connection object
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CAR_BY_PLATE);) {
			preparedStatement.setString(1, car_plate);
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				int id = rs.getInt("id");
				String car_place = rs.getString("car_place");
				String enter_time = rs.getString("enter_time");
				String exit_time = rs.getString("exit_time");
				String url = rs.getString("url");
				Boolean isExit = rs.getBoolean("isExit");
				car = new Car(id, car_plate, car_place, enter_time, exit_time, url, isExit);
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return car;
	}

	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
	}

}
