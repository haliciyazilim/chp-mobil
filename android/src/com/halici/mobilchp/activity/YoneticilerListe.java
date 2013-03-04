package com.halici.mobilchp.activity;

import java.util.ArrayList;
import java.util.HashMap;




import com.halici.mobilchp.sinif.ActivityBar;
import com.halici.mobilchp.sinif.KisiBilgileri;
import com.halici.mobilchp.sinif.KisiListesi;
import com.halici.mobilchp.sinif.Unvanlar;

import com.halici.mobilchp.sinif.YoneticilerDetaySorgu;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.AsyncTask;
import android.os.Bundle;

import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Toast;

import android.widget.ListView;
import android.widget.TextView;

public class YoneticilerListe extends Activity{

	TextView baslik;
	ListView liste;
	View view;
	int istenenYoneticiId;
	ArrayList<String> unvanlar=Unvanlar.getUnvanlar();
	private static ArrayList<Integer> alinanDetay=new ArrayList<Integer>(); 
	private HashMap<Integer, String> yoneticiler;
	private Object[] listeId;
	private HashMap<Integer, KisiBilgileri> yoneticiBilgileri;
	int istek;
	int tiklanan;
	Builder builder;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.yoneticiler_liste);
		ActivityBar.getInstance().connectToActivity(this);
		
		Intent intent=getIntent();
		Bundle args=intent.getExtras();
		istek=args.getInt("istek");
		
		System.out.println("YöneticiListeGelen"+istek);
		
		
		baslik=(TextView)findViewById(R.id.tvBaslik);
		baslik.setText(unvanlar.get(istek));

//		if(KisiListesi.getYoneticiListesi().size()==0)
//			System.out.println("YöneticilerListe 0");
//		else
//			System.out.println("YöneticilerListe 1: "+KisiListesi.getYoneticiListesi().size());
		
		
		try{
		
			yoneticiler=KisiListesi.getYoneticiListesi().get(unvanlar.get(istek));
			listeId=yoneticiler.keySet().toArray();
		
			yoneticiBilgileri=KisiListesi.getBilgiler();
		
			ArrayList<YoneticiKayit> yoneticiKayitlari=new ArrayList<YoneticiKayit>();
			String[] sadeceIsimlerListesi=new String[listeId.length];
			
			
			
			for(int i=0; i<listeId.length;i++){
				String isim=yoneticiBilgileri.get(listeId[i]).getIsim();
				String unvan=null;
				
				sadeceIsimlerListesi[i]=isim;
				
				String aranacakUnvan = null;
				
				if(istek>=3){
				switch (istek) {
				case 4:
					aranacakUnvan="Milletvekili";
					break;
				case 5:
					aranacakUnvan="İl Başkanı";
					break;
				case 6:
					aranacakUnvan="İlçe Başkanı";
					break;
				case 7:
					aranacakUnvan="Büyükşehir Belediye Başkanı";
					break;
				case 8:
					aranacakUnvan="İl Belediye Başkanı";
					break;
				case 9:
					aranacakUnvan="İlçe Belediye Başkanı";
					break;
				default:
					break;
				}
				
				ArrayList<String> unvanlar=yoneticiBilgileri.get(listeId[i]).getUnvan();
				
				for(int a=0; a<unvanlar.size();a++){
					
					int sorguSonuc=unvanlar.get(a).lastIndexOf(aranacakUnvan);
					if(sorguSonuc>-1){
						unvan=unvanlar.get(a);
						break;
					}
					
					
					
				}
				
				
				
				}
				
				
				
				YoneticiKayit kayit=new YoneticiKayit(isim, unvan);
				yoneticiKayitlari.add(kayit);
				
				
				
				
			}
		
		System.out.println("Kayıt edilmiş listenin boyutu: "+yoneticiKayitlari.size());
		liste=(ListView)findViewById(R.id.lvListeYL);
		
		ArrayAdapter<String> adapter=new ArrayAdapter<String>(YoneticilerListe.this,R.layout.yonticiler_sablon,R.id.tvUnvanlar, sadeceIsimlerListesi);
		
		YoneticiBilgileriAdapter adapterUnvanli=new YoneticiBilgileriAdapter(this,android.R.layout.simple_list_item_1,yoneticiKayitlari);
		
		if(istek<=3)
			liste.setAdapter(adapter);
		else
			liste.setAdapter(adapterUnvanli);
		
		System.out.println("Adapter oluşturuldu: "+yoneticiKayitlari.size());
		liste.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
				
				tiklanan=arg2;
				istenenYoneticiId=(Integer) listeId[tiklanan];
				
				//System.out.println("Args: "+tiklanan);
				
				
					// Listeleri dolduruyoruz.
				

					new Servis().execute(istenenYoneticiId);
				
			
			}
		});
		
		
		}
		catch(Exception e){
			System.out.println("HAta YöneticilerListe size"+e.toString());
			builder = new AlertDialog.Builder(this);
			
						builder.setTitle("Bilgiler daha alınamadı");
						builder.setMessage("İşlem tamamlanmadı.");
			
						builder.setPositiveButton("Tamam", new DialogInterface.OnClickListener() {
			
						    public void onClick(DialogInterface dialog, int which) {
						        
			
						        dialog.dismiss();
						        finish();
						        
						    }
			
						});
						
						builder.create().show();
		}
