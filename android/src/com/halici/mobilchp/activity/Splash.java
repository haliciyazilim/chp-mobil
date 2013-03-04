package com.halici.mobilchp.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.Bundle;


public class Splash extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splash);
		
	    new Thread() {
            public void run() {
                try{
                   
                    sleep(1500);
                } catch (Exception e) {
                }
              
                new Thread() {
                    public void run() {
                   
                   Intent anaSayfa=new Intent(Splash.this, Main.class);
                   startActivity(anaSayfa);
                   
                    }
                }.start();
            }
        }.start();  
	    
	   
	}

	
	
}
