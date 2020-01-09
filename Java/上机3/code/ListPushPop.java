import java.util.LinkedList;

public class ListPushPop {
	public void getList(String str) {
		LinkedList<String> list = new LinkedList<String>();
		for(int i = 0, len = str.length(); i < len; i++) {
			char c = str.charAt(i);
			if(c == '+' && i < len -1) {
				list.addFirst(str.charAt(i + 1) + "");
			} else if(c == '-') {
				if(list.size() > 0) {
					System.out.print(list.removeFirst() + "\n");
				}
			}
		}
		if(list.size() == 0) {
			System.out.print("list is NULL");
		} else {
			System.out.print("The last content is: ");
			for(int i = 0, len = list.size(); i < len; i++) {
				System.out.print(list.get(i));
			}
		}
	}
	public static void main(String[] args) {
		new ListPushPop().getList("+U+n+c---+e+r+t---+a-+i-+n+t+y---+-+r+u--+1+e+s---");
	}
}