import java.util.Arrays;
public class Xixuegui_num {  
    public static void main(String[] args) {
            int x , y ,z ;
            for(x = 1000; x<9999;x ++ ) {
                if(x %100 == 0) { 
                    continue;
                }
                for(y =10;y<100;y++) {
                    for(z =10; z<100; z++) {
                        if(y*z == x ) {
                           String[] a = String.valueOf(x).split("");
                           String[] b = String.valueOf(y+""+z).split("");
                           Arrays.sort(a);
                           Arrays.sort(b);
                           if(Arrays.equals(a, b)){
                                System.out.println(x+"," + y +"," +z);
                                y=100;
                        }                   
                    }               
                }           
            }       
        }   
    }
}
