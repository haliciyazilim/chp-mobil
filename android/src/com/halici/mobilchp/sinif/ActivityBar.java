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


import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.widget.Button;
import android.widget.Toast;

import com.halici.mobilchp.activity.Haberler;
import com.halici.mobilchp.activity.Kurumsal;
import com.halici.mobilchp.activity.R;
import com.halici.mobilchp.activity.Yoneticiler;

import java.util.ArrayList;
import java.util.List;



public class ActivityBar {

	protected List<Button> buttons;
	protected int currentBtnId = -1;
	protected Activity parentActivity = null;
	protected Drawable drawableTop;
    /*
    private final int ID_BUTTON_HABER = 1;
    private final int ID_BUTTON_KURUMSAL = 2;
    private final int ID_BUTTON_YONETIM = 3;
    private final int ID_BUTTON_WEBTV = 4;
    */
	
	
	//Connect to the activity that's currently running, call this after setting 
	//the contentview in onCreate
	public void connectToActivity(Activity activity)
	{
		parentActivity = activity;
		
		buttons.clear();
		setupButton(R.id.btnHaber);
		setupButton(R.id.btnKurumsal);
		setupButton(R.id.btnYonetim);
		setupButton(R.id.btnWebTv);
		
		
		//If there's a current button set, light it up
		if (currentBtnId != -1)
			pressButtonById(currentBtnId);
	}
	
	//Helper function for connectToActivity
	protected void setupButton(int id)
	{
		Button but = (Button) parentActivity.findViewById(id);
		buttons.add(but);
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
		for (Button bt : buttons) {
			if (nIdPressed == bt.getId()) {
				bFoundButton=true;
				//bt.setBackgroundResource(R.color.activity_bar_button_selected);
				//bt.setCompoundDrawablesWithIntrinsicBounds(null, drawableTop, null, null);
				System.out.println("nIdPressed: "+nIdPressed+", bt Id: "+bt.getText());
				
				if(bt.getText().equals("Haberler"))
					drawableTop= parentActivity.getResources().getDrawable(R.drawable.icon_haber_selected);
				else if(bt.getText().equals("Kurumsal"))
					drawableTop= parentActivity.getResources().getDrawable(R.drawable.icon_kurumsal_selected);
				else if(bt.getText().equals("Yönetim"))
					drawableTop= parentActivity.getResources().getDrawable(R.drawable.icon_yonetim_selected);
                else {  //WEB TV
                    drawableTop= parentActivity.getResources().getDrawable(R.drawable.icon_webtv_selected);
                }
				
				bt.setCompoundDrawablesWithIntrinsicBounds(null, drawableTop, null, null);
			}
			else {
				bt.setPressed(false);			
				bt.setBackgroundResource(android.R.color.transparent);
			}
		}
	
		
		//If we asked to switch activities and the button passed in was good, do it
		if (bSwitchActivity && bFoundButton && nIdPressed!= currentBtnId && parentActivity !=null) {
			switch (nIdPressed) {
			case R.id.btnHaber: 	switchActivity(new Intent(parentActivity, Haberler.class)); break;
			case R.id.btnKurumsal: 	switchActivity(new Intent(parentActivity, Kurumsal.class)); break;
			case R.id.btnYonetim: 		switchActivity(new Intent(parentActivity, Yoneticiler.class)); break;
                case R.id.btnWebTv:
                    //switchActivity(new Intent(parentActivity, WebTv.class));
                    /*
                    Intent intent= new Intent();
                    intent.setAction("android.intent.action.VIEW");
                    Uri content_url = Uri.parse("http://www.chp.org.tr/custom-scripts/webtv.html");
                    intent.setData(content_url);
                    intent.setClassName("com.android.chrome","com.android.chrome.mai");
                    startActivity(intent);*/


                    try {
                        Intent i = new Intent("android.intent.action.MAIN");
                        i.setComponent(ComponentName.unflattenFromString("com.android.chrome/com.android.chrome.Main"));
                        i.addCategory("android.intent.category.LAUNCHER");
                        i.setData(Uri.parse("http://www.chp.org.tr/custom-scripts/webtv.html"));
                        parentActivity.startActivity(i);
                    }
                    catch(ActivityNotFoundException e) {
                        // Chrome is probably not installed
                    }

                    /*
                    Intent myIntent;
                    PackageManager pm = parentActivity.getPackageManager();
                    try{
                        myIntent = pm.getLaunchIntentForPackage("com.mxtech.videoplayer.pro");
                        myIntent.setComponent(new ComponentName("com.mxtech.videoplayer.pro", "com.mxtech.videoplayer.ActivityScreen"));
                        myIntent.setDataAndType(Uri.parse("http://www.chp.org.tr/custom-scripts/webtv.html"), "application/x-mpegURL");
                        myIntent.putExtra("secure_uri", true);
                        //myIntent.putExtra(parentActivity.EXTRA_DECODE_MODE, (byte)2);
                        if (null != myIntent)
                            parentActivity.startActivity(myIntent);
                    }
                    catch (ActivityNotFoundException e)
                    {

                        Toast.makeText(parentActivity,
                                " stream not working ",
                                Toast.LENGTH_LONG).show();
                    }*/


                    break;
			}
		}		

		currentBtnId = bFoundButton ? nIdPressed : -1;
	}
	

	
	protected void switchActivity(Intent i) {
		parentActivity.startActivity(i);
		parentActivity.overridePendingTransition(0, 0);		//No animation
		parentActivity.finish();								//We want to replace the current activity, not stack them
	}


	//////////////////////////////////////////////////////////////////////////////////////////	
	//Singleton stuff
	//////////////////////////////////////////////////////////////////////////////////////////	
	private static ActivityBar m_hInstance = null;

	private ActivityBar() {
		buttons = new ArrayList<Button>();
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
