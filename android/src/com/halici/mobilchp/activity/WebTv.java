package com.halici.mobilchp.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;

/**
 * Created by Gilean on 14.03.2014.
 */
public class WebTv extends Activity {
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WebView webview = new WebView(this);

        WebSettings settings = webview.getSettings();
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        settings.setJavaScriptEnabled(true);

        WebChromeClient client = new WebChromeClient();
        webview.setWebChromeClient(client);
        /*
        webview.setWebViewClient(new WebViewClient() {
            public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
                Toast.makeText(WebTv.this, "Hata oluştu.", Toast.LENGTH_SHORT).show();
            }
        });*/

        webview.loadUrl("http://www.chp.org.tr/custom-scripts/webtv.html");   //CHP WEBTV
        //webview.loadUrl("http://www.youtube.com/watch?v=rDHmv0R0VG8");  //TSUBASA
        //webview.loadUrl("http://www.google.com.tr/");                 //GOOGLE

        setContentView(webview);

        /*
        setContentView(R.layout.webtv);
        ActivityBar.getInstance().connectToActivity(this);
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.chp.org.tr/custom-scripts/webtv.html"));
        startActivity(browserIntent);
        */
    }

    @Override
    public void onBackPressed() {
        Intent intent = new Intent(this, Main.class);
        startActivity(intent);
    }
}