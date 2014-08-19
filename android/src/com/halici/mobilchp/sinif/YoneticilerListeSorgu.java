package com.halici.mobilchp.sinif;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.util.Log;

public class YoneticilerListeSorgu {
	

	// webServisin yeri
	final static String NAMESPACE="http://tempuri.org/";
			 
	// kullanýlan metot
	final static String METHOD_NAME="YoneticiListesiGetir";
			 
	// soap_action
	final static String SOAP_ACTION="http://tempuri.org/YoneticiListesiGetir_V2";
			 
	// webservise ait url tanýmlamasý
	final static String URL = "http://bilisim.chp.org.tr/MobilService.asmx";
	
	
	public String baglan(){
		String sonuc = null;
		// soap nesnesi
		SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME);
					
		// requeste bilgi ekleniyor. V2'de gerek kalmadý.
		//request.addProperty("unvanId", 1);
					
		//Web servisin versiyonunu bildiriyoruz.
		SoapSerializationEnvelope soapEnvelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
					
		//dot.net ile hazýrlandýðý için
		soapEnvelope.dotNet = true;
					
		//requesti zarfa koyuoyoruz.
		soapEnvelope.setOutputSoapObject(request);
					
		//transfer deðeri oluþturuyoruz
		HttpTransportSE aht = new HttpTransportSE(URL);
		aht.debug=true;
					
		try {
			System.out.println("try içindeiym.");
			
			// Ve son olarak istediðimizi gönderiyoruz.
			aht.call(SOAP_ACTION, soapEnvelope);
			aht.setXmlVersionTag("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			aht.debug=true;
			
			// Cevap olarak basit bir veri tipi beklediðimiz için,
			// cevabý SoapPrimitive nesnesi olarak alýyoruz.
			SoapPrimitive sonucSoap = (SoapPrimitive) soapEnvelope.getResponse();
			
			
			
			sonuc=sonucSoap.toString();
					
				
//			System.out.println("Yöneticiler sorgu Gelen Veri: ");
//			System.out.println(sonuc);
			
					
			System.out.println("try sonu");
		} 
		catch (Exception e) {
			Log.i("hata",e.toString());
				e.printStackTrace();
		} 
		
		
		return sonuc;
	}

	

}
