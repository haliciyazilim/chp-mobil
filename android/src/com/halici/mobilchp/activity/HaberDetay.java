package com.halici.mobilchp.activity;


import java.io.IOException;
import java.net.MalformedURLException;



import com.halici.mobilchp.sinif.ActivityBar;
import com.halici.mobilchp.sinif.Resim;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class HaberDetay extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
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
		
		new Resim();
		BitmapDrawable gelenResim=Resim.resimGetir(gelenVeri.getString("resim"));
		
		ImageView resim=(ImageView) findViewById(R.id.resim);
		resim.setImageDrawable(gelenResim);
		
		ActivityBar.getInstance().connectToActivity(this);
		
	}
	
	protected BitmapDrawable resimGetir(String string){
		BitmapDrawable arkaplan=new BitmapDrawable();
		try {
			
//			URL url = new URL(string);
//			URLConnection baglanti=url.openConnection();
//			baglanti.connect();
//			
//			Bitmap resim=BitmapFactory.decodeStream(url.openConnection().getInputStream());
			Bitmap resim = Resim.getImage(string);
			arkaplan=new BitmapDrawable(resim);
			
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return arkaplan;

	}

}
