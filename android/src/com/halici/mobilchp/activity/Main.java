package com.halici.mobilchp.activity;


import com.halici.mobilchp.sinif.ActivityBar;


import android.os.Bundle;
import android.app.Activity;


public class Main extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		
		 ActivityBar ab = ActivityBar.getInstance();
	        ab.connectToActivity(this);
	        
	        //HACK, for now just start the trail running activity
	        ab.pressButtonById(R.id.btnHaber, true);			//Manually press the airports button
	        
	        System.out.println("MAÝN: "+this);
	}

	

}