//		finally{
//			
//			
//			builder = new AlertDialog.Builder(this);
//
//			builder.setTitle("Bağlantı?");
//			builder.setMessage("Lütfen internet bağlantınızı kontrol edin.");
//
//			builder.setPositiveButton("Tamam", new DialogInterface.OnClickListener() {
//
//			    public void onClick(DialogInterface dialog, int which) {
//			        
//
//			        dialog.dismiss();
//			        finish();
//			        
//			    }
//
//			});
//			
//			builder.create().show();
//		}
		
		
		
		//System.out.println("Grountulenecek Liste: "+goruntulenecekListe[0]+", "+goruntulenecekListe.length);
		
		
		
	}
	
	
	public class Servis extends AsyncTask<Integer, Void, String>{
//		private ProgressDialog dialog = new ProgressDialog(YoneticilerListe.this);
		 //EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		
		
		@Override
		protected String doInBackground(Integer... params) {
			//Sorgulama sorgu=new Sorgulama(params[0]);
			//String sonuc=sorgu.baglan();
			String sonuc=null;
			
			int n=params[0];
			System.out.println("Detayı istenen: "+n+", "+istenenYoneticiId);
			
			int index=alinanDetay.indexOf(istenenYoneticiId);
			//System.out.println("index: "+index);
			if(index==-1){
				
				
				if(baglantiKuntrolu()==true){
					// Yönetici Detay
					YoneticilerDetaySorgu sorgu=new YoneticilerDetaySorgu(n);
					sonuc=sorgu.baglan();
					
					
					
					//System.out.println("Detay sonuc: "+sonuc);
						
					ArrayList<KisiBilgileri> kisi=KisiBilgileri.veriAl(sonuc, "detay");
					
					//System.out.println("Kişi Array: ");
					
					KisiBilgileri k=kisi.get(0);
					//System.out.println("Yöneticiler Lİste 118: "+k.getId()+"\n"+k.getIsim()+"\n"+k.getUnvan()+"\n"+k.getIl()+"\n"+k.getIlce()+"\n"+k.getCeptel()+"\n"+k.getPartiTel()+"\n"+k.getMail()+"\n");
					//System.out.println("Yöneticiler Lİste 119: "+k.toString());
					KisiListesi.ekle(k);
					//KisiListesi.ekle(unvanlar.get(n-1), kisi);
					System.out.println("Detaylar YönetcilerListe: "+k.isDetaylar());
					alinanDetay.add(istenenYoneticiId);
				}
			}
			return sonuc;
		}

		@Override
		protected void onPostExecute(String string) {
			
			
//			dialog.dismiss();
		
			
			Intent i=new Intent(YoneticilerListe.this, YoneticiDetay.class);  // this; yonlendirmenin yapıldığı activity. 
			i.putExtra("yoneticiId", istenenYoneticiId);
			
			startActivityForResult(i, 0);
			//startActivity(i);
			

		}

		@Override
		protected void onPreExecute() {
//			dialog=ProgressDialog.show(YoneticilerListe.this, "Baslik", "Mesaj-Calculating",true);
//			
//			dialog.setMessage("Lütfen bekleyiniz; bilgiler yükleniyor.");
//			dialog.show();
			

			Toast.makeText(getApplicationContext(), "Lütfen bekleyiniz; bilgiler yükleniyor.", Toast.LENGTH_SHORT).show();
		}

		@Override
		protected void onProgressUpdate(Void... values) {
			
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
	
	
	public class YoneticiBilgileriAdapter extends ArrayAdapter<YoneticiKayit> {
		private ArrayList<YoneticiKayit> users;

		public YoneticiBilgileriAdapter(Context context, int textViewResourceId, ArrayList<YoneticiKayit> users) {
			super(context, textViewResourceId, users);
			this.users = users;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			View v = convertView;
			if (v == null) {
				LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
				v = vi.inflate(R.layout.yoneticiler_liste_sablon, null);
			}
			
			YoneticiKayit user = users.get(position);
			if (user != null) {
				TextView isim = (TextView) v.findViewById(R.id.tvIsimler);
				TextView unvan = (TextView) v.findViewById(R.id.tvUnvanlar);

				if (isim != null) {
					isim.setText(user.isim);
				}

				if(isim != null) {
					unvan.setText(user.unvan );
				}
			}
			return v;
		}
	}
	

	
	public class YoneticiKayit {
		public String isim;
		public String unvan;
		
		
		public YoneticiKayit(String isim, String unvan) {
			super();
			this.isim = isim;
			this.unvan = unvan;
		}
		
		
	}
	

		
	
	
}