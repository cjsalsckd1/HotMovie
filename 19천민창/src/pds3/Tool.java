package pds3;

public class Tool {
	public static synchronized String checkNull(String str) {
		if(str == null) {
			str="";
		}else {
			if(str.equals("null")) {
				str="";
			}else {
				str=str.trim();//문자열 좌우의 공백 제거
			}
		}
		return str;
	}
	/**
	 * 메소드 실행을 요청에 대한 순차적 실행
	 * @param str
	 * @return
	 */
	public static synchronized String convertChar(String str) {
		str=str.replaceAll("<", "<");
		str=str.replaceAll(">", ">");
		str=str.replaceAll("'",  "'");
		str=str.replaceAll("\"", "\"");
		str=str.replaceAll("\r\n",  "<br>");
		
		return str;
	}
	/**
	 * 파일의 확장자를 추출합니다..
	 * @param name 파일명
	 * @return 파일 확장자 예)winter.jpg  -> jpg 
	 */
	public static synchronized String fileExtend(String file) {
		if(file != null) {
			file = file.toLowerCase();
			
			int point = file.lastIndexOf(".");
			file = file.substring(point+1);
		}else {
			file = "";
		}
		return file;
	}
	/** 
	 * 정수형 파일 크기에 데이터 단위를 추가 합니다.
	 * @param length
	 * @return
	 */
	 public static synchronized String unit(long length) {
		String str="";
		
		if(length < 1024) {
			str=length + " Byte";
		}else if(length < (1024*1024)){
			str=length/1024 + " KB";
		}else if(length < (1024*1024*1024)){
			str=length/1024/1024/1024 + " MB";
		}else if(length < (1024*1024*1024*1024)){
			str = length/1024/1024/1024 + " GB";
		}
		return str;
	}
	 
	 /**
	  * 이미지인지 검사합니다.
	  * @param file 검사할 파일명
	  * @return true: 이미지, false: 이미지 아님
	  */
	public static synchronized boolean isImage(String file) {
		boolean sw = false;
		
		if(file != null) {
			file = file.toLowerCase();
			
			int point = file.lastIndexOf(".");
			String ext = file.substring(point+1);
			
			if(ext.equals("jpg") || ext.equals("gif") || ext.equals("png")) {
				sw = true;
				
			}
		}
		return sw;
	}
}
	
