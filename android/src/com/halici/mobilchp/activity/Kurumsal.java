package com.halici.mobilchp.activity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import com.halici.mobilchp.sinif.ActivityBar;


import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.content.res.AssetManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class Kurumsal extends Activity{
	ImageView tarih, tuzuk, program;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.kurumsal);

		tarih=(ImageView) findViewById(R.id.tvTarih);
		tuzuk=(ImageView) findViewById(R.id.tvTuzuk);
		program=(ImageView) findViewById(R.id.tvProgram);
		
		tarih.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				pdfDinleyinici(v);
				
			}
		});
		
		tuzuk.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				pdfDinleyinici(v);
				
			}
		});
		program.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				pdfDinleyinici(v);
				
			}
		});
		
		ActivityBar.getInstance().connectToActivity(this);
	}
	
	public void pdfDinleyinici(View v){
		if(tarih==v)
			pdfAc("tarih.pdf");
		else if(tuzuk==v)
			pdfAc("tuzuk.pdf");
		else if(program==v)
			pdfAc("program.pdf");
	}
	
	public void pdfAc(String pdf){
		AssetManager assetManager=Kurumsal.this.getAssets();
		try {
			InputStream inputStream=assetManager.open(pdf);
			
			File sdCard=Environment.getExternalStorageDirectory();
			File klasor=new File(sdCard.getAbsolutePath()+"/CHPMobile");
			if(klasor.exists()==false)
				klasor.mkdir();
			File dosya=new File(klasor, pdf);
			FileOutputStream fos=new FileOutputStream(dosya);
			byte[] data = new byte[inputStream.available()];
			inputStream.read(data);
	        fos.write(data);
	        inputStream.close();
	        fos.close();
			
			
			
			Uri path = Uri.fromFile(dosya);      
	        Intent intent = new Intent(Intent.ACTION_VIEW);
	        intent.setDataAndType(path, "application/pdf");
	        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
	        
	        startActivity(intent);
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		catch (ActivityNotFoundException e) {
             Toast.makeText(Kurumsal.this, "Cihazınızda PDF okuyucu bulunmamaktadır; lütfen yükleniyiniz.", Toast.LENGTH_LONG).show();
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
