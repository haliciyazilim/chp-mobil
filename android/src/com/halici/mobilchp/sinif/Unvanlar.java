package com.halici.mobilchp.sinif;

import java.util.ArrayList;
import java.util.Arrays;

public class Unvanlar {

	private static ArrayList<String> unvanlar=new ArrayList<String>(Arrays.asList(
			"Genel Başkan", "MYK Üyeleri", "PM Üyeleri", 
			"YDK Üyeleri", "Milletvekilleri", "İl Başkanları", "İlçe Başkanları",
			"Büyükşehir Belediye Başkanları", "İl Belediye Başkanları", "İlçe Belediye Başkanları"));

	public static ArrayList<String> getUnvanlar() {
		return unvanlar;
	}

	
	
	
}
