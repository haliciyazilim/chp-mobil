package com.halici.mobilchp.sinif;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

public class KisiListesi {
	
	//private static ArrayList<KisiBilgileri> bilgiler = new ArrayList<KisiBilgileri>();
	private static HashMap<Integer, KisiBilgileri> bilgiler= new HashMap<Integer, KisiBilgileri>();
	
	//String: kategori, Hashmap: yoneticiId, isim
	private static HashMap<String, HashMap<Integer,String>> yoneticiListesi=new HashMap<String, HashMap<Integer,String>>();
	
	private static CHPListe chpAgac;
	private static ArrayList<String> aramaListesi=new ArrayList<String>();
	
	
	public static ArrayList<String> getAramaListesi() {
		return aramaListesi;
	}

	public static void aramaListesineEkle(String string){
		boolean varmi=false;
		for(int i=0; i<aramaListesi.size();i++){
			if(aramaListesi.get(i).equals(string)){
				varmi=true;
				break;
			}
		}
		
		if(varmi==false)
			aramaListesi.add(string);
	}

	public static void ekle(KisiBilgileri bilgi){
		
		int degisecekId=0;
		
		
		//if(bilgiler.containsKey(bilgi.getId())){
		
		//System.out.println(bilgi.getIsim()+", "+bilgi.getUnvan());
		
		if(bilgiler.containsKey(bilgi.getId())){
			//System.out.println("Kişi bilgisi var; güncelleniyor.");
			
			if(bilgi.getUnvan()!=null){
				//System.out.println("unvan değişiyor."+degisecekId);
				//bilgiler.get(degisecekId).setUnvan(kisiGuncelle(bilgiler.get(degisecekId).getUnvan(), bilgi.getUnvan()));
				bilgiler.get(bilgi.getId()).setUnvan(kisiGuncelle(bilgiler.get(bilgi.getId()).getUnvan(), bilgi.getUnvan()));
			}
				
			if(bilgi.getCeptel()!=null){
				//System.out.println("Cep değişiyor."+degisecekId);
				bilgiler.get(bilgi.getId()).setCeptel(kisiGuncelle(bilgiler.get(bilgi.getId()).getCeptel(), bilgi.getCeptel()));
			}
			
			if(bilgi.getPartiTel()!=null){
				//System.out.println("Cep değişiyor."+degisecekId);
				bilgiler.get(bilgi.getId()).setPartiTel(kisiGuncelle(bilgiler.get(bilgi.getId()).getPartiTel(), bilgi.getPartiTel()));
			}
			
			if(bilgi.getMail()!=null){
				//System.out.println("Cep değişiyor."+degisecekId);
				bilgiler.get(bilgi.getId()).setMail(kisiGuncelle(bilgiler.get(bilgi.getId()).getMail(), bilgi.getMail()));
			}
			
			if(bilgi.getFotoUrl()!=null){
				//System.out.println("Cep değişiyor."+degisecekId);
				bilgiler.get(bilgi.getId()).setFotoUrl(kisiGuncelle(bilgiler.get(bilgi.getId()).getFotoUrl(), bilgi.getFotoUrl()));
			}
			
			if(bilgi.isDetaylar()==true)
				bilgiler.get(bilgi.getId()).setDetaylar(true);
			
			//bilgiler.get(degisecekId).setUnvan(kisiGuncelle(bilgiler.get(degisecekId).getCeptel(), bilgi.getCeptel()));
			
			//bilgiler.get(degisecekId).setUnvan(kisiGuncelle(bilgiler.get(degisecekId).getPartiTel(), bilgi.getPartiTel()));
			
			
//			kisiGuncelle(bilgiler.get(degisecekId).getUnvan(), bilgi.getUnvan());
			
//			for(int i=0; i<bilgiler.get(degisecekId).getCeptel().size();i++){
//				if(!bilgiler.get(degisecekId).getCeptel().get(i).equals(bilgi.getCeptel()))
//					bilgiler.get(degisecekId).getCeptel().add(bilgi.getCeptel().get(i));
//			}
//			
//			for(int i=0; i<bilgiler.get(degisecekId).getPartiTel().size();i++){
//				if(!bilgiler.get(degisecekId).getPartiTel().get(i).equals(bilgi.getPartiTel()))
//					bilgiler.get(degisecekId).getPartiTel().add(bilgi.getPartiTel().get(i));
//			}
//			
//			for(int i=0; i<bilgiler.get(degisecekId).getMail().size();i++){
//				if(!bilgiler.get(degisecekId).getMail().get(i).equals(bilgi.getMail()))
//					bilgiler.get(degisecekId).getMail().add(bilgi.getMail().get(i));
//			}
		}
		else{ 
			//System.out.println("Kisi bilgisi ekleniyor.");
			bilgiler.put(bilgi.getId(),bilgi);
		}
		
	}

	public static void ekle(String unvan, HashMap<Integer,String> kisilistesi){
		yoneticiListesi.put(unvan, kisilistesi);
	}
	
	public static HashMap<Integer, KisiBilgileri> getBilgiler() {
		return bilgiler;
	}

	public static HashMap<String, HashMap<Integer, String>> getYoneticiListesi() {
		return yoneticiListesi;
	}

	public static void setYoneticiListesi(
			HashMap<String, HashMap<Integer, String>> yoneticiListesi) {
		KisiListesi.yoneticiListesi = yoneticiListesi;
	}

	public static ArrayList<String> kisiGuncelle(ArrayList<String> eski, ArrayList<String> yeni ){
		
		//System.out.println("güncellenecek array:"+eski);
		//System.out.println("eklenecek array:"+yeni);
		if(eski==null)
			eski=new ArrayList<String>();
		
		ArrayList<String> yeniBilgi=eski;
		
		for (int k=0; k<yeni.size();k++){
			boolean aynimi=false;
			int degisecekBilgi=0;
			for(int m=0; m<eski.size();m++){
				if(eski.get(m).equals(yeni.get(k))){
					degisecekBilgi=k;
					aynimi=true;
					break;
				}
			}
			if(aynimi==false){
				
				//System.out.println("eklenecek bilgi: "+yeni.get(k));
				
				yeniBilgi.add(yeni.get(k));
				
				
				
			}
			else
				yeniBilgi=eski;
			
		}

		
		//System.out.println("array son hal:"+yeniBilgi);
		return yeniBilgi;
	}

	public static CHPListe getChpAgac() {
		return chpAgac;
	}

	public static void setChpAgac(CHPListe chpAgac) {
		KisiListesi.chpAgac = chpAgac;
	}

	
	
}
