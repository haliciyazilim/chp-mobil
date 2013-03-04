package com.halici.mobilchp.sinif;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;

public class Resim {

	private static ArrayList<URLImage> images = new ArrayList<URLImage>();
	
	public static BitmapDrawable resimGetir(String string){
		BitmapDrawable arkaplan=new BitmapDrawable();
		try {
			
//			URL url = new URL(string);
//			URLConnection baglanti=url.openConnection();
//			baglanti.connect();
//			
//			Bitmap resim=BitmapFactory.decodeStream(url.openConnection().getInputStream());
			Bitmap resim = Resim.getImage(string);
			arkaplan=new BitmapDrawable(resim);
			
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return arkaplan;

	}
	
	
	public static Bitmap getImage(String stringUrl) throws IOException{
		URL url = new URL(stringUrl);
		if(findImage(url) != null){
			System.out.println("Resim bulundu.: "+stringUrl);
			return findImage(url).image;
		}
		else
			System.out.println("Resim bulunamadý.: "+stringUrl);
			
		
		URLConnection baglanti=url.openConnection();
		baglanti.connect();
		Bitmap resim=BitmapFactory.decodeStream(url.openConnection().getInputStream());
		
		URLImage img = new URLImage(url,resim);
		images.add(img);
		return resim;
		
		
	}
	private static URLImage findImage(URL url){
		for(int i=0;i<images.size();i++)
			if(((URLImage)images.get(i)).url.equals(url))
				return (URLImage)images.get(i);
		return null;
	}
	
}



class URLImage{
	public URL url;
	public Bitmap image;
	public URLImage(URL url, Bitmap image){
		this.url = url;
		this.image = image;
	}
}


