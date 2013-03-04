package com.halici.mobilchp.activity;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.net.ConnectivityManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.halici.mobilchp.sinif.ActivityBar;
import com.halici.mobilchp.sinif.Haber;
import com.halici.mobilchp.sinif.HaberSorgu;
import com.halici.mobilchp.sinif.Resim;


import com.handmark.pulltorefresh.library.*;
import com.handmark.pulltorefresh.library.PullToRefreshBase.OnRefreshListener;


public class Haberler extends Activity{

	RelativeLayout lUstKisim, lAlt1Sag, lAlt1Sol,lAlt2Sag, lAlt2Sol;
	BitmapDrawable resim1, resim2, resim3, resim4, resim5;
	static ArrayList<HashMap<String, String>> liste= new ArrayList<HashMap<String,String>>();
	boolean internet;
	PullToRefreshScrollView mPullRefreshScrollView;
	ScrollView mScrollView;
	static String guncellemeZamani=null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.haberler);
		
		
		mPullRefreshScrollView = (PullToRefreshScrollView) findViewById(R.id.pull_refresh_scrollview);
		mPullRefreshScrollView.setOnRefreshListener(new OnRefreshListener<ScrollView>() {

			@Override
			public void onRefresh(PullToRefreshBase<ScrollView> refreshView) {
				
				if(baglantiKuntrolu()==true){
					
					Calendar zaman=Calendar.getInstance();
					SimpleDateFormat df=new SimpleDateFormat("dd MM yyyy - HH:MM:ss");
					String formatliZaman=df.format(zaman.getTime());
					
					guncellemeZamani="Son güncelleme: "+formatliZaman;
					
					TextView txtGuncelleme=(TextView) findViewById(R.id.tvUpdateTime);
					txtGuncelleme.setText(guncellemeZamani);
					
					
					
					
					new Servis().execute();
				}
				else
					Toast.makeText( Haberler.this, "Lütfen internet bağlantınızı kontrol ediniz.", Toast.LENGTH_LONG ).show();
			}
		});

		mScrollView = mPullRefreshScrollView.getRefreshableView();
		
		
		lUstKisim=(RelativeLayout) findViewById(R.id.haberUst);
		lAlt1Sol=(RelativeLayout) findViewById(R.id.haberAlt1Sol);
		lAlt1Sag=(RelativeLayout) findViewById(R.id.haberAlt1Sag);
		lAlt2Sol=(RelativeLayout) findViewById(R.id.haberAlt2Sol);
		lAlt2Sag=(RelativeLayout) findViewById(R.id.haberAlt2sag);
	
		if(baglantiKuntrolu()==true)
				new Servis().execute();
		else
			Toast.makeText( this, "Lütfen internet bağlantınızı kontrol ediniz.", Toast.LENGTH_LONG ).show();
		
		ActivityBar.getInstance().connectToActivity(this);
		
	}
	
	public boolean baglantiKuntrolu() {
        final ConnectivityManager conMgr = (ConnectivityManager) getSystemService (Context.CONNECTIVITY_SERVICE);
        if (conMgr.getActiveNetworkInfo() != null && conMgr.getActiveNetworkInfo().isAvailable() &&    conMgr.getActiveNetworkInfo().isConnected()) {
        	System.out.println("İnternet Baplantısı var");
        	return true;
        } else {
              System.out.println("İnternet Baplantısı yok");
            return false;
        }
     }
	public class Servis extends AsyncTask<String, Void, String>{
		//private ProgressDialog dialog = new ProgressDialog(Sorgu.this);
		 //EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		@Override
		protected String doInBackground(String... params) {
			//Sorgulama sorgu=new Sorgulama(params[0]);
			//String sonuc=sorgu.baglan();
			String sonuc=null;
			try{
			HaberSorgu sorgu=new HaberSorgu();
			sonuc=sorgu.baglan();
			}
			catch(NullPointerException e){
				sonuc=null;
			}
			//System.out.println("Sonuclar sonuc: "+sonuc);
			return sonuc;
		}

		@Override
		protected void onPostExecute(String string) {
			
			if(string!=null){
				if(liste.size()==0){
					Haber haber=new Haber(string);
					liste=haber.veriAl();
				}
				
				String resim1=liste.get(0).get("resim");
				String resim2=liste.get(1).get("resim");
				String resim3=liste.get(2).get("resim");
				String resim4=liste.get(3).get("resim");
				String resim5=liste.get(4).get("resim");
				
				
				new ResimIndirme().execute(resim1,"1");
				new ResimIndirme().execute(resim2,"2");
				new ResimIndirme().execute(resim3,"3");
				new ResimIndirme().execute(resim4,"4");
				new ResimIndirme().execute(resim5,"5");
				
				
				
				// Ust başlık
				TextView baslikUst=(TextView) findViewById(R.id.baslikUst);
				//baslikUst.setText(uzunlukKontrol(liste.get(0).get("baslik"), 60));
				baslikUst.setText(liste.get(0).get("baslik"));
				lUstKisim.setOnClickListener(new View.OnClickListener() {
	
					@Override
					public void onClick(View v) {
						System.out.println("Basıldı üst.");
						
						haberDinleme(v);
					}
					});
				
				//Altın üstü sol
				TextView baslikAlt1Sol=(TextView) findViewById(R.id.baslikHaberAlt1Sol);
				baslikAlt1Sol.setText(liste.get(1).get("baslik"));
				
				lAlt1Sol.setOnClickListener(new View.OnClickListener() {
					
					@Override
					public void onClick(View v) {
						
						haberDinleme(v);
						
					}
				});
	
				//Altın üstü sag
				TextView baslikAlt1Sag=(TextView) findViewById(R.id.baslikHaberAlt1Sag);
				baslikAlt1Sag.setText(liste.get(2).get("baslik"));
				
				lAlt1Sag.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						haberDinleme(v);
					}
				});
	
	
				//Altın altı sol
				TextView baslikAlt2Sol=(TextView) findViewById(R.id.baslikHaberAlt2Sol);
				baslikAlt2Sol.setText(liste.get(3).get("baslik"));
				
				lAlt2Sol.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						haberDinleme(v);	
					}
				});
	
				
				//Altın altı sağ
				TextView baslikAlt2Sag=(TextView) findViewById(R.id.baslikHaberAlt2Sag);
				baslikAlt2Sag.setText(liste.get(4).get("baslik"));
				
				lAlt2Sag.setOnClickListener(new View.OnClickListener() {
					
					@Override
					public void onClick(View v) {
						
						haberDinleme(v);
						
					}
				});
			}
			else
				Toast.makeText( Haberler.this, "Veriler alınamıyor lütfen daha sonra tekrar deneyin.", Toast.LENGTH_LONG ).show();

		}

		@Override
		protected void onPreExecute() {
			 //dialog=ProgressDialog.show(SecmenKunye.this, "Baslik", "Mesaj-Calculating",true);
			
			//dialog.setMessage("Lütfen bekleyiniz; seçmen bilgileriniz yükleniyor.");
			//dialog.show();
		}

		@Override
		protected void onProgressUpdate(Void... values) {
			
		}
	
		
		public void haberDinleme(View v) {
			if(lUstKisim == v){
				System.out.println("Tıklandı: "+v);
				
				Intent i=new Intent(Haberler.this, HaberDetay.class);
				i.putExtra("id", liste.get(0).get("id"));
				i.putExtra("baslik", liste.get(0).get("baslik"));
				i.putExtra("icerik", liste.get(0).get("icerik"));
				i.putExtra("tarih", liste.get(0).get("tarih"));
				i.putExtra("resim", liste.get(0).get("resim"));
				startActivity(i);
				
			}
			else if(lAlt1Sol == v){
				System.out.println("Tıklandı: "+v);
				
				Intent i=new Intent(Haberler.this, HaberDetay.class);
				i.putExtra("id", liste.get(1).get("id"));
				i.putExtra("baslik", liste.get(1).get("baslik"));
				i.putExtra("icerik", liste.get(1).get("icerik"));
				i.putExtra("tarih", liste.get(1).get("tarih"));
				i.putExtra("resim", liste.get(1).get("resim"));
				startActivity(i);
			}
			else if(lAlt1Sag == v){
				System.out.println("Tıklandı: "+v);
				
				Intent i=new Intent(Haberler.this, HaberDetay.class);
				i.putExtra("id", liste.get(2).get("id"));
				i.putExtra("baslik", liste.get(2).get("baslik"));
				i.putExtra("icerik", liste.get(2).get("icerik"));
				i.putExtra("tarih", liste.get(2).get("tarih"));
				i.putExtra("resim", liste.get(2).get("resim"));
				startActivity(i);
			}
			else if(lAlt2Sol == v){
				System.out.println("Tıklandı: "+v);
				
				Intent i=new Intent(Haberler.this, HaberDetay.class);
				i.putExtra("id", liste.get(3).get("id"));
				i.putExtra("baslik", liste.get(3).get("baslik"));
				i.putExtra("icerik", liste.get(3).get("icerik"));
				i.putExtra("tarih", liste.get(3).get("tarih"));
				i.putExtra("resim", liste.get(3).get("resim"));
				startActivity(i);
			}
			else if(lAlt2Sag == v){
				System.out.println("Tıklandı: "+v);
				
				Intent i=new Intent(Haberler.this, HaberDetay.class);
				i.putExtra("id", liste.get(4).get("id"));
				i.putExtra("baslik", liste.get(4).get("baslik"));
				i.putExtra("icerik", liste.get(4).get("icerik"));
				i.putExtra("tarih", liste.get(4).get("tarih"));
				i.putExtra("resim", liste.get(4).get("resim"));
				startActivity(i);
			}
			
			
			
			//pdfAc("tuzuk.pdf");
			
			
	         
			
		}
			
		

		
	}
	

	public class ResimIndirme extends AsyncTask<String, Void, Void>{
		BitmapDrawable arkaplan;
		@Override
		protected Void doInBackground(String... sUrl) {
			if(sUrl[1].equals("1"))
				resim1=new Resim().resimGetir(sUrl[0]);
			else if(sUrl[1].equals("2"))
				resim2=new Resim().resimGetir(sUrl[0]);
			else if(sUrl[1].equals("3"))
				resim3=new Resim().resimGetir(sUrl[0]);
			else if(sUrl[1].equals("4"))
				resim4=new Resim().resimGetir(sUrl[0]);
			else if(sUrl[1].equals("5"))
				resim5=new Resim().resimGetir(sUrl[0]);

			
		}

		@Override
		protected void onPostExecute(Void result) {
			mPullRefreshScrollView.onRefreshComplete();
			lUstKisim.setBackgroundDrawable(resim1);
			lAlt1Sol.setBackgroundDrawable(resim2);
			lAlt1Sag.setBackgroundDrawable(resim3);
			lAlt2Sol.setBackgroundDrawable(resim4);
			lAlt2Sag.setBackgroundDrawable(resim5);
			
			super.onPostExecute(result);
		}

		

		

	}
	
	

	@Override
	public void onBackPressed() {
		
		//android.os.Process.killProcess(android.os.Process.myPid());
		//System.exit(0);
		//finish();
		moveTaskToBack(true);
	}

	
}
