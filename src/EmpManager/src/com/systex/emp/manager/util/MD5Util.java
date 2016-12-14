package com.systex.emp.manager.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {

	public static String byte2hex(byte[] bytes) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < bytes.length; ++i) {
			sb.append(Integer.toHexString(0x0100 + (bytes[i] & 0x00FF)).substring(1));
		}
		return sb.toString();
	}

	public static String md5hash(String str) {
		if (str == null) {
			return "";
		}

		try {
			MessageDigest alga = MessageDigest.getInstance("MD5");
			alga.update(str.getBytes());
			return byte2hex(alga.digest());
		} catch (NoSuchAlgorithmException e) {
			return "";
		}
	}

}
