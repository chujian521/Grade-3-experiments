public class NewRectangle {
	double width,height;
	Point p=new Point();
	NewRectangle(){
		p.x=0.0;
		p.y=0.0;
	}
	NewRectangle(double a,double b){
		p.x=0.0;
		p.y=0.0;
		this.width=a;
		this.height=b;
	}
	NewRectangle(double a,double b,double c,double d){
		p.x=c;
		p.y=d;
		this.width=a;
		this.height=b;
	}
	double getArea(){
		return this.width*this.height;
	}
	double getPerimeter(){
		return 2*(this.width+this.height);
	}
	boolean bPointIn(Point p) 
	{
		if(p.x>this.p.x&&p.x<(this.p.x+this.width)&&p.y>this.p.y&&p.y<(this.p.y+this.height))
			return true;
		else
			return false;
	}
	boolean bRectangleIn(NewRectangle r) {
		if(r.p.x>this.p.x&&r.p.y>this.p.y&&(r.width+r.p.x)<(this.width+this.p.x)&&(r.height+r.p.y)<(this.height+this.p.y))
			return true;
		else
			return false;
	}
	boolean bRectangleLap(NewRectangle r) {
		if(r.p.x<(this.p.x+this.width)&&(r.p.x+r.width)>this.p.x&&r.p.y<(this.p.y+this.height)&&(r.p.y+r.height)>this.p.y)
			return true;
		else
			return false;
	}
	public static void main(String[] args) {
		NewRectangle rgl=new NewRectangle();
		System.out.println(rgl.getArea());
		System.out.println(rgl.getPerimeter());
		NewRectangle rgl1=new NewRectangle(5.0,6.0);
		System.out.println(rgl1.getArea());
		System.out.println(rgl1.getPerimeter());
		Point p=new Point(4.9,5.8);      //Test p in r2
		NewRectangle rgl2=new NewRectangle(5.0,6.0,0,0);
		System.out.println(rgl2.bPointIn(p));  
		NewRectangle rgl3=new NewRectangle(5,4,1,1);   //Test r2 r3 
		System.out.println(rgl2.bRectangleIn(rgl3));
		NewRectangle rgl4=new NewRectangle(2.1,4,-2,-1);   //Test r2 r4
		System.out.println(rgl2.bRectangleLap(rgl4));
	}
}


class Point {
	double x,y;
	Point(){}
	Point(double a,double b){
		this.x=a;
		this.y=b;
	}
	double distance(Point p) 
	{
		return Math.sqrt(Math.pow((p.x-this.x),2)+Math.pow((p.y-this.y),2));
	}
}