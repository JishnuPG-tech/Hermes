package com.anthropic.hermes;

import android.os.AsyncTask;
import android.util.Log;
import org.json.JSONObject;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * HermesLog - Real-Time Telemetry & Log Dispatcher
 * Injected into Claude Android APK to capture live application events,
 * network traces, and artifact rendering state, and stream them
 * directly to the Hermes backend server dashboard.
 */
public class HermesLog {
    private static final String TAG = "HermesLog";
    private static final String ENDPOINT = "https://jishnupg-hermes.hf.space/api/telemetry/log";

    public static void log(String level, String tag, String message) {
        Log.println(Log.INFO, tag, message);
        sendTelemetryAsync(level, tag, message);
    }

    private static void sendTelemetryAsync(final String level, final String tag, final String message) {
        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... voids) {
                try {
                    URL url = new URL(ENDPOINT);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("POST");
                    conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
                    conn.setConnectTimeout(3000);
                    conn.setReadTimeout(3000);
                    conn.setDoOutput(true);

                    JSONObject payload = new JSONObject();
                    payload.put("level", level);
                    payload.put("tag", tag);
                    payload.put("message", message);
                    payload.put("timestamp", System.currentTimeMillis());

                    byte[] out = payload.toString().getBytes("UTF-8");
                    OutputStream os = conn.getOutputStream();
                    os.write(out);
                    os.flush();
                    os.close();

                    int code = conn.getResponseCode();
                    conn.disconnect();
                } catch (Exception e) {
                    // Fail silently to never degrade mobile UX
                }
                return null;
            }
        }.execute();
    }
}
