package utils.service.client;



public class Detect {
	
	private boolean flag;
	private String plate;
	
	
	public boolean getFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public String getPlate() {
		return plate;
	}
	public void setPlate(String plate) {
		this.plate = plate;
	}
	
	public Detect() {
		super();
		flag = false;
		plate = "";
	}
	
	public Detect(boolean flag,String plate) {
		this.flag = flag ;
		this.plate = plate ;
	}
	
}
