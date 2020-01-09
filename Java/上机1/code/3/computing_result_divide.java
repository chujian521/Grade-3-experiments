public class computing_result_divide{
    public static void main(String[] args){
        float[] num = new float[7];
        int i,j;
        num[0] = 1f;
        num[1] = -1f;
        num[2] = +0f;
        num[3] = -0f;
        num[4] = 1f/0f;
        num[5] = -1f/0f;
        num[6] = 0.0f/0.0f;
        for(i = 0; i < 7; i++){
			for(j = 0; j < 7; j++){
				System.out.println(i +","+ j +": "+ num[i]/num[j]);
			}
        }
    }
}