package com.server.data.util;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class StringProcessing {

	private String targetString = null;

	public StringProcessing() {
	}

	public StringProcessing(String targetString) {
		this.targetString = targetString;
	}

	public Map<String, String> getContent() {
		Map<String, String> contentMap = new HashMap<String, String>();
		String contentName = null;
		String content = null;
		String[] detachedString = null;

		if (targetString == null) {
			return null;
		}

		detachedString = targetString.split(" ");
		
		String[] newString = Arrays.copyOfRange(detachedString, 1, detachedString.length);

		contentName = newString[0];
		
		content = Arrays.deepToString(newString);

		int index1 = content.indexOf("(");
		int index2 = content.indexOf(")");

		content = content.substring(index1 + 1, index2);

		contentMap.put(contentName, content);
		
		return contentMap;
	}

	public void setTargetString(String targetString) {
		this.targetString = targetString;
	}

	public String getTargetString() {
		return targetString;
	}
}
