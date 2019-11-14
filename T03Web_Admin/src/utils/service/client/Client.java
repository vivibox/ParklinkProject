package utils.service.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import javax.servlet.http.HttpServletRequest;

// Client module with thread implement
public class Client implements Runnable {

	private Socket socket = null;
	private String ip = null;
	private int port = 0;
	
	private BufferedReader reader = null;
	private PrintWriter writer = null;
	private Detect detect = null;
	
	public Client() throws Exception {
		// TODO Auto-generated constructor stub
		ip = "127.0.0.1";
		port = 5001;
		socket = new Socket(ip, port);
		
		InputStreamReader isReader = new InputStreamReader(socket.getInputStream());
		reader = new BufferedReader(isReader);
		writer = new PrintWriter(socket.getOutputStream());
		System.out.println("Networking established...");
	}

	public Client(String ip, int port, Detect detect) throws Exception {
		
		this.ip = ip;
		this.port = port;
		socket = new Socket(ip, port);
		this.detect = detect ;
		
		InputStreamReader isReader = new InputStreamReader(socket.getInputStream());
		reader = new BufferedReader(isReader);
		writer = new PrintWriter(socket.getOutputStream());
		System.out.println("Networking established...");
	}
	
	public void run() {
		
		Thread readThread = new Thread(new ThreadHandler());
		readThread.start();
		
		String data = "";
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
		
		System.out.println("Translation start...");
		while(!data.equals("quit")) {
			
			try {
				data = input.readLine();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			writer.println(data);
			writer.flush();
		}
		
		try {
			readThread.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Port " + port + " disconnect...");
	}
	
	public void destroy() throws Exception {
		
		socket.close();
		reader.close();
		writer.close();
		socket = null;
		reader = null;
		writer = null;
	}
	
	// Thread start
	public class ThreadHandler implements Runnable {
	
		public void run() {
			
			String data = "";
			
			try {
				
				while((data = reader.readLine()) != null) {
					
					System.out.println(data);
					detect.setFlag(true);
					detect.setPlate(data);					
					if(data.equals("quit")) {
						
						break;
					}
				}
			} 
			
			catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	// Thread end
}


