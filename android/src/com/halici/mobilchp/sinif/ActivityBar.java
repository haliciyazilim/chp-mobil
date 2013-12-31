//
// ActivityBar.java
// Singleton activity bar class
//
// To use with an Activity:
//    * Include a-activity-bar layout file in the layout for your activity's view
//    * Call connectToActivity from your activity's onCreate, after setting the content view
//    
// When a button is pressed, the object will handle the activity switch, etc...


package com.halici.mobilchp.sinif;


import java.util.ArrayList;
import java.util.List;

import com.halici.mobilchp.activity.Haberler;
import com.halici.mobilchp.activity.Kurumsal;
import com.halici.mobilchp.activity.R;
import com.halici.mobilchp.activity.Yoneticiler;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.widget.Button;



public class ActivityBar {

	protected List<Button> m_arrButton;
	protected int m_iCurrentButtonId= -1;
	protected Activity m_currentActivity = null;
	protected Drawable drawableTop;

	
	
	//Connect to the activity that's currently running, call this after setting 
	//the contentview in onCreate
	public void connectToActivity(Activity activity)
	{
		m_currentActivity = activity;
		
		m_arrButton.clear();
		setupButton(R.id.btnHaber);
		setupButton(R.id.btnKurumsal);
		setupButton(R.id.btnYonetim);
		
		
		
		//If there's a current button set, light it up
		if (m_iCurrentButtonId != -1) 
			pressButtonById(m_iCurrentButtonId);
	}
	
	//Helper function for connectToActivity
	protected void setupButton(int id)
	{
		Button but = (Button)m_currentActivity.findViewById(id);
		m_arrButton.add(but);
		but.setOnTouchListener(new OnTouchListener() {		
			@Override
			public boolean onTouch(View v, MotionEvent me) {
				if (me.getAction() == MotionEvent.ACTION_UP) 
					pressButtonById(v.getId(), true);
				
				return true;
			}
		});				
	}
	
	
	
	//Default to not switching the activity if not specified
	public void pressButtonById(int nIdPressed)
	{
		pressButtonById(nIdPressed, false);
	}
	
	public void pressButtonById(int nIdPressed, boolean bSwitchActivity)
	{
		boolean bFoundButton = false;
		
		//Unpress all the buttons except the one we passed in
		for (Button bt : m_arrButton) {
			if (nIdPressed == bt.getId()) {
				bFoundButton=true;
				//bt.setBackgroundResource(R.color.activity_bar_button_selected);
				//bt.setCompoundDrawablesWithIntrinsicBounds(null, drawableTop, null, null);
				System.out.println("nIdPressed: "+nIdPressed+", bt Id: "+bt.getText());
				
				if(bt.getText().equals("Haberler"))
					drawableTop=m_currentActivity.getResources().getDrawable(R.drawable.icon_haber_selected);
				else if(bt.getText().equals("Kurumsal"))
					drawableTop=m_currentActivity.getResources().getDrawable(R.drawable.icon_kurumsal_selected);
				if(bt.getText().equals("Yönetim"))
					drawableTop=m_currentActivity.getResources().getDrawable(R.drawable.icon_yonetim_selected);
				
				bt.setCompoundDrawablesWithIntrinsicBounds(null, drawableTop, null, null);
			}
			else {
				bt.setPressed(false);			
				bt.setBackgroundResource(android.R.color.transparent);
				
			}
		}
	
		
		//If we asked to switch activities and the button passed in was good, do it
		if (bSwitchActivity && bFoundButton && nIdPressed!=m_iCurrentButtonId && m_currentActivity!=null) {  
			switch (nIdPressed) {
			case R.id.btnHaber: 	switchActivity(new Intent(m_currentActivity, Haberler.class)); break;
			case R.id.btnKurumsal: 	switchActivity(new Intent(m_currentActivity, Kurumsal.class)); break;
			case R.id.btnYonetim: 		switchActivity(new Intent(m_currentActivity, Yoneticiler.class)); break;
			
			}
		}		

		m_iCurrentButtonId = bFoundButton ? nIdPressed : -1;		
	}
	

	
	protected void switchActivity(Intent i) {
		m_currentActivity.startActivity(i);
		m_currentActivity.overridePendingTransition(0,0);		//No animation
		m_currentActivity.finish();								//We want to replace the current activity, not stack them
	}


	
	
	
	
	

	//////////////////////////////////////////////////////////////////////////////////////////	
	//Singleton stuff
	//////////////////////////////////////////////////////////////////////////////////////////	
	private static ActivityBar m_hInstance = null;

	private ActivityBar() {
		m_arrButton = new ArrayList<Button>();
	}


	public static synchronized ActivityBar getInstance() {
		if (m_hInstance == null)						//Create on first demand
			m_hInstance = new ActivityBar();
		return m_hInstance;
	}


	//Call once for clean-up ... not sure I even need this, Tom Barry thinks this will all get GC'd 
	//when the program exits.
	public void Destroy() {
		if (m_hInstance != null) {
			//Do other clean up here...

			m_hInstance = null;								//Free up for garbage collection...
		}
	}
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Singleton stuff
	//////////////////////////////////////////////////////////////////////////////////////////	
}
