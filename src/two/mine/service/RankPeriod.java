package two.mine.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class RankPeriod {

	public ArrayList<Integer> PeriodCal() {
		
    	ArrayList<Integer> period = new ArrayList<>();
        SimpleDateFormat allDate = new SimpleDateFormat("yy/MM/dd/D");

        Date d = new Date();
        Calendar day = Calendar.getInstance();
 
       // day.add(Calendar.DATE , 0);
       // String beforeday = allDate.format(day.getTime());
       // System.out.println("오늘 "+beforeday);
        //m.out.println("몇 주 : " + day.get(Calendar.WEEK_OF_YEAR));
       // System.out.println("365일 : " + day.get(Calendar.DAY_OF_YEAR));
        //System.out.println("날 : " + day.get(Calendar.DATE));
        SimpleDateFormat dday = new SimpleDateFormat("yy-MM-dd");
        System.out.println("현재날짜 : "+ dday.format(d));



        // 오늘 날에서 -1 해서 전날 랭킹 구한다.
        int p_day = day.get(Calendar.DAY_OF_YEAR);
        // 2주전 첫날 부터 1주전 마지막 값을 구해 전 주 기간을 구한다.
        int p_week1 = (day.get(Calendar.WEEK_OF_YEAR)-2)*7; //2주전 날
        int p_week2 = ((day.get(Calendar.WEEK_OF_YEAR)-1)*7)-1; // 1주전 날
        
        
        System.out.println("p_week1 : "+p_week1);
        System.out.println("p_week2 : "+p_week2);
        if(day.get(Calendar.WEEK_OF_YEAR)==1) {
        	p_week1 = 357;
        	p_week2 = 363;
        }
        int p_week3 = (day.get(Calendar.WEEK_OF_YEAR)+5);
        System.out.println(p_week3);
        
        
        period.add(p_day);
        period.add(p_week1);
        period.add(p_week2);
        
        
        System.out.println("==================");
        System.out.println("어제 날짜 구하기 : " + period.get(0));
        System.out.println("전 주 첫 날 구하기 : " + period.get(1));
        System.out.println("전 주 마지막 날 구하기 : " + period.get(2));
        
        
        return period;


	}
	
	
}
