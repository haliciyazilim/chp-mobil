package com.halici.mobilchp.sinif;


public class ListenerManager {

	public interface Listener{
		public void onStateChange(boolean state);
	}
	
	private Listener mListener=null;
	
	public void registerListener(Listener listener){
		mListener=listener;
	}
	
	private boolean isOnBackground;
	
	public void setIsBackground(boolean state){
		if(state)
			isOnBackground=true;
		else
			isOnBackground=false;
		
		mListener.onStateChange(isOnBackground);
	}
	
	
}
