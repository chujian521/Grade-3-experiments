import java.util.*;
import java.io.*;
 
public class FileSearch{
    public static void main(String[] args){
        List<String> paths = new ArrayList<String>();
		String name = ".java";
        paths = getAllFilePaths(new File("./"),paths);
         for(String path:paths){
			 if(path.indexOf(name) != -1){
				 System.out.println(path);  
				}
			 }
    }
    
    private static List<String> getAllFilePaths(File filePath,List<String> filePaths){
         File[] files = filePath.listFiles();
         if(files == null){
             return filePaths;    
         }    
         for(File f:files){
             if(f.isDirectory()){
                 filePaths.add(f.getPath());
                 getAllFilePaths(f,filePaths);
            }else{
                filePaths.add(f.getPath());
            }    
        }
        return filePaths;
    }
}