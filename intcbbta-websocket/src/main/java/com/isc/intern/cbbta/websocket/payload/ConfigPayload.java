package com.isc.intern.cbbta.websocket.payload;

import java.io.Serializable;

public class ConfigPayload implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long scoreFaceCompare;

	public Long getScoreFaceCompare() {
		return scoreFaceCompare;
	}

	public void setScoreFaceCompare(Long scoreFaceCompare) {
		this.scoreFaceCompare = scoreFaceCompare;
	}
		
}
