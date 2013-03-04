package com.halici.mobilchp.activity;

import java.util.ArrayList;


import com.halici.mobilchp.activity.Haberler.ResimIndirme;
import com.halici.mobilchp.sinif.ActivityBar;
import com.halici.mobilchp.sinif.KisiBilgileri;
import com.halici.mobilchp.sinif.KisiListesi;
import com.halici.mobilchp.sinif.Resim;
import com.halici.mobilchp.sinif.Unvanlar;



import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class YoneticiDetay extends Activity {
	TextView baslik;
	
	ArrayList<String> unvanlar=Unvanlar.getUnvanlar();
	ArrayList<String> goruntulenecekListe=new ArrayList<String>();
	KisiBilgileri kisiDetay;
	BitmapDrawable gelenResim;
	ImageView foto;
	Builder builder;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.yonetici_detay);
		
		ActivityBar.getInstance().connectToActivity(this);
		
		Intent intent=getIntent();
		Bundle args=intent.getExtras();

		
		
		int yoneticiId=args.getInt("yoneticiId");
		
		
		kisiDetay=KisiListesi.getBilgiler().get(yoneticiId);
		
		TextView isim=(TextView)findViewById(R.id.tvIsim);
		TextView unvan=(TextView)findViewById(R.id.tvUnvan);
		TextView il=(TextView)findViewById(R.id.tvIl);
		TextView ilce=(TextView)findViewById(R.id.tvIlce);
		final TextView cepTel=(TextView)findViewById(R.id.tvCepTel);
		
		final TextView partiTel=(TextView)findViewById(R.id.tvPartiTel);
		final TextView mail=(TextView)findViewById(R.id.tvMail);
		
		
		
		boolean detay=kisiDetay.isDetaylar();
		System.out.println("Kişi detayı: "+detay);
		
		if(detay==false){
			System.out.print("detay Falsedeyim");
			builder = new AlertDialog.Builder(this);

			builder.setTitle("Bağlantı?");
			builder.setMessage("Lütfen internet bağlantınızı kontrol edin.");

			builder.setPositiveButton("Tamam", new DialogInterface.OnClickListener() {

			    public void onClick(DialogInterface dialog, int which) {
			        

			        dialog.dismiss();
			        finish();
			        
			    }

			});
			
			builder.create().show();
			
		}
		else{
		
			
			isim.setText(kisiDetay.getIsim());
			
			
			unvan.setText(ArrayToString(kisiDetay.getUnvan()));
			
			String strIl=kisiDetay.getIl()!="null"?kisiDetay.getIl():"";
			il.setText(strIl);
			
			String strIlce=kisiDetay.getIlce()!="null"?kisiDetay.getIlce():"";
			ilce.setText(strIlce);
			
			final String strCepTel=kisiDetay.getCeptel().get(0)!="null"?"0"+kisiDetay.getCeptel().get(0):"";
			cepTel.setText(strCepTel);
			cepTel.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					if(strCepTel.length()!=0){
							String tel="tel:+9"+cepTel.getText();
							Intent intent=new Intent(Intent.ACTION_CALL,Uri.parse(tel));
							startActivity(intent);
						}
				}
			});
			
			final String strPartiTel=kisiDetay.getPartiTel().get(0)!="null"?"0"+kisiDetay.getPartiTel().get(0):"";
			partiTel.setText(strPartiTel);
			partiTel.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					if(strPartiTel.length()!=0){
						String tel="tel:+9"+partiTel.getText();
						Intent intent=new Intent(Intent.ACTION_CALL,Uri.parse(tel));
						startActivity(intent);
					}
				}
			});
			
			mail.setText(ArrayToString(kisiDetay.getMail()));
			mail.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					/* mail intenti */
					final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);
					
					/* intent içeriği */
					emailIntent.setType("plain/text");
					emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{mail.getText().toString()});
					startActivity(Intent.createChooser(emailIntent, "e-mail gönder..."));
					
					
				}
			});
			
			foto=(ImageView) findViewById(R.id.imgFoto);
			if(!kisiDetay.getFotoUrl().get(0).equals("null"))
			new ResimIndirme().execute();
			
	//		new Resim();
	//		BitmapDrawable gelenResim=Resim.resimGetir(ArrayToString(kisiDetay.getFotoUrl()));
	//		foto.setImageDrawable(gelenResim);
			
		}	
	}
	
	public String ArrayToString(ArrayList liste){
		StringBuilder sonuc=new StringBuilder();
		try{
			for(int i=0; i<liste.size();i++){
				sonuc.append(liste.get(i));
				if((i+1)!=liste.size())
					sonuc.append(", ");
			}
		}
		catch(NullPointerException e){
			sonuc.append(" ");
		}
		
		return sonuc.toString();
	}

	
	public class ResimIndirme extends AsyncTask<String, Void, Void>{
		
		@Override
		protected Void doInBackground(String... sUrl) {
			
			

			new Resim();
			gelenResim=Resim.resimGetir(ArrayToString(kisiDetay.getFotoUrl()));

			
			return null;
			
		}

		@Override
		protected void onPostExecute(Void result) {

			foto.setImageDrawable(gelenResim);
			
			super.onPostExecute(result);
		}

		

		

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
	
}



