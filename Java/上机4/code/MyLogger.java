import java.util.logging.*;
import java.io.*;
import java.util.Date;

class MyLogger1 extends Thread {
	static void Logger1() {
		Logger logger1 = Logger.getAnonymousLogger();
		int rand1 = (int)(Math.random() * 100);
		for(int i = 0; i < 100; i++) {
			if(i == rand1) {
				logger1.log(Level.INFO, "logger1's log record\n");
			}
		}
	}
}

class MyLogger2 {
	static int i = 1;
	private static MyLogger2 mylogger2 = new MyLogger2();
	public MyLogger2() {

	}
	public static MyLogger2 getInstance2() {
		return mylogger2;
	}
	public void print() {
		int rand2 = (int)(Math.random() * 100);
		for(int t = 0; t < 100; t++) {
			if(t == rand2) {
				Date date = new Date();
				System.out.println(date.getTime() + "\n" +"logger2's log record\n");
			}
		}
	}
}

public class MyLogger {
	FileHandler fhandler;
	Logger logger;
	MemoryHandler mhandler;
	MyLogger() {
		try {
			fhandler = new FileHandler("my.log", true);
			int numRec = 5;
			mhandler = new MemoryHandler(fhandler, numRec, Level.OFF);
			logger = Logger.getLogger("com.mycompany");
			logger.addHandler(mhandler);
		} catch(IOException e) {

		}
	}
	public static void main(String args[]) {
		MyLogger2 mylogger2 = new MyLogger2();
		MyLogger mt = new MyLogger();
		int trigger = (int)(Math.random() * 100);
		for(int i = 1; i < 100; i++) {
			MyLogger1.Logger1();
			mylogger2.print();
			mt.logger.log(Level.INFO,"log record" + i);
			if(i == trigger) {
				mt.mhandler.push();
				break;
			}
		}
	}
}