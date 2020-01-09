public class NewRectangle{
	private double width=0.0;
	private double height=0.0;
	
	public boolean setWidthAndHeight(double w,double h){
		if(w > 0.0 && h > 0.0){
			width = w;
			height = h;
			return true;
		}
		return false;
	}

	public double getArea(){
		return width*height;
	}
	public double getPerimeter(){
		return 2*(width+height);
	}
	
	public static void main(String[] args){
		NewRectangle rect=new NewRectangle();
		if( rect.setWidthAndHeight(3.0,3.0) ){
			System.out.println(rect.width+"; "+rect.height);
			System.out.println("Area of Rectangle: "+rect.getArea());
			System.out.println("Perimeter of Rectangle: "+rect.getPerimeter());
		}
	}
}