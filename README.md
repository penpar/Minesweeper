# Minesweeper &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://github.com/penpar/portfolio "> (뒤로 가기)</a>

### 프로젝트 기획

[Minesweeper_기획안.pdf](https://github.com/penpar/Minesweeper/files/2138340/Minesweeper.pdf)

### 주요 기술
• 참여도: 30% <br/> 
• 검색 결과 데이터 요청 및 출력: jQuery, Ajax, JSON <br/>
• 웹 화면 구성: HTML, CSS, JavaScript <br/>
• 결과를 얻어오기 위한 서버 처리: JAVA, Servlet, JSP, JSTL, EL <br/>
• 개발 환경 : Eclips, Oracle, Apache Tomcat v8.0 <br/>


### DB 구조
![db](https://user-images.githubusercontent.com/17943275/42738267-f483fde2-88bb-11e8-8a86-a9f322ecc74e.png)

### 처리한 알고리즘


#### 문제) 0~9의 값으로 된 2차원 배열에서 Player가 0인 값을 클릭 할 경우, 인접한 0의 값의 인덱스들을 저장한다.
![1](https://user-images.githubusercontent.com/17943275/42738922-834a3e6e-88c7-11e8-871a-393353fce52b.png)

```java

public List<String> zeroSearch(int i , int j, String level) { // 파라미터는 클릭한 인덱스 i,j  난이도를 나타내는 level.
        if(this.array[i][j].equals("0")) { // 클릭한 인덱스의 값이 0인지 판별한다.
             String myArry = i+"/"+j; 
             this.list.add(myArry); //해당 위치의 인덱스를 list에 저장한다.
             
         // 위쪽 탐색
             try { 
                i--; 
                 if(array[i][j].equals("0")){
                    String array =  i+"/"+j;
                    if(!(this.list.contains(array))) {  // contains를 이용하여 배열의 중복값이 있는지 확인한다.                      
                       zeroSearch(i,j,level); // 재귀 함수를 이용해 인접한 인덱스로 이동해 수행한다.
              }
                 }
                 i++;
                 }
            catch (Exception e) {
             i=0   // 인덱스 범위 초과로 인한 예외처리
           }           
           
             //아래 탐색
             try {
                i++;
                 if(array[i][j].equals("0")){
                   String array =  i+"/"+j;
                   if(!(this.list.contains(array))) {       
                       zeroSearch(i,j,level);
              }
                 }
                 i--;
             } catch (Exception e) {   
            	 if(level.equals("easy")){  // 난이도 별로 배열 크기가 다르기 때문에 레벨의 따른 인덱스 값 초기화해준다.
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
                      zeroSearch(i,j,level);
              }
                   }
                 j++;    
           } catch (Exception e) {
             j=0;
           }
        }   
        return list;
    }
```

![default](https://user-images.githubusercontent.com/17943275/42739059-7d72517c-88ca-11e8-8be7-84a80dc4df26.png)


### 시연 영상
[YouTube 보기](https://www.youtube.com/watch?v=HakVrDmy2ck)

