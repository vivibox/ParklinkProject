package net.project.platedetection.addmin;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ValidateColorServlet
 */
@WebServlet("/ValidateColorServlet")
public class ValidateColorServlet extends HttpServlet {
	public static final String CHECK_CODE_KEY = "CHECK_CODE_KEY";
	private static final long serialVersionUID = 1L;
	private int width = 152;
	private int height = 30;
	private int codeCount = 4;

	private int fontHeight = 3;

	private int codeX = 0;
	private int codeY = 0;
	String str = "0123456789" + "abcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	char[] codeSequence = str.toCharArray();

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		fontHeight = height - 2;
		codeX = width / (codeCount + 2);
		codeY = height - 4;
	}

	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.service(req, resp);
		BufferedImage buffIMG = null;
		buffIMG = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

		Graphics2D graphics = null;
		graphics = buffIMG.createGraphics();
		
		graphics.setColor(Color.WHITE);

		graphics.fillRect(0, 0, width, height);
		Font font = null;
		font = new Font("", Font.BOLD, fontHeight);
		graphics.setFont(font);	

		graphics.setColor(Color.BLACK);

		graphics.drawRect(0, 0, width - 1, height - 1);

		Random random = null;
		random = new Random();
		graphics.setColor(Color.PINK);
		for (int i = 0; i < 55; i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int x1 = random.nextInt(20);
			int y1 = random.nextInt(20);
			graphics.drawLine(x, y, x + x1, y + y1);

		}
		StringBuffer randomCode;
		randomCode = new StringBuffer();

		for (int i = 0; i < codeCount; i++) {
			String strRand = String.valueOf(codeSequence[random.nextInt(62)]);
			randomCode.append(strRand);

			graphics.setColor(Color.ORANGE);
			graphics.drawString(strRand, (i + 1) * codeX, codeY);

		}
		System.out.println(randomCode);
		//¼g¤Jsession
		HttpSession session = req.getSession();
		session.setAttribute(CHECK_CODE_KEY, randomCode.toString());
		
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);
		
		ServletOutputStream sos = null;
		sos = resp.getOutputStream();
		ImageIO.write(buffIMG, "jpeg", sos);
		sos.close();
		
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ValidateColorServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

