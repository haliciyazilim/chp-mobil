package com.halici.mobilchp.sinif;

import java.util.ArrayList;
import java.util.Arrays;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class KisiBilgileri {
	private int id;
	private String isim;
	private ArrayList<String> unvan;
	private String il;
	private String ilce;
	private ArrayList<String> ceptel, partiTel, mail, fotoUrl;
	private boolean detaylar;

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getIsim() {
		return isim;
	}
	public void setIsim(String isim) {
		this.isim = isim;
	}
	public ArrayList<String> getUnvan() {
		return unvan;
	}
	public void setUnvan(ArrayList<String> unvan) {
		this.unvan = unvan;
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
	public ArrayList<String> getCeptel() {
		return ceptel;
	}
	public void setCeptel(ArrayList<String> ceptel) {
		this.ceptel = ceptel;
	}
	public ArrayList<String> getPartiTel() {
		return partiTel;
	}
	public void setPartiTel(ArrayList<String> partiTel) {
		this.partiTel = partiTel;
	}
	public ArrayList<String> getMail() {
		return mail;
	}
	public void setMail(ArrayList<String> mail) {
		this.mail = mail;
	}
	
	public boolean isDetaylar() {
		return detaylar;
	}
	public void setDetaylar(boolean detaylar) {
		this.detaylar = detaylar;
	}
	
	
	public ArrayList<String> getFotoUrl() {
		return fotoUrl;
	}
	public void setFotoUrl(ArrayList<String> fotoUrl) {
		this.fotoUrl = fotoUrl;
	}
	@Override
	public String toString() {
		System.out.println("Id: "+this.getId()+"\nİsim: "+this.getIsim()+"\nUnvan: "+this.getUnvan()+
				"\nIl: "+this.getIl()+"\nIlce: "+this.getIlce()+"\nceptel: "+this.getCeptel()+"\nPartiTel: "
				+this.getPartiTel()+"\nMail: "+this.getMail()+"\n Foto"+this.getFotoUrl());
		return super.toString();
		
		
	}
	public static ArrayList<KisiBilgileri> veriAl(String gelenVeri, String tur){
		String ID="YoneticiId";
		String ISIM="AdSoyad";
		String UNVAN="Unvan";
		String IL="IlAdi";
		String ILCE="IlceAdi";
		String CEPTEL="CepTelefonu";
		String PARTITEL="PartiTelefonu";
		String MAIL="Email";
		String FOTOURL="FotoUrl";
		
		
		
		ArrayList<KisiBilgileri> liste= new ArrayList<KisiBilgileri>(); 
		try {
			
			if(tur.equals("liste")){
				JSONArray array = new JSONArray(gelenVeri);
				for (int i = 0; i < array.length(); i++) {
					KisiBilgileri kisi= new KisiBilgileri();
					JSONObject obje = array.getJSONObject(i);
				    
					if(obje.length()==5){
					    kisi.setId(obje.getInt(ID));
					    kisi.setIsim(obje.getString(ISIM));
					    kisi.setUnvan(new ArrayList<String>(Arrays.asList(obje.getString(UNVAN))));
					    //kisi.setIl(obje.getString(IL));
					    //kisi.setIlce(obje.getString(ILCE));
					}
					else{
					    kisi.setCeptel(new ArrayList<String>(Arrays.asList(obje.getString(CEPTEL))));
					    kisi.setPartiTel(new ArrayList<String>(Arrays.asList(obje.getString(PARTITEL))));
					    kisi.setMail(new ArrayList<String>(Arrays.asList(obje.getString(MAIL))));
					    kisi.setFotoUrl(new ArrayList<String>(Arrays.asList(obje.getString(FOTOURL))));

					}
				
				    liste.add(kisi);
				}
				
			}
			else if(tur.equals("detay")){
				JSONObject obje=new JSONObject(gelenVeri);
				KisiBilgileri kisi= new KisiBilgileri();
			    kisi.setId(obje.getInt(ID));
			    kisi.setIsim(obje.getString(ISIM));


			    kisi.setCeptel(new ArrayList<String>(Arrays.asList(obje.getString(CEPTEL))));
			    kisi.setPartiTel(new ArrayList<String>(Arrays.asList(obje.getString(PARTITEL))));
			    kisi.setMail(new ArrayList<String>(Arrays.asList(obje.getString(MAIL))));
			    kisi.setFotoUrl(new ArrayList<String>(Arrays.asList(obje.getString(FOTOURL))));
			    kisi.setDetaylar(true);
			    liste.add(kisi);
			}
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return liste;
	}
	
}
