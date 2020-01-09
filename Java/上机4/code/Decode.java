import java.util.*;
import java.io.*;

public class Decode{
	public static void main(String[] args) throws Exception {  
		String fileUrl = "cipher.txt";
        File file = new File(fileUrl);  
        String path = file.getPath();  
        if(!file.exists()){  
            return;  
        }   
        String destFile = "decrypt.txt";  
        File dest = new File(destFile);  
        InputStream in = new FileInputStream(fileUrl);  
        OutputStream out = new FileOutputStream(destFile);  
        byte[] buffer = new byte[1024];  
        int r;  
        byte[] buffer2=new byte[1024];  
        while (( r= in.read(buffer)) > 0) {  
            for(int i=0;i<r;i++)  
            {  
                byte b=buffer[i];  
                buffer2[i]=(byte)(b-(byte)5);  
            }  
            out.write(buffer2, 0, r);  
            out.flush();  
        }  
        in.close();  
        out.close();    
        System.out.println("Decode success!");  
    }
}