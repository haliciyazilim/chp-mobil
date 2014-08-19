package com.halici.mobilchp.sinif;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class CHPListe extends CHPObject{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String header;
	private ArrayList<CHPObject> content;
	
	
	public CHPListe() {
		super();
		this.content= new ArrayList<CHPObject>();
	}


	public void addObject(CHPObject obje){
		this.content.add(obje);
	}
	
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}


	public ArrayList<CHPObject> getContent() {
		return content;
	}
	public void setContent(ArrayList<CHPObject> content) {
		this.content = content;
	}


	@Override
	public String getType() {
		// TODO Auto-generated method stub
		return super.getType();
	}


	@Override
	public void setType(String type) {
		// TODO Auto-generated method stub
		super.setType(type);
	}


	@Override
	public void yazdir() {
		System.out.println("CHPListe yazdır()..ContenSize: "+content.size()+", "+this.getName());
		
		for(int i=0; i<content.size();i++){
			if(this.content.get(i) instanceof CHPListe)
				System.out.println("CHPListe yazdır()..: "+((CHPListe)this.content.get(i)).getName());
			else if(this.content.get(i) instanceof CHPPerson)
				((CHPPerson)this.content.get(i)).yazdir();
			
			
		}
		
	}
	
	
//	public void fillContentByJson(JSONObject contentJson){
//		
//	}

	public static CHPListe fromJSON(JSONObject json){
		CHPListe liste = new CHPListe();
		
		try {
			JSONArray array = new JSONArray(json.getString("Content"));
			liste.setType(json.getString("Type"));
			liste.setName(json.getString("Name"));
			
			if(json.isNull("Header")==false)
				liste.setHeader(json.getString("Header"));
			else
				liste.setHeader("null");
			
			for(int i=0; i<array.length();i++){
				if(array.getJSONObject(i).getString("Type").equals("list")){
					liste.addObject(CHPListe.fromJSON(array.getJSONObject(i)));
					//System.out.println("CHPL�ste.."+array.getJSONObject(i));
					
				}
				
				else{
					liste.addObject(CHPPerson.fromJSON(array.getJSONObject(i)));
				}
				
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		System.out.println("CHPfomJson"+liste.getContent().size());
		return liste;
	}

	
	

}
