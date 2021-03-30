package chiselgui;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Utils {

	public static String getString(String uri) {
		StringWriter sw = new StringWriter();
		try {
		 URL url = new URL("http://localhost:8080/chisel"+uri);
         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
         conn.setRequestMethod("GET");
         conn.setRequestProperty("Accept", "application/json");
         if (conn.getResponseCode() != 200) {
             throw new RuntimeException("Failed : HTTP Error code : "
                     + conn.getResponseCode());
         }
         InputStreamReader in = new InputStreamReader(conn.getInputStream());
         BufferedReader br = new BufferedReader(in);
         String output;
         while ((output = br.readLine()) != null) {
             sw.append(output);
         }
         conn.disconnect();
		}
		catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return sw.toString();
	}
	
	private static ArrayList<Map<String, Object>> jsonToTaskList(String taskListjson) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.readValue(taskListjson, ArrayList.class);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public static ArrayList<Map<String,Object>> getJsonList(String uri) {
		StringWriter sw = new StringWriter();
		try {
		 URL url = new URL("http://localhost:8080/chisel"+uri);
         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
         conn.setRequestMethod("GET");
         conn.setRequestProperty("Accept", "application/json");
         if (conn.getResponseCode() != 200) {
             throw new RuntimeException("Failed : HTTP Error code : "
                     + conn.getResponseCode());
         }
         InputStreamReader in = new InputStreamReader(conn.getInputStream());
         BufferedReader br = new BufferedReader(in);
         String output;
         while ((output = br.readLine()) != null) {
             sw.append(output);
         }
         conn.disconnect();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return jsonToTaskList(sw.toString());
	}
}
