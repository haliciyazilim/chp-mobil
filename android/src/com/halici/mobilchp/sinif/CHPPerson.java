package com.halici.mobilchp.sinif;

import java.util.ArrayList;
import java.util.Arrays;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class CHPPerson extends CHPObject{

	private String isim;
	private String il;
	private String ilce;
	private String unvan;
	private int id;
	
	public String getIsim() {
		return isim;
	}

	public void setIsim(String isim) {
		this.isim = isim;
	}

	public String getIl() {
		return il;
	}

	public void setIl(String il) {
		this.il = il;
	}

	public String getIlce() {
		return ilce;
	}

	public void setIlce(String ilce) {
		this.ilce = ilce;
	}

	public String getUnvan() {
		return unvan;
	}

	public void setUnvan(String unvan) {
		this.unvan = unvan;
	}

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String getType() {
		// TODO Auto-generated method stub
		return super.getType();
	}

	@Override
	public void setType(String type) {
		// TODO Auto-generated method stub
		super.setType(type);
	}

	@Override
	public void yazdir() {
		System.out.println("Person: "+this.getIsim());
		
	}
	

	public static CHPPerson fromJSON(JSONObject json){
		CHPPerson person = new CHPPerson();
		try {
			person.setType("person");
			person.setIsim(json.getString("AdSoyad"));
			person.setIl(json.getString("IlAdi"));
			person.setIlce(json.getString("IlceAdi"));
			person.setId(json.getInt("YoneticiId"));
			
			if(json.getString("Unvan").equals("Milletvekili"))
				person.setUnvan(person.getIl()+" "+json.getString("Unvan"));
			else
				person.setUnvan(json.getString("Unvan"));
			
//			System.out.println("CHPPerson.."+person.getUnvan()+": "+person.getIsim());
			
			KisiBilgileri kisi= new KisiBilgileri();
			kisi.setId(person.getId());
			kisi.setIsim(person.getIsim());
			//kisi.setIl(person.getIl());
			//kisi.setIlce(person.getIlce());
			kisi.setUnvan(new ArrayList<String>(Arrays.asList(person.getUnvan())));
			
			KisiListesi.ekle(kisi);
			KisiListesi.aramaListesineEkle(kisi.getIsim());
				
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return person;
	}


	
	

}
