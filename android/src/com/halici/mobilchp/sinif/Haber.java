package com.halici.mobilchp.sinif;


import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Haber {
	private String gelenVeri;
	
	//JSON Nodları
	private static String ID="Id";
	private static String BASLIK="Baslik";
	private static String TARIH="Tarih";
	private static String RESIM="HaberResmi";
	private static String ICERIK="Icerik";
	
	private String id,baslik,tarih,resim,icerik;
	
	
	
	public Haber(String gelenVeri) {
		super();
		this.gelenVeri = gelenVeri;
	}



	public ArrayList<HashMap<String, String>> veriAl(){
		
		ArrayList<HashMap<String, String>> liste=new ArrayList<HashMap<String, String>>();
		 
		try {
			
			JSONArray array = new JSONArray(this.gelenVeri);
			for (int i = 0; i < array.length(); i++) {
				HashMap<String, String> map=new HashMap<String, String>();
				
				JSONObject obje = array.getJSONObject(i);
			    
			    id = obje.getString(ID);
			    baslik = obje.getString(BASLIK);
			    icerik=obje.getString(ICERIK);
			    tarih=obje.getString(TARIH);
			    resim=obje.getString(RESIM);
			    
			    map.put("id",id);
			    map.put("baslik", baslik);
			    map.put("icerik", icerik);
			    map.put("tarih", tarih);
			    map.put("resim", resim);
			    liste.add(map);
			    		
			    
			    //System.out.println("id: "+id+" Baslik: "+baslik);
			} 
			
			
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return liste;
	}
	
}
