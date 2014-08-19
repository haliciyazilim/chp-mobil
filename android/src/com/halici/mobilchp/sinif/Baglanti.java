package com.halici.mobilchp.sinif;

import java.util.ArrayList;
import java.util.HashMap;

import com.halici.mobilchp.activity.Haberler;
import com.halici.mobilchp.activity.Yoneticiler;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.NetworkInfo.State;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

public class Baglanti extends BroadcastReceiver
{
	 private static final String LOGTAG = "NetworkReceiver";
	 
	 private static boolean erisim;
	
	@Override
    public void onReceive(Context ctx, Intent intent) {
	Log.i(LOGTAG, "Action: " + intent.getAction());
    	if (intent.getAction().equals(ConnectivityManager.CONNECTIVITY_ACTION)) {
		    NetworkInfo info = intent.getParcelableExtra(ConnectivityManager.EXTRA_NETWORK_INFO);
		    String typeName = info.getTypeName();
		    String subtypeName = info.getSubtypeName();
		    boolean available = info.isAvailable();
		    erisim=available;
		    Log.i(LOGTAG, "Network Type: " + typeName 
				+ ", subtype: " + subtypeName
				+ ", available: " + available);
		    
		    
		    if(available==true){
		    	new Servis().execute();
		    	
		    	System.out.println("Bağlantı bilgileri yüklüyor.");
		    }
    	}
    	
    	
    }	
	
	
	
	
	public static boolean isErisim() {
		return erisim;
	}




	public static void setErisim(boolean erisim) {
		Baglanti.erisim = erisim;
	}




	public class Servis extends AsyncTask<Integer, Void, String>{
//		private ProgressDialog dialog = new ProgressDialog(Yoneticiler.this);
		 //EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		//ArrayList<String> unvanlar=Unvanlar.getUnvanlar();
		
		@Override
		protected String doInBackground(Integer... params) {
			//Sorgulama sorgu=new Sorgulama(params[0]);
			//String sonuc=sorgu.baglan();
			String sonuc=null;
			
			//int n=params[0]+1;
			//System.out.println("n: "+n);
			//System.out.println("Servis param: "+params[0]);
			
			
			//System.out.println("Boyut: "+KisiListesi.getYoneticiBilgileri().get(unvanlar.get(n-1)).size());
			
			//if(KisiListesi.getYoneticiListesi().get(unvanlar.get(n-1))==null || KisiListesi.getYoneticiListesi().get(unvanlar.get(n-1)).size()==0){
			//System.out.println("İfe girdim");
			//System.out.println("Boyut: "+KisiListesi.getYoneticiBilgileri().get(unvanlar.get(n-1)).size());
			try{
				
					// Yöneticiler Lİstesi geliyor
					YoneticilerListeSorgu sorgu=new YoneticilerListeSorgu();
					sonuc=sorgu.baglan();
					ArrayList<KisiBilgileri> kisiler=new KisiBilgileri().veriAl(sonuc,"liste");
					
					HashMap<Integer, String> idIsim=new HashMap<Integer, String>();
					for(int i=0; i<kisiler.size();i++){
						KisiListesi.ekle(kisiler.get(i));
						
						idIsim.put(kisiler.get(i).getId(),kisiler.get(i).getIsim());
						KisiListesi.aramaListesineEkle(kisiler.get(i).getIsim());
						System.out.println("Veriler alınıyor.");
						
					
					//KisiListesi.ekle(unvanlar.get(n-1), idIsim);
				}
				return sonuc;
			}
			catch (Exception e) {
					System.out.println("Hata: Bağlantı: "+e);

			}
			finally{
				return null;
			}
				//System.out.println("Yoneticiler sayfası Kişi bilgileri: "+KisiListesi.getYoneticiBilgileri().get(unvanlar.get(1)).get(0).getIsim());
				//System.out.println("Kisi Listesi Unvan: "+KisiListesi.getBilgiler().get(0).getIsim()+", "+KisiListesi.getBilgiler().get(0).getId());
				//System.out.println("Kisi Listesi Unvan: "+KisiListesi.getBilgiler().get(1).getIsim()+", "+KisiListesi.getBilgiler().get(1).getId());
				//System.out.println("Listeler: "+KisiListesi.getYoneticiBilgileri().get(unvanlar.get(1)).size());
				
				// Yönetici Detay
	//			YoneticilerDetaySorgu sorgu=new YoneticilerDetaySorgu(2);
	//			String sonuc=sorgu.baglan();
				
				//System.out.println("Sonuclar sonuc: "+sonuc);
			//}
			
		}

		@Override
		protected void onPostExecute(String string) {
			if(string!=null){
				Yoneticiler.setVeriAlindi(true);
				System.out.println("Veriler alındı.**************");
			}

		}

		@Override
		protected void onPreExecute() {
//			dialog=ProgressDialog.show(Yoneticiler.this, "Baslik", "Mesaj-Calculating",true);
//			
//			dialog.setMessage("Lütfen bekleyiniz; bilgiler yükleniyor.");
//			dialog.show();

			
		}

		@Override
		protected void onProgressUpdate(Void... values) {
			
		}
	}
	
	
	
	
	
	
//  @Override
//  public void onReceive( Context context, Intent intent )
//  {
	  
//    ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService( Context.CONNECTIVITY_SERVICE );
//    NetworkInfo activeNetInfo = connectivityManager.getActiveNetworkInfo();
//    NetworkInfo mobNetInfo = connectivityManager.getNetworkInfo(     ConnectivityManager.TYPE_MOBILE );
//    System.out.println("Bağlantı durumu: "+activeNetInfo+" || "+mobNetInfo);
//    if ( activeNetInfo != null )
//    {
//      Toast.makeText( context, "Active Network Type : " + activeNetInfo.getTypeName(), Toast.LENGTH_SHORT ).show();
//    }
//    if( mobNetInfo != null )
//    {
//      Toast.makeText( context, "Mobile Network Type : " + mobNetInfo.getTypeName(), Toast.LENGTH_SHORT ).show();
//    }
//    
    
//    System.out.println("Bağlantı durumu: "+activeNetInfo+" || "+mobNetInfo);
//    if ( activeNetInfo == null  && mobNetInfo==null)
//    {
//      Toast.makeText( context, "Bağlantı Koptu", Toast.LENGTH_SHORT ).show();
//    }
//    else if(activeNetInfo != null  || mobNetInfo!=null)
//    	Toast.makeText( context, "Bağlantı var", Toast.LENGTH_SHORT ).show();
//    
    
//  }
}