package com.halici.mobilchp.activity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;

import com.halici.mobilchp.activity.Haberler.Servis;
import com.halici.mobilchp.sinif.ActivityBar;
import com.halici.mobilchp.sinif.CHPListAdapter;
import com.halici.mobilchp.sinif.CHPListe;
import com.halici.mobilchp.sinif.CHPObject;
import com.halici.mobilchp.sinif.CHPPerson;
import com.halici.mobilchp.sinif.KisiBilgileri;
import com.halici.mobilchp.sinif.KisiListesi;
import com.halici.mobilchp.sinif.ListenerManager;
import com.halici.mobilchp.sinif.Unvanlar;
import com.halici.mobilchp.sinif.YoneticilerDetaySorgu;
import com.halici.mobilchp.sinif.YoneticilerListeSorgu;




import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.view.View.OnKeyListener;
import android.view.animation.Animation;
import android.view.animation.TranslateAnimation;
import android.widget.AdapterView;
import android.widget.AnalogClock;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

public class Yoneticiler extends Activity implements ListenerManager.Listener{
	
	private ListenerManager listenerManager;
	private Servis servis;
	private ServisDetay servisDetay;
	
	ArrayList<String> unvanlar;
	ListView liste;
	int istenenYoneticiId;
	private static ArrayList<Integer> alinanDetay=new ArrayList<Integer>(); 
	private HashMap<Integer, KisiBilgileri> yoneticiler=KisiListesi.getBilgiler();
	private static Object[] listeId;
	private Object[] listeVal=yoneticiler.values().toArray();
	private static boolean veriAlindi;
	private static boolean aramaAktiv;
	int istek;
	AlertDialog.Builder builder;
	ArrayList<String> aramaListe;
	private TextView txtArama;
	private RelativeLayout lyArama;
	private Animation animationAramaYukari;
	private Animation animationAramaAsagi;
	private Animation animationListeYukari;
	private Animation animationListeAsagi;
	
	private static CHPObject rootList;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		
		listenerManager= new ListenerManager();
		listenerManager.registerListener(this);
		servis=new Servis();
		
		
		setContentView(R.layout.yoneticiler);
		ActivityBar.getInstance().connectToActivity(this);
		
		DisplayMetrics metrics=getResources().getDisplayMetrics();
		System.out.println("DPI: "+metrics.density);
		float dpi=metrics.density;
		lyArama=(RelativeLayout)findViewById(R.id.lyArama);
		RelativeLayout sayfaBasi=(RelativeLayout)findViewById(R.id.lySayfaBasi);
		sayfaBasi.bringToFront();
		animationAramaYukari = new TranslateAnimation(0,0,0,-100*dpi);
		animationAramaYukari.setDuration(1000);
		animationAramaYukari.setFillAfter(true);
		
		animationAramaAsagi = new TranslateAnimation(0,0,-100*dpi,0);
		animationAramaAsagi.setDuration(1000);
		animationAramaAsagi.setFillAfter(true);
		
		
		animationListeYukari = new TranslateAnimation(0,0,0,-50*dpi);
		animationListeYukari.setDuration(1000);
		animationListeYukari.setFillAfter(true);
		
		animationListeAsagi = new TranslateAnimation(0,0,-50*dpi,0);
		animationListeAsagi.setDuration(1000);
		animationListeAsagi.setFillAfter(true);
		
		
		
		 
		 
		
		if(veriAlindi==false){
			if(baglantiKuntrolu()==true){
				System.out.println(" Yonetici.java istek: "+istek);
				if(servis!=null)
					servis=new Servis();
				servis.execute(istek);
		    	
			 }
			 
		 }
		else{
			kategoriListesiniDoldur("liste",KisiListesi.getChpAgac().getContent());
		}
		
		//kategoriListesiniDoldur();
		
		
		
		builder = new AlertDialog.Builder(this);

		builder.setTitle("Bilgiler daha alınamadı");
		builder.setMessage("İşlem tamamlanmadı.");

		builder.setPositiveButton("Tamam", new DialogInterface.OnClickListener() {

		    public void onClick(DialogInterface dialog, int which) {
		        onCreate(null);

		        dialog.dismiss();
		    }

		});

		
		

			
			
