package com.server.data.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringProcessing {

	private String targetString = null;
	private final String[] filter = { "성상", "납", "카드뮴", "수은", "비소", "대장균군", "붕해" };
	private Pattern pattern = Pattern.compile("(\\d*)(\\.|,*)(\\d+)(\\s*)(mg|ug)");

	public StringProcessing() {
	}

	public StringProcessing(String targetString) {
		this.targetString = targetString;
	}

	public Map<String, String> getContent() {
		if (targetString == null) {
			return null;
		}

		Map<String, String> contentMap = new HashMap<String, String>();
		String[] splitStr = targetString.split("\n");
		Vector<String> contents = filtering(splitStr);

		if (contents.size() == 0) {
			return null;
		}

		for (String content : contents) {
			Matcher matcher = pattern.matcher(content);
			while (matcher.find()) {
				System.out.println(content);
				System.out.println(matcher.group());
				break;
			}
		}

		return contentMap;
	}

	public Vector<String> filtering(String[] target) {
		Vector<String> result = new Vector<String>();

		for (String temp : target) {

			if (checking(temp) == false) {
				result.add(temp);
			}

		}

		return result;
	}

	public boolean checking(String target) {
		boolean check = false;

		for (String str : filter) {
			if (target.contains(str) == true) {
				return true;
			}
		}

		return false;
	}

	public void setTargetString(String targetString) {
		this.targetString = targetString;
	}

	public String getTargetString() {
		return targetString;
	}
}
