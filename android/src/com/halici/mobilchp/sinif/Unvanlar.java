package com.halici.mobilchp.sinif;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class Unvanlar {
	private  static ArrayList<String> unvanlar;
	/*
	private static ArrayList<String> unvanlar=new ArrayList<String>(Arrays.asList(
			"Genel Ba�kan", "MYK �yeleri", "PM �yeleri", 
			"YDK �yeleri", "Milletvekilleri", "�l Ba�kanlar�", "�l�e Ba�kanlar�",
			"B�y�k�ehir Belediye Ba�kanlar�", "�l Belediye Ba�kanlar�", "�l�e Belediye Ba�kanlar�"));
*/
	public static void setUnvanlar(String gelenVeri){
		System.out.println("Unvanlar Geliyor ");
		ArrayList<String> gelenUnvanlar=new ArrayList<String>();
		try {
			JSONObject liste=new JSONObject(gelenVeri);
			System.out.println("Gelen veri Liste: "+liste.getString("Content"));
			
			JSONArray array = new JSONArray(liste.getString("Content"));
			System.out.println("Gelen verinin boyutu: "+array.length());
			for (int i = 0; i < array.length(); i++) {
				
				JSONObject obje = array.getJSONObject(i);
				System.out.println("Alınan kategori: "+obje.get("Name"));
				gelenUnvanlar.add(obje.get("Name").toString());
			}
			Unvanlar.unvanlar=gelenUnvanlar;
		} catch (JSONException e) {
			System.out.println("Unvanlar Geliyor HATA "+e.toString());
			e.printStackTrace();
		}
		
	}
	public  static ArrayList<String> getUnvanlar() {
		return Unvanlar.unvanlar;
	}

	
	
	
}
