package two.mine.service;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;


public class Mine {

    private int xSize;
    private int ySize;

    public String[][] array;
    
    /* 김재간 - 내가 추가한 부분 */ 
    public List<String> list = new ArrayList<String>();
    
    
    public Mine(int xSize, int ySize) {
        this.xSize = xSize;
        this.ySize = ySize;
        this.array = new String[this.xSize][this.ySize];
    }

    public Mine() {

	}

	public Mine(int i, int j, String[][] javaMineArray) {
		System.out.println("이리오너라");
		this.array = new String[i][j];
		for(int x = 0 ; x<i;x++){
			for(int y = 0 ; y<j;y++){
				//System.out.print(javaMineArray[x][y]);
				this.array[x][y] = javaMineArray[x][y];
				//System.out.print(array[x][y]);
			}
			System.out.println();
		}
		
		
	}

	public void setMineData(int mineCount) {

        for(int i=0;i<this.xSize;i++) {
            for(int j=0;j<this.ySize;j++) {
                this.array[i][j] = "x"; //일단 모든 배열 위치에 값을 하나씩 임의로 넣어줌
            }
        }

        Random xData = new Random(); //임의 배치용 랜덤 함수
        Random yData = new Random(); //임의 배치용 랜덤 함수
        
        for(int i=0;i<mineCount;i++) { //지뢰 놓는 곳.
           
            int xValue = xData.nextInt(this.xSize);
            int yValue = yData.nextInt(this.ySize);

            if(this.array[xValue][yValue] =="") { //빈곳이면 
               this.array[xValue][yValue] = "9";   //지뢰 투입
            }else {
               while(this.array[xValue][yValue] == "9") {//중복되면 다시 배치하도록 하는 곳
                  xValue = xData.nextInt(this.xSize);
                  yValue = yData.nextInt(this.ySize);
               }
               
               this.array[xValue][yValue] = "9";   //while문 탈출했을때 지뢰 투입
            }
        }
    }
       
    public void printMineData() {
        for(int i=0;i<this.xSize;i++) {
            for(int j=0;j<this.ySize;j++) {
                   this.array[i][j] = array[i][j];
                System.out.print(this.array[i][j] +  "("+i+","+j+")  ");
                 
                   
            }
            System.out.println();
   
        }
        /* 김재간 - 내가 추가한 부분 */ 
        
        // 4,4 를 클릭한다고 가정한다.
        // 클릭한 곳에 주위 0값을 찾아낸다.
          }


   public void analysisData() {
        for(int i=0;i<this.xSize;i++) {
            for(int j=0;j<this.ySize;j++) {
                if(this.array[i][j] == "x") { // 지뢰가 아닌곳 탐색
                    this.array[i][j] = "" + getMineNumber(i, j); // 메소드 실행 주변 지뢰 개수에 따른 숫자 
                }
            }
        }
    }

    public int getMineNumber(int x, int y) {//주위에 마인 개수가 몇개인지 표시
        int result = 0;

        if(isExistMine(x-1, y-1)) result++;
        if(isExistMine(x-1, y)) result++;
        if(isExistMine(x-1, y+1)) result++;
        if(isExistMine(x, y-1)) result++;
        if(isExistMine(x, y+1)) result++;
        if(isExistMine(x+1, y-1)) result++;
        if(isExistMine(x+1, y)) result++;
        if(isExistMine(x+1, y+1)) result++;

        return result; //최종 지뢰 개수 반환
    }

    public boolean isExistMine(int x, int y) {
        if(x < 0 || x >= xSize || y < 0 || y >= ySize) {
            return false;
        }
        else {
            return (this.array[x][y] == "9");
        }
    }
    
   /* 김재간 - 내가 추가한 부분 */ 
    public List<String> zeroSearch(int i , int j, String level) {
        if(this.array[i][j].equals("0")) {   // 열어야 한다.
             // 자신먼저 해시맵에 넣어준다.
             String myArry = i+"/"+j;
             System.out.println(myArry);
             this.list.add(myArry);
             
         // 위쪽 탐색
             try { 

                i--;
                 if(array[i][j].equals("0")){
                    String array =  i+"/"+j;
                    if(!(this.list.contains(array))) {                   
                       //System.out.println("재귀 실행");
                       zeroSearch(i,j,level);
              }
                 }
                 i++;
                 }
            catch (Exception e) {
             i=0;
           }           
             //아래 탐색
             try { 
                
                i++;
                 if(array[i][j].equals("0")){
                   String array =  i+"/"+j;
                   if(!(this.list.contains(array))) {            
                     // System.out.println("재귀 실행");
                       zeroSearch(i,j,level);
              }
                 }
                 i--;
             } catch (Exception e) {
            	 if(level.equals("easy")){
            		 i=8;	 
            	 }else{
            		 i=15;
            	 }
                 
             }
           // 오른쪽 탐색 
             try { 

                j++;
                 if(array[i][j].equals("0")){
                   String array =  i+"/"+j;
                   if(!(this.list.contains(array))) {
                    //  System.out.println("재귀 실행");
                       zeroSearch(i,j,level);
                   }
                  }
                 j--;

           } catch (Exception e) {
        	   if(level.equals("easy")){
          		 j=8;	 
          	 }else if(level.equals("normal")){
          		 j=15;
          	 }else{
          		 j=29;
          	 }
          	 }
             
             //왼쪽 탐색
             try { 
                
                j--;
                 if(array[i][j].equals("0")){
                   String array =  i+"/"+j;
                   if(!(this.list.contains(array))) {
                     // System.out.println("재귀 실행");
                      zeroSearch(i,j,level);
              }
                   }
                 j++;    
           } catch (Exception e) {
             j=0;
           }
                 }   else {
                     System.out.println(i+" "+j+"숫자자리 자리");
                 }
 
       
        return list;
    }
    
    public static void main(String[] args){
       
       Mine game = new Mine(16,30);
        game.setMineData(99);
        //game.printMineData();
        
        game.analysisData();
        System.out.println();
        System.out.println();
        game.printMineData();
        System.out.println();
        
      /*  
        // 4,4 를 클릭한다고 가정한다.
        int x = 4, y = 4 ;
        // 클릭한 곳에 주위 0값을 찾아낸다.
        game.zeroSearch(x, y);
        System.out.println("fianl size : "+ game.list.size());    */
        
       /* for(int i = 0 ; i<16;i++) {
           for(int j=0; j<30; j++) {
           
               System.out.print(game.array[i][j]);
           }
           System.out.println();
        }*/
       
    }

}