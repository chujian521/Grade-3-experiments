import java.util.*;
import java.io.*;

public class KeywordsAnalyzer{
	public static void main(String[] args){
		String str,s;
		s="";
		final String[] KEYWORDS = { //enum for Keywords
        "abstract", "assert", "boolean", "break", "byte",
        "case", "catch", "char", "class", "const",
        "continue", "default", "do", "double", "else",
        "enum", "extends", "final", "finally", "float",
        "for", "goto", "if", "implements", "import",
        "instanceof", "int", "interface", "long", "native",
        "new", "package", "private", "protected", "public",
        "return", "strictfp", "short", "static", "super",
        "switch", "synchronized", "this", "throw", "throws",
        "transient", "try", "void", "volatile", "while"
		};
		try {//read the file
            BufferedReader in = new BufferedReader(new FileReader(".\\TestMap.java"));
            while ((str = in.readLine()) != null) {
                s=s+str;
            }
        } 
		catch (IOException e) {
			e.printStackTrace();
        }
		Map<String,Integer> statistics=new HashMap<String,Integer>();
		Map<String,Integer> statistics1=new HashMap<String,Integer>();
		Set<String> keyword=new HashSet<String>();
		//keyword = Set.of(word);
		for (String word : KEYWORDS) { //tansform the enum to set
            keyword.add(word);
        }

		StringTokenizer st=new StringTokenizer(s,",.;:-\" ={}()[]	\n\t\r+-");//word frequency statistics
			while(st.hasMoreTokens()){
				String key=st.nextToken();
				if(statistics.get(key)!=null){
					statistics.put(key, statistics.get(key)+1);
				}
				else
					statistics.put(key, 1);
			}
		st=new StringTokenizer(s,",.;:-\" ={}()[]	\n\t\r+-");//Keyword frequency statistics
			while(st.hasMoreTokens()){
				String key=st.nextToken();
				if(statistics1.get(key)!=null && keyword.contains(key)){
					statistics1.put(key, statistics1.get(key)+1);
				}
				else if(keyword.contains(key))
					statistics1.put(key, 1);
			}
		System.out.println("word frequency statistics is:\n");
		System.out.println(statistics);
		System.out.println("\nKeyword frequency statistics is:\n");
		System.out.println(statistics1);
	}
}