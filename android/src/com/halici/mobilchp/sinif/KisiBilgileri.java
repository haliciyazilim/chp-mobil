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
	CHPListe chpListe;
	ArrayList<KisiBilgileri> liste= new ArrayList<KisiBilgileri>(); 
	
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
//		System.out.println("Id: "+this.getId()+"\n�sim: "+this.getIsim()+"\nUnvan: "+this.getUnvan()+
//				"\nIl: "+this.getIl()+"\nIlce: "+this.getIlce()+"\nceptel: "+this.getCeptel()+"\nPartiTel: "
//				+this.getPartiTel()+"\nMail: "+this.getMail()+"\n Foto"+this.getFotoUrl());
//		return super.toString();
		
		return "";
		
		
	}
	
	
	public CHPListe doldur(JSONObject obje){
		CHPListe liste=new CHPListe();
		try {
			if(obje.getString("Type").equals("list")){
				JSONArray array = new JSONArray(obje.getString("Content"));
				
				for(int i=0;i<array.length();i++){
					System.out.println("chpListeDoldur");
					CHPListe icListe=new CHPListe();
					icListe.setName(array.getJSONObject(i).getString("Name"));
					icListe.setType("list");
					liste.addObject(icListe);
				}
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return liste;
	}
	
	
	public void listeGez(JSONObject obje){
		
		try {
			if(obje.getString("Type").equals("list")){
				JSONArray array = new JSONArray(obje.getString("Content"));
				//System.out.println("Liste Gez: "+obje.getString("Name"));
				for(int i=0; i<array.length();i++)
					listeGez(array.getJSONObject(i));
				
			}
			else{
				
				kisiGez(obje);
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void kisiGez(JSONObject obje) throws JSONException{
		
		String ID="YoneticiId";
		String ISIM="AdSoyad";
		String UNVAN="Unvan";
		String IL="IlAdi";
		String ILCE="IlceAdi";
		String CEPTEL="CepTelefonu";
		String PARTITEL="PartiTelefonu";
		String MAIL="Email";
		String FOTOURL="FotoUrl";
		
			//System.out.println("Ki�i Gez"+obje.getString("AdSoyad")+", "+obje.getString("Unvan"));
			
			KisiBilgileri kisi= new KisiBilgileri();
			
			if(obje.length()==6){
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
		
		    this.liste.add(kisi);
		
	}
	
	
public void listeListele(CHPObject obje){
		
		try {
			if(obje.getType().equals("list")){
//				System.out.println("Listelistele if");
				
				CHPListe array = ((CHPListe) obje);
//				for(int i=0; i<array.getContent().size();i++){
//					((CHPListe)obje).getContent().get(i).yazdir();
//				
//				}
				
			}
			else{
//				System.out.println("Listelistele else");
				((CHPPerson)obje).yazdir();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
		
		System.out.println("Kisi Bilgileri veri al");
		
		if(tur.equals("liste")){			
			System.out.println("Kisi Bilgileri veri al LİSTE");
			
			JSONObject gelenVeriJSON=new JSONObject(gelenVeri);
			KisiListesi.setChpAgac(CHPListe.fromJSON(gelenVeriJSON));
			
//			JSONArray array = new JSONArray(gelenVeriJSON.getString("Content"));			
//			for (int i = 0; i < array.length(); i++) {
//				KisiBilgileri kisi= new KisiBilgileri();
//				JSONObject obje = array.getJSONObject(i);
//			    
//				kisi.setId(obje.getInt(ID));
//				kisi.setIsim(obje.getString(ISIM));
//				kisi.setUnvan(new ArrayList<String>(Arrays.asList(obje.getString(UNVAN))));
//				
//			    liste.add(kisi);
//			}
			
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
		    KisiListesi.ekle(kisi);
		}
		
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return liste;
}
	
}
