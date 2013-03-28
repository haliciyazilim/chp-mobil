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
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import android.widget.TableLayout;
import android.widget.TableRow;

public class YoneticiDetay extends Activity {
	TableLayout tablo;
	TextView baslik;
	
	//ArrayList<String> unvanlar=Unvanlar.getUnvanlar();
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
		
		boolean detay=kisiDetay.isDetaylar();
		System.out.println("Kiþi detayý: "+detay);
		
		if(detay==false){
			System.out.print("detay Falsedeyim");
			builder = new AlertDialog.Builder(this);

			builder.setTitle("Baðlantý?");
			builder.setMessage("Lütfen internet baðlantýnýzý kontrol edin.");

			builder.setPositiveButton("Tamam", new DialogInterface.OnClickListener() {

			    public void onClick(DialogInterface dialog, int which) {
			        

			        dialog.dismiss();
			        finish();
			        
			    }

			});
			
			builder.create().show();
			
		}
		else{
			
			DisplayMetrics metrics=getResources().getDisplayMetrics();
			System.out.println("DPI: "+metrics.density);
			float dpi=metrics.density;

			tablo=(TableLayout) findViewById(R.id.detayTableLayout);
			
			
			ImageView imgSeperator= new ImageView(this);
			imgSeperator.setImageResource(R.drawable.seperator);
			imgSeperator.setPadding(0, (int)(10*dpi), 0, (int)(10*dpi));
		
			
			
			TextView isim =new TextView(this);
			isim.setText(kisiDetay.getIsim());
			isim.setGravity(Gravity.CENTER);
			isim.setTextSize(20);
			//satir.addView(isim);
			tablo.addView(isim);
			
			
			tablo.addView(imgSeperator);
			
			
			// Unvanlar ekleniyor
			for(int i=0; i<kisiDetay.getUnvan().size();i++){
				TextView unvan=new TextView(this);
				unvan.setText(kisiDetay.getUnvan().get(i));
				unvan.setGravity(Gravity.CENTER);
				//satir.addView(unvan);
				tablo.addView(unvan);
				
				if(kisiDetay.getUnvan().size()-1==i){
					ImageView imgSeperator2= new ImageView(this);
					imgSeperator2.setImageResource(R.drawable.seperator);
					imgSeperator2.setPadding(0, (int)(10*dpi), 0, (int)(10*dpi));
					tablo.addView(imgSeperator2);
				}
				
					
			}
			
			// Cep telefonu ekleniyor
			if(kisiDetay.getCeptel().size()>0)
				for(int i=0; i<kisiDetay.getCeptel().size();i++){
					TableRow satir=new TableRow(this);
					ImageView imgCep=new ImageView(this);
					imgCep.setImageResource(R.drawable.icon_cellphone);
					imgCep.setPadding((int)(50*dpi), 0, (int)(10*dpi), 0);
					final TextView cepTel=new TextView(this);
					final String strCepTel=kisiDetay.getCeptel().get(i)!="null"?"0"+kisiDetay.getCeptel().get(0):"";
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
					
					satir.addView(imgCep);
					satir.addView(cepTel);
					tablo.addView(satir);
					
					if(kisiDetay.getCeptel().size()-1==i){
						ImageView imgSeperator3= new ImageView(this);
						imgSeperator3.setImageResource(R.drawable.seperator);
						imgSeperator3.setPadding(0, (int)(10*dpi), 0, (int)(10*dpi));
						
						tablo.addView(imgSeperator3);
					}
					
				}
			
			// telefon ekleniyor
			if(kisiDetay.getPartiTel().size()>0)
				for(int i=0; i<kisiDetay.getPartiTel().size();i++){
					TableRow satir=new TableRow(this);
					ImageView imgCep=new ImageView(this);
					imgCep.setImageResource(R.drawable.icon_phone);
					imgCep.setPadding((int)(50*dpi), 0, (int)(10*dpi), 0);
					final TextView cepTel=new TextView(this);
					final String strCepTel=kisiDetay.getPartiTel().get(i)!="null"?"0"+kisiDetay.getPartiTel().get(0):"";
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
					
					satir.addView(imgCep);
					satir.addView(cepTel);
					tablo.addView(satir);
					
					
					if(kisiDetay.getPartiTel().size()-1==i){
						ImageView imgSeperator4= new ImageView(this);
						imgSeperator4.setImageResource(R.drawable.seperator);
						imgSeperator4.setPadding(0, (int)(10*dpi), 0, (int)(10*dpi));
						tablo.addView(imgSeperator4);
					}
					
				}
			

			// mail ekleniyor
			if(kisiDetay.getMail().size()>0)
				for(int i=0; i<kisiDetay.getMail().size();i++){
					TableRow satir=new TableRow(this);
					ImageView imgMail=new ImageView(this);
					imgMail.setImageResource(R.drawable.icon_mail);
					imgMail.setPadding((int)(50*dpi), 0, (int)(10*dpi), 0);
					final TextView mail=new TextView(this);
					mail.setText(kisiDetay.getMail().get(i));
					mail.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// mail intenti
							final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);
							
							// intent iÃ§eriÄŸi 
							emailIntent.setType("plain/text");
							emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{mail.getText().toString()});
							startActivity(Intent.createChooser(emailIntent, "e-mail gönder..."));
							
							
						}
					
					});
					
					satir.addView(imgMail);
					satir.addView(mail);
					tablo.addView(satir);
					
//					if(kisiDetay.getMail().size()-1==i)
//						tablo.addView(bosluk);
				}
			
			
			/*
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
			
			if(ArrayToString(kisiDetay.getMail()).equals("null"))
				mail.setText("");
			else
				mail.setText(ArrayToString(kisiDetay.getMail()));
			mail.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					// mail intenti
					final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);
					
					// intent iÃ§eriÄŸi 
					emailIntent.setType("plain/text");
					emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{mail.getText().toString()});
					startActivity(Intent.createChooser(emailIntent, "e-mail gönder..."));
					
					
				}
			
	});
	*/
			
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
        	System.out.println("Ä°nternet BaplantÄ±sÄ± var");
        	return true;
        } else {
              System.out.println("Ä°nternet BaplantÄ±sÄ± yok");
            return false;
        }
     }
	
}



