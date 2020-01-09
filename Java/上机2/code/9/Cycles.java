public class Cycles{
public static void main(String[] args){
	Unicycle u=new Unicycle();
	Bicycle b=new Bicycle();
	Tricycle t=new Tricycle();
	Cycle cyc=new Cycle();
	cyc.ride(u);	//test 2 duotai 
	cyc.ride(b);
	cyc.ride(t);
	if (u instanceof Unicycle)
		((Unicycle)u).balance();
	if (b instanceof Bicycle)
		((Bicycle)b).balance();
}
}

class Cycle {
	int wnum;
	void ride(Cycle c) {
		System.out.println(c.wheel());
	}
	int wheel() {
		return this.wnum;
	}
}

class Unicycle extends Cycle{
	int wnum=1;
	int wheel() {
		return this.wnum;
	}
	void balance() {
		System.out.println("balance1");
	}
}

class Bicycle extends Cycle{
	int wnum=2;
	int wheel() {
		return this.wnum;
	}
	void balance() {
		System.out.println("balance2");
	}
}

class Tricycle extends Cycle{
	int wnum=3;
	int wheel() {
		return this.wnum;
	}
}