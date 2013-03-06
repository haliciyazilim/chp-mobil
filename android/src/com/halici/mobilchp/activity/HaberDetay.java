package com.halici.mobilchp.activity;


import java.io.IOException;
import java.net.MalformedURLException;



import com.halici.mobilchp.sinif.ActivityBar;
import com.halici.mobilchp.sinif.Resim;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.widget.ImageView;
import android.widget.TextView;

public class HaberDetay extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
		StrictMode.setThreadPolicy(policy); 
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.haber_detay);
		
		
		Intent intent=getIntent();
		Bundle gelenVeri=intent.getExtras();
		TextView txtIcerik=(TextView) findViewById(R.id.tvIcerik);
		
		String strIcerik=gelenVeri.getString("icerik");
		txtIcerik.setText(strIcerik);
		
		TextView txtBaslik=(TextView) findViewById(R.id.tvBaslik);
		
		String strBaslik=gelenVeri.getString("baslik");
		txtBaslik.setText(strBaslik);
		
		TextView txtTarih=(TextView) findViewById(R.id.tvTarih);
		
		String strTarih=gelenVeri.getString("tarih");
		txtTarih.setText(strTarih);
		
		
		new NetworkTask().execute(gelenVeri.getString("resim"));
		
//		ImageView resim=(ImageView) findViewById(R.id.resim);
//		resim.setImageDrawable(gelenResim);
		
		ActivityBar.getInstance().connectToActivity(this);
		
	}
	
	
	private class NetworkTask extends AsyncTask<String, Void, BitmapDrawable> {

	      @Override
	      protected BitmapDrawable doInBackground(String... params) {
			
	    	  BitmapDrawable gelenResim=Resim.resimGetir(params[0]);
	    	  return gelenResim;
	          
	      }      

	      @Override
	      protected void onPostExecute(BitmapDrawable result) { 
	    	  ImageView resim=(ImageView) findViewById(R.id.resim);
	  			resim.setImageDrawable(result);
	      }

	      @Override
	      protected void onPreExecute() {
	         // show progress dialog if any, and other initialization (not required, runs in UI thread)
	      }

	      @Override
	      protected void onProgressUpdate(Void... values) {
	// update progress, and other initialization (not required, runs in UI thread)
	      }
	}
	
}

