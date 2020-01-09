import java.util.LinkedList;

public class Stack<T> {
	private LinkedList<T> stack;
	public Stack() {
		stack = new LinkedList<T>();
	}
	public void push(T obj) {
		stack.addFirst(obj);
	}
	public T top() {
		if(!isEmpty()) {
			return stack.getFirst();
		} else {
			return null;
		}
	}
	public T pop() {
		if(!isEmpty()) {
			return stack.removeFirst();
		} else {
			return null;
		}
	}

	public boolean isEmpty() {
		return stack.isEmpty();
	}
	public Object peek() {
		return stack.peek();
	}
	public static void main(String[] args) {
		String[] list = "1 2 3 4 5 6 7".split(" ");
		Stack<String> stack = new Stack<String>();
		for(String obj : list) {
			stack.push(obj);
		}
		while(stack.peek() != null) {
			System.out.print(stack.pop() + " ");
		}
	}
}