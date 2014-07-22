package com.useeasy.frame.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

import org.apache.commons.lang.RandomStringUtils;

public class Tools {

	public static boolean checkRegen(String pattern, String target){
		if(target == null){
			return false;
		}
		Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(target);
        return m.matches();
    }
	
	@SuppressWarnings("deprecation")
	public static Date getStartTimeByToday() {
		Date date = new Date();
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}
	
	@SuppressWarnings("deprecation")
	public static Date getEndTimeByToday() {
		Date date = new Date();
		date.setHours(23);
		date.setMinutes(59);
		date.setSeconds(59);
		return date;
	}
	
	@SuppressWarnings("deprecation")
	public static Date getEndTimeByNextThirtyDay() {
		Date date = new Date();
		date.setDate(date.getDate() + 30);
		date.setHours(23);
		date.setMinutes(59);
		date.setSeconds(59);
		return date;
	}
	
	@SuppressWarnings("deprecation")
	public static Date getStartTimeByYear() {
		Date date = new Date();
		date.setMonth(0);
		date.setDate(1);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}
	
	@SuppressWarnings("deprecation")
	public static Date getEndTimeByYear() {
		Date date = new Date();
		date.setMonth(11);
		date.setDate(31);
		date.setHours(23);
		date.setMinutes(59);
		date.setSeconds(59);
		return date;
	}
	
	@SuppressWarnings("deprecation")
	public static Date getStartTimeByMonth() {
		Date date = new Date();
		date.setDate(1);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}
	
	@SuppressWarnings("deprecation")
	public static Date getStartTimeByNextMonth() {
		Date date = new Date();
		date.setMonth(date.getMonth() + 1);
		date.setDate(1);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}
	
	public static String dateToString(Date date, String pattern) {
		if(date == null || pattern == null){
			return null;
		}
		DateFormat df = new SimpleDateFormat(pattern);
		try {
			return df.format(date);
		} catch (Exception ex) {
			return null;
		}
	}
	
	public static Date stringToDate(String dateText, String pattern) {
		if(dateText == null){
			return null;
		}
		DateFormat df = new SimpleDateFormat(pattern);
		try {
			return df.parse(dateText);
		} catch (Exception ex) {
			return null;
		}
	}
	
	public static boolean createThumb(File imageFile, String thumbFile){
		Image img = null;
		File newImage = null;
		boolean flag = false;
		try {
			img = ImageIO.read(imageFile);  //构造Image对象
	    
		    int width_o = img.getWidth(null);   //得到源图宽
		    int height_o = img.getHeight(null);  //得到源图高
		    int width_n = 480;//120;//387;         //缩略图宽
		    int height_n = 418;//90;//290;       //缩略图高
		    
		    if(width_o >= width_n || height_o >= height_n){
			    double tempW;
			    double tempH;
			    tempW = (double)width_n/(double)width_o;
			    tempH = (double)height_n/(double)height_o;
			    //按比例进行缩放
			    if(tempW >= tempH){
			    	width_n = (int)(tempH * width_o);
			    	height_n = (int)(tempH * height_o);
			    }else{
			    	width_n = (int)(tempW * width_o);
			    	height_n = (int)(tempW * height_o);
			    }
		    }else{
		    	width_n = width_o;
		    	height_n = height_o;
		    }
		    BufferedImage tag = new BufferedImage(width_n, height_n, BufferedImage.TYPE_INT_RGB);
		    tag.getGraphics().drawImage(img,0,0,width_n,height_n,null);       	 //绘制缩小后的图
		    newImage = new File(thumbFile);
		    ImageIO.write(tag, "jpg", newImage);
		    flag = true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		return flag;
	}
	
	public static Long getLongValue(Object object) {
		if(object == null){
			return null;
		}else 
			return Long.parseLong(object.toString());
	}
	
	public static String getStringValue(Object object) {
		if(object == null){
			return null;
		}else 
			return object.toString();
	}
	
	public static Date getDateValue(Object object) {
		if(object == null){
			return null;
		}else 
			return stringToDate(object.toString(), "yyyy-MM-dd HH:mm:ss");
	}
	
	public static String getMoneyFormat(String double_value){
		DecimalFormat doubleFarmat = new DecimalFormat("0.00");
		return doubleFarmat.format(Double.parseDouble(double_value));
	}
	
	public static String StingToMD5(String inStr) {
		if(inStr == null)
			return "";
		
		MessageDigest md5 = null;   
		try {   
			md5 = MessageDigest.getInstance("MD5");   
		} catch (Exception e) {   
			e.printStackTrace();   
			return "";   
		}
  
		char[] charArray = inStr.toCharArray();   
		byte[] byteArray = new byte[charArray.length];   
  
		for (int i = 0; i < charArray.length; i++)   
			byteArray[i] = (byte) charArray[i];   
		byte[] md5Bytes = md5.digest(byteArray);   
  
		StringBuffer hexValue = new StringBuffer();   
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)   
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();   
		
	}
	
	
	public static void main(String[] args) throws Exception{
		 //String inStr = "666";
		 String inStr = "123456";
		 System.out.println(StingToMD5(inStr));
		//String randStr = RandomStringUtils.random(10, true, true);
		//System.out.println(randStr);
		//System.out.println(RandomStringUtils.random(15, true, true));
		/*System.out.println(getStartTimeByYear());
		System.out.println(getEndTimeByYear());
		System.out.println(getStartTimeByMonth());
		System.out.println(getStartTimeByNextMonth());*/
		 
		// String cpuid=getMotherboardSN();
		//	javax.swing.JOptionPane.showConfirmDialog((java.awt.Component)null,cpuid,"Motherboard serial number",javax.swing.JOptionPane.DEFAULT_OPTION);
	}
	//得到机器注册码
public static String getMotherboardSN() throws Exception{
 
		
		String line="";
		String HdSerial="";
		Process process=Runtime.getRuntime().exec("cmd /c dir c:");
		BufferedReader buffeader=new BufferedReader(new InputStreamReader(process.getInputStream()));
		
		while((line=buffeader.readLine())!=null){
			if((line.indexOf("卷的序列号是"))!=-1){
				HdSerial=line.substring(line.indexOf("卷的序列号是")+"卷的序列号是".length(), line.length());
				break;
			}
		}
		buffeader.close();
		return HdSerial;
	}
}
