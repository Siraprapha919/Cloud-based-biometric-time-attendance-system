package com.isc.intern.cbbta.websocket.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.isc.intern.cbbta.websocket.payload.BlackWhiteStatusPayload;
import com.isc.intern.cbbta.websocket.payload.FaceDistributePayload;
import com.isc.intern.cbbta.websocket.payload.FaceExtractionPayload;
import com.isc.intern.cbbta.websocket.payload.FaceUpdatePayload;
import com.isc.intern.cbbta.websocket.payload.FaceUpdateStatusPayload;

@Service
public class SocketService {
	private final Logger logger = LoggerFactory.getLogger(SocketService.class);
	
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	public void faceExtraction(String primary,FaceExtractionPayload payload) {
		logger.info("faceExtraction get payload:"+payload.getUser_id());
		simpMessagingTemplate.convertAndSend("/face_extraction/"+primary, payload);
	}
	public void faceDistribution(FaceDistributePayload payload) {
		logger.info("faceDistribution get payload:"+payload.getUser_id());
		simpMessagingTemplate.convertAndSend("/face_distribute", payload);
	}

	public void deleteface(FaceDistributePayload o) {
		simpMessagingTemplate.convertAndSend("/face_delete",o);
	}
	
}