			aramaListe=KisiListesi.getAramaListesi();
			System.out.println("Aramaliste ilk: "+aramaListe.size());
			txtArama=(TextView) findViewById(R.id.txtArama);
			if(aramaAktiv!=true){
				//txtArama.getBackground().setAlpha(100);
				//txtArama.setVisibility(TextView.INVISIBLE);
				
				
				lyArama.startAnimation(animationAramaYukari);
				lyArama.setVisibility(0);
				//liste.startAnimation(animationListeYukari);
				}
			txtArama.setOnTouchListener(new View.OnTouchListener() {
				
				@Override
				public boolean onTouch(View v, MotionEvent event) {
					
					if(aramaAktiv==false){
						txtArama.setFocusable(false);
						txtArama.setFocusableInTouchMode(false);
						Toast.makeText(getApplicationContext(), "Bilgiler alındıktan sonra arama yapabilirsiniz.", Toast.LENGTH_SHORT).show();

					}
					else{
						txtArama.setFocusable(true);
						txtArama.setFocusableInTouchMode(true);
						txtArama.getBackground().setAlpha(255);
					}
					return false;
				}
			});
			
			txtArama.addTextChangedListener(new TextWatcher() {
				
				@Override
				public void onTextChanged(CharSequence s, int start, int before, int count) {
					System.out.println("Girdik aramaya: "+s);
					System.out.println("Tüm liste: "+aramaListe.size());
					if(s.length()==0){
						kategoriListesiniDoldur("liste",KisiListesi.getChpAgac().getContent());
					}
					else{
					
						final ArrayList<String> sonucListesi=new ArrayList<String>();
						final ArrayList<YoneticiKayit> kayitlar= new ArrayList<YoneticiKayit>();
						String[] aranan=s.toString().split(" ");
						
						System.out.println("Tüm liste: "+aramaListe.size());
						
							for(int i=0;i<aramaListe.size();i++){
								boolean match=true;
								
								for(int j=0; j<aranan.length;j++){
									boolean innerMatch=false;
									
									String[] isimler=aramaListe.get(i).split(" ");
									for(int k=0; k<isimler.length;k++){
										
										String isim="";
										if(isimler[k].length()>=aranan[j].length())
											isim=isimler[k].toLowerCase().substring(0, aranan[j].length());
										else
											isim=isimler[k].toLowerCase();
										
										if(isim.equals(aranan[j])){
											innerMatch=true;
										}
										
									}
									if(!innerMatch)
										match=false;
										
								}
								if (match){
									sonucListesi.add(aramaListe.get(i));
									
									for(int a=0; a<listeId.length;a++){
										//System.out.println("Listedeki isim: "+yoneticiler.get(listeId[a]).getIsim()+"aramadaki isim: "+aramaListe.get(i));
										if(yoneticiler.get(listeId[a]).getIsim().equals(aramaListe.get(i))){
											String yIsim=yoneticiler.get(listeId[a]).getIsim();
											String yUnvanlar=yoneticiler.get(listeId[a]).getUnvan().toString();
											String yUnvan=yUnvanlar.substring(1,yUnvanlar.length()-1);
											
											
											
											YoneticiKayit bulunanYonetici=new YoneticiKayit(yIsim, yUnvan);
											kayitlar.add(bulunanYonetici);
											
											break;
										}
									}
									
								}
								//System.out.println("Arama sonuç: "+kayitlar.size()+" sonuclistesi: "+sonucListesi);
							}
						
						//ArrayAdapter<String> adapterArama=new ArrayAdapter<String>(Yoneticiler.this,R.layout.yonticiler_sablon,R.id.tvUnvanlar, sonucListesi);
						YoneticiBilgileriAdapter adapterArama=new YoneticiBilgileriAdapter(Yoneticiler.this,android.R.layout.simple_list_item_1,kayitlar);
						liste.setAdapter(adapterArama);
						liste.setOnItemClickListener(new AdapterView.OnItemClickListener() {
							
							@Override
							public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
								
								istek=arg2;
								System.out.println("Sorgu tıklama: "+istek);
								//HashMap<Integer, KisiBilgileri> yoneticiler=KisiListesi.getBilgiler();
								
								
								
		
								for(int i=0; i<listeId.length;i++){
									if(yoneticiler.get(listeId[i]).getIsim().equals(sonucListesi.get(istek))){
										System.out.println("idedn nçnce: "+yoneticiler.get(listeId[i]).getIsim());
										System.out.println("idedn nçnce: "+yoneticiler.get(listeId[i]).getId());
										
										istenenYoneticiId=yoneticiler.get(listeId[i]).getId();
										
										break;
									}
								}
								System.out.println("Sorgu tıklama: "+sonucListesi.get(istek)+", id:"+istenenYoneticiId);
		//							//System.out.println("Basılan bu mu: "+sonucListesi.get(arg2)+", "+listeId[ilgiliId]);
		//							Intent i=new Intent(Yoneticiler.this, YoneticiDetay.class);
		//							i.putExtra("yoneticiId", ilgiliId);
		//							i.putExtra("fotoUrl", value);
		//							
		//							startActivity(i);
								
								if(servisDetay!=null)
									servisDetay=new ServisDetay();
								servisDetay.execute(istenenYoneticiId);
								
							
								
		
							}
						});
					
					}
				}
				
				@Override
				public void beforeTextChanged(CharSequence s, int start, int count,
						int after) {
					// TODO Auto-generated method stub
					
				}
				
				@Override
				public void afterTextChanged(Editable s) {
					// TODO Auto-generated method stub
					
				}
			});
				 
		
	
	}

	
	@Override
	protected void onStart() {
		super.onStart();
		
		System.out.println("App is onStart()");
		
	}
	
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		System.out.println("App is onResume()");
		
		listenerManager.setIsBackground(false);
		
		if(baglantiKuntrolu()==true){
			if(veriAlindi==false){
				if(servis!=null){
					servis=null;
				}
				servis=new Servis();
				servis.execute();
			}
			else
				kategoriListesiniDoldur("liste",KisiListesi.getChpAgac().getContent());
		}
		else
			Toast.makeText( this, "Lütfen internet bağlantınızı kontrol ediniz.", Toast.LENGTH_LONG ).show();
		
		
	}
	
	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		super.onPause();
		System.out.println("App is onPause()");
		listenerManager.setIsBackground(true);
	}
	
	@Override
	protected void onStop() {
		// TODO Auto-generated method stub
		super.onStop();
		System.out.println("App is onStop()");
	}
	
	@Override
	protected void onDestroy() {
		// TODO Auto-generated method stub
		super.onDestroy();
		System.out.println("App is onDestroy()");
	}

	
	@Override
	public void onStateChange(boolean state) {
		if(state){
			try{
				servis.dialog.dismiss();
				servis.cancel(true);
			
			}
			catch(Exception e){
				
			}
			
			try{
				servisDetay.cancel(true);
				}
				catch(Exception e){
					
				}
		}
		
	}
	
	
	
	public static boolean isVeriAlindi() {
		return veriAlindi;
	}

	public static void setVeriAlindi(boolean veriAlindi) {
		Yoneticiler.veriAlindi = veriAlindi;
	}

	// Listeleri doldurma i�i burada yap�l�yor. Listenin tipine g�re tekrar liste ya da detay g�r�nt�lenecek. Bu method unvan ya da isim ve tip alacak
	// String tip, ArrayList<String> icerik 
	public void kategoriListesiniDoldur(String tip, ArrayList<CHPObject> icerik) {

		liste=(ListView)findViewById(R.id.lvListe);
		CHPListAdapter adapter=new CHPListAdapter(this,R.layout.yonticiler_sablon,R.id.tvUnvanlar, icerik);
		liste.setAdapter(adapter);
		
		
		//T�klad���nda olacak i�lemler
		
		liste.setOnItemClickListener(new AdapterView.OnItemClickListener() {
		
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
				
				
				if(isVeriAlindi()==true){
					
					istek=arg2;
					System.out.println("istek: "+istek);

//					TextView t=(TextView) arg1.findViewById(R.id.tvUnvanlar);
//					System.out.println("istek MEtin: "+t.getText().toString());
					CHPListe tiklananListe=((CHPListe)rootList);
					System.out.println("GElen istek:: "+tiklananListe.getContent().get(istek).getType());
					System.out.println("****Yoneticiler Tıklanan listenin uzunluğu: "+((CHPListe)((CHPListe)rootList).getContent().get(arg2)).getContent().size());
					if(tiklananListe.getContent().get(istek).getType().equals("list")){
//						Intent i=new Intent(Yoneticiler.this, YoneticilerListe.class);
//						i.putExtra("gelenListe", tiklananListe.getContent().get(istek));
//						startActivity(i);
						
						if(((CHPListe)((CHPListe)rootList).getContent().get(arg2)).getContent().size()!=1 ){
							Intent i=new Intent(Yoneticiler.this, YoneticilerListe.class);  // this; yonlendirmenin yap�ld��� activity. 
							i.putExtra("gelenListe", tiklananListe.getContent().get(istek));
					
							startActivityForResult(i, 0);
							//startActivity(i);
						}
						else if(((CHPListe)((CHPListe)rootList).getContent().get(arg2)).getContent().size()==1 && (((CHPListe)((CHPListe)rootList).getContent().get(arg2)).getContent().get(0).getType().equals("person"))){
							istenenYoneticiId=((CHPPerson)((CHPListe)((CHPListe)rootList).getContent().get(arg2)).getContent().get(0)).getId();
							new ServisDetay().execute(istenenYoneticiId);
						}
						
						
					}
					
					/*
					if(istek==0){
						istenenYoneticiId=1;
						new ServisDetay().execute(istenenYoneticiId);
					}
					else{
						Intent i=new Intent(Yoneticiler.this, YoneticilerListe.class);
						i.putExtra("istek", istek);
						
						startActivityForResult(i, 0);
						//startActivity(i);
						 
					}	
					*/		
				}
				
				else{
//					ProgressDialog dialog = new ProgressDialog(Yoneticiler.this);
//					dialog=ProgressDialog.show(Yoneticiler.this, "Baslik", "Mesaj-Calculating",true);
//					
//					dialog.setMessage("Lütfen bekleyiniz; bilgiler yükleniyor.");
//					dialog.show();
					
					
					

					builder.create().show();
					
				}
					

			}
		});
	
	}
	
	
	// Ki�i Listeleri Al�n�yor. Ki�i Listesi dolduruluyor. 
	public class Servis extends AsyncTask<Integer, Void, String>{
		public ProgressDialog dialog = new ProgressDialog(Yoneticiler.this);
		 //EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		
		
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
			
				// Y�neticiler Listesi geliyor
				
				if(baglantiKuntrolu()==true){
				
					// Sorgu Al�n�yor. Listeler geliyor.
					YoneticilerListeSorgu sorgu=new YoneticilerListeSorgu();
					sonuc=sorgu.baglan();
					
//					ArrayList<KisiBilgileri> kisiler=KisiBilgileri.veriAl(sonuc,"liste");
					KisiBilgileri.veriAl(sonuc,"liste");
					//System.out.println("Ki�iler Array");
					//System.out.println(kisiler);
					
					/*
					HashMap<Integer, String> idIsim=new HashMap<Integer, String>();
					for(int i=0; i<kisiler.size();i++){
						KisiListesi.ekle(kisiler.get(i));
						
						idIsim.put(kisiler.get(i).getId(),kisiler.get(i).getIsim());
						KisiListesi.aramaListesineEkle(kisiler.get(i).getIsim());
						
					}
					*/
					
					// gelen veriyi dosyaya yazd�r�yoruz.
					/*
					try{
					File file=new File(Environment.getExternalStorageDirectory().getPath(),"cevap.txt");
					file.createNewFile();
					
					FileOutputStream fOut=new FileOutputStream(file);
					OutputStreamWriter writter= new OutputStreamWriter(fOut);
					writter.append(sonuc.toString());
					writter.close();
					fOut.close();
					System.out.println("Yad�rma i�lemi tamam@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				    } catch (Exception e) {
				    	System.out.println("Yad�rma i�lemi Hata@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"+e.toString());
				     }
				     */
				}
			
				//System.out.println("Yoneticiler sayfas� Ki�i bilgileri: "+KisiListesi.getYoneticiBilgileri().get(unvanlar.get(1)).get(0).getIsim());
				//System.out.println("Kisi Listesi Unvan: "+KisiListesi.getBilgiler().get(0).getIsim()+", "+KisiListesi.getBilgiler().get(0).getId());
				//System.out.println("Kisi Listesi Unvan: "+KisiListesi.getBilgiler().get(1).getIsim()+", "+KisiListesi.getBilgiler().get(1).getId());
				//System.out.println("Listeler: "+KisiListesi.getYoneticiBilgileri().get(unvanlar.get(1)).size());
				
				// Yönetici Detay
	//			YoneticilerDetaySorgu sorgu=new YoneticilerDetaySorgu(2);
	//			String sonuc=sorgu.baglan();
				
				//System.out.println("Sonuclar sonuc: "+sonuc);
			//}
			return sonuc;
		}

		@Override
		protected void onPostExecute(String string) {
			dialog.dismiss();
			
			
			aramaListe=KisiListesi.getAramaListesi();
			
			listeId=yoneticiler.keySet().toArray();
			System.out.println("Aramaliste Servis: "+aramaListe.size());
			aramaAktiv=true;
			//txtArama.setVisibility(TextView.VISIBLE);
			
			//txtArama.getBackground().setAlpha(255);
			

			
			lyArama.startAnimation(animationAramaAsagi);
			lyArama.setVisibility(1);
			//liste.startAnimation(animationListeAsagi);
			System.out.println("Kategoriler doluyor.");
			kategoriListesiniDoldur("liste",KisiListesi.getChpAgac().getContent());
			rootList=KisiListesi.getChpAgac();
			veriAlindi=true;
//			System.out.println("Arama L�stesi");
//			for(int i=0;i<KisiListesi.getAramaListesi().size();i++)
//				System.out.println(KisiListesi.getAramaListesi().get(i));
			
		}

		@Override
		protected void onPreExecute() {
			dialog=ProgressDialog.show(Yoneticiler.this, "Lütfen Bekleyin!", "Mesaj-Calculating",true);
			
			dialog.setMessage("Bilgiler yükleniyor! Lütfen bekleyiniz.");
			TextView text=(TextView) dialog.findViewById(android.R.id.message);
			text.setTextSize(17);
			dialog.show();

//			Toast.makeText(getApplicationContext(), "L�tfen bekleyiniz; bilgiler y�kleniyor.", Toast.LENGTH_SHORT).show();
		}

		@Override
		protected void onProgressUpdate(Void... values) {
			
		}
	}
	
	
	public class ServisDetay extends AsyncTask<Integer, Void, String>{
//		private ProgressDialog dialog = new ProgressDialog(Yoneticiler.this);
		 //EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		
		
		@Override
		protected String doInBackground(Integer... params) {
			//Sorgulama sorgu=new Sorgulama(params[0]);
			//String sonuc=sorgu.baglan();
			String sonuc=null;
			
			int n=params[0];
			//System.out.println("Detayı istenen: "+n);
			
			int index=alinanDetay.indexOf(istenenYoneticiId);
			//System.out.println("index: "+index);
			if(index==-1){			
				// Yönetici Detay
				
				if(baglantiKuntrolu()==true){
					YoneticilerDetaySorgu sorgu=new YoneticilerDetaySorgu(n);
					sonuc=sorgu.baglan();
					
					//System.out.println("Detay sonuc: "+sonuc);
					
//					ArrayList<KisiBilgileri> kisi=KisiBilgileri.veriAl(sonuc, "detay");
					KisiBilgileri.veriAl(sonuc, "detay");
					//System.out.println("Ki�i Array: ");
//					KisiBilgileri k=kisi.get(0);
					//System.out.println("Yöneticiler Lİste 118: "+k.getId()+"\n"+k.getIsim()+"\n"+k.getUnvan()+"\n"+k.getIl()+"\n"+k.getIlce()+"\n"+k.getCeptel()+"\n"+k.getPartiTel()+"\n"+k.getMail()+"\n");
					//System.out.println("Yöneticiler Lİste 119: "+k.toString());
//					KisiListesi.ekle(k);
					//KisiListesi.ekle(unvanlar.get(n-1), kisi);
					//System.out.println("Detaylar Yönetciler: "+k.isDetaylar());
					alinanDetay.add(istenenYoneticiId);
				}
				
				
				
				
			}
			return sonuc;
		}

		@Override
		protected void onPostExecute(String string) {
			
			
//			dialog.dismiss();
		
			
			Intent i=new Intent(Yoneticiler.this, YoneticiDetay.class);  // this; yonlendirmenin yapıldığı activity. 
			i.putExtra("yoneticiId", istenenYoneticiId);
			startActivity(i);
			

		}

		@Override
		protected void onPreExecute() {
//			dialog=ProgressDialog.show(Yoneticiler.this, "Baslik", "Mesaj-Calculating",true);
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
	

	
	
	
	@Override
	public void onBackPressed() {
		
		//android.os.Process.killProcess(android.os.Process.myPid());
		//System.exit(0);
		//finish();
		moveTaskToBack(true);
	}

	
}
