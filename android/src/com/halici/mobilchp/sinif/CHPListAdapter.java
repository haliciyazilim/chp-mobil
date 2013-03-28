package com.halici.mobilchp.sinif;

import java.util.ArrayList;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

public class CHPListAdapter extends ArrayAdapter<CHPObject>{

	private ArrayList<CHPObject> items;
	private Context context;
	private int layout;
	private int textViewResourceId;
	
	public CHPListAdapter(Context context, int layout, int textViewResourceId, ArrayList<CHPObject> items) {
        super(context,layout, textViewResourceId, items);
        this.context = context;
        this.items = items;
        this.layout=layout;
        this.textViewResourceId=textViewResourceId;
    }

	
	public View getView(int position, View convertView, ViewGroup parent) {
        View view = convertView;
        if (view == null) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            view = inflater.inflate(this.layout, null);
        }

        CHPObject item = items.get(position);
        if (item!= null) {
            
            TextView itemView = (TextView) view.findViewById(this.textViewResourceId);
            if (itemView != null) {
                
            	if(item instanceof CHPListe){
            		itemView.setText(((CHPListe) item).getName());
            	}
            	else if(item instanceof CHPPerson){
            		itemView.setText(((CHPPerson) item).getIsim());
            	}
            }
         }
        else{
        	
        }

        return view;
    }
	
}
