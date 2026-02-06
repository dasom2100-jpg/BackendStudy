package util;

import java.text.DecimalFormat;

public class FormatUtil {
	//EL에서의 클래스메소드를 호출하려면 꼭 static메소드만 가능함. 
	public static String number(long number, String pattern) {
		DecimalFormat format = new DecimalFormat(pattern);
		return format.format(number);
	}

}