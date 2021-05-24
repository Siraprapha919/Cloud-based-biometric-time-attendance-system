package com.isc.intern.cbbta.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.isc.intern.cbbta.bean.AttendanceResponse;
import com.isc.intern.cbbta.bean.BaseRequest;
import com.isc.intern.cbbta.bean.BaseResponse;
import com.isc.intern.cbbta.bean.ConfigInfoResponse;
import com.isc.intern.cbbta.bean.ConfigRequest;
import com.isc.intern.cbbta.bean.ConfigStatusRequest;
import com.isc.intern.cbbta.bean.FaceRegisterRequest;
import com.isc.intern.cbbta.bean.FaceUpdateStatusRequest;
import com.isc.intern.cbbta.bean.FaceUserResponse;
import com.isc.intern.cbbta.bean.InfoVisitorRequest;
import com.isc.intern.cbbta.bean.InfoVisitorResponse;
import com.isc.intern.cbbta.bean.LogVisiterRequest;
import com.isc.intern.cbbta.bean.LoginRequest;
import com.isc.intern.cbbta.bean.LoginResponse;
import com.isc.intern.cbbta.bean.PositionResponse;
import com.isc.intern.cbbta.bean.RegisterRequest;
import com.isc.intern.cbbta.bean.UserInfoRequest;
import com.isc.intern.cbbta.bean.UserInfoResponse;
import com.isc.intern.cbbta.bean.UserInfoUpdateRequest;
import com.isc.intern.cbbta.bean.WhiteBlackRequest;
import com.isc.intern.cbbta.common.constant.LookupConstant;
import com.isc.intern.cbbta.common.exception.ResponseException;
import com.isc.intern.cbbta.constant.ResponseCode;
import com.isc.intern.cbbta.entity.IntCbbtaMsTimeConfig;
import com.isc.intern.cbbta.entity.IntCbbtaTxAttendance;
import com.isc.intern.cbbta.entity.IntCbbtaTxCustomerInfo;
import com.isc.intern.cbbta.entity.IntCbbtaTxEmployee;
import com.isc.intern.cbbta.helper.RestRefNoHelper;
import com.isc.intern.cbbta.model.AttendanceModel;
import com.isc.intern.cbbta.model.UserModel;
import com.isc.intern.cbbta.service.DeviceService;
import com.isc.intern.cbbta.service.UserService;
import com.isc.intern.cbbta.websocket.payload.FaceDistributePayload;
import com.isc.intern.cbbta.websocket.payload.FaceExtractionPayload;
import com.isc.intern.cbbta.websocket.service.SocketService;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@RestController
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@Value("${intcbbta.token.secret}")
	private String tokenSecret;

	@Autowired
	private SocketService socketService;

	@Autowired
	private DeviceService deviceService;

	Date date = new Date();
	LocalDate year = LocalDate.now();

//	@RequestMapping(value = "/config_status", method = RequestMethod.POST)
//	public @ResponseBody BaseResponse statusConfig(@RequestBody ConfigStatusRequest request) {
//		BaseResponse response = new BaseResponse();
//		ResponseCode rc = null;
//		
//		response.setReqRefNo(request.getReqRefNo());
//		response.setRespRefNo(RestRefNoHelper.generateRefNo());
//		response.setRespCode(rc.code());
//		response.setRespDesc(rc.desc());
//		return response;
//	}
//	
//	@RequestMapping(value = "/config_info", method = RequestMethod.POST)
//	public @ResponseBody ConfigInfoResponse configInfo(@RequestBody BaseRequest request) {
//		ConfigInfoResponse response = new ConfigInfoResponse();
//		ResponseCode rc = null;
//		response.setReqRefNo(request.getReqRefNo());
//		response.setRespRefNo(RestRefNoHelper.generateRefNo());
//		response.setRespCode(rc.code());
//		response.setRespDesc(rc.desc());
//		return response;
//	}
//	@RequestMapping(value = "/config", method = RequestMethod.POST)
//	public @ResponseBody BaseResponse config(@RequestBody ConfigRequest request) throws ParseException {
//		BaseResponse response = new BaseResponse();
//		ResponseCode rc = null;
//		IntCbbtaMsTimeConfig config = new IntCbbtaMsTimeConfig();
//	    DateFormat dateFormat = new SimpleDateFormat("hh:mm");
//	    
//		LocalTime starts = LocalTime.parse(request.getTimeAttendanceStart());
//		LocalTime befores = LocalTime.parse(request.getTimeAttendanceBeforeLate());
//		LocalTime endss = LocalTime.parse(request.getTimeAttendanceEnd());
//		
//		if(!(starts.isBefore(befores)&&befores.isBefore(endss))){
//			rc =ResponseCode.DECLINED;
//			response.setReqRefNo(request.getReqRefNo());
//			response.setRespRefNo(RestRefNoHelper.generateRefNo());
//			response.setRespCode(rc.code());
//			response.setRespDesc(rc.desc());
//			return response;
//		}
//	
//				config.setScoreFaceCompare(Long.valueOf(request.getScoreFaceCompare()));
//				config.setTimeAttendanceStart(dateFormat.parse(request.getTimeAttendanceStart()));
//				config.setTimeAttendanceBeforeLate(dateFormat.parse(request.getTimeAttendanceBeforeLate()));
//				config.setTimeAttendanceEnd(dateFormat.parse(request.getTimeAttendanceEnd()));
//				config.setSickDays(Long.valueOf(request.getSickDays()));
//				config.setCasualDays(Long.valueOf(request.getCasualDays()));
//				config.setVacationDays(Long.valueOf(request.getVacationDays()));
//				
//				config.setRecordCreatedId(Long.valueOf(request.getCustomerNo()));
//				config.setRecordCreatedName(request.getNameEn());
//				config.setRecordCreatedDate(date);
//				config.setRecordCreatedTeamCode(request.getPosition());
//				
//				config.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
//				config.setRecordUpdatedId(Long.valueOf(request.getCustomerNo()));
//				config.setRecordUpdatedName(request.getNameEn());
//				config.setRecordUpdatedTeamCode(request.getPosition());
//				config.setRecordUpdatedDate(date);
//			
//				config.setRecordUpdatedId(Long.valueOf(request.getCustomerNo()));
//				config.setRecordUpdatedName(request.getNameEn());
//				config.setRecordUpdatedTeamCode(request.getPosition());
//				config.setRecordUpdatedDate(date);
//		if(userService.config(config)) {
//			rc = ResponseCode.APPROVED;
//		}else {
//			rc = ResponseCode.INTERNAL_ERROR;
//		}
//				
//		response.setReqRefNo(request.getReqRefNo());
//		response.setRespRefNo(RestRefNoHelper.generateRefNo());
//		response.setRespCode(rc.code());
//		response.setRespDesc(rc.desc());
//		return response;
//	}

	@RequestMapping(value = "/position", method = RequestMethod.POST)
	public @ResponseBody PositionResponse position(@RequestBody BaseRequest request) {
		PositionResponse response = new PositionResponse();
		response.setPosition(userService.findPosition());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setRespCode(ResponseCode.APPROVED.code());
		response.setRespDesc(ResponseCode.APPROVED.desc());
		return response;
	}

	@RequestMapping(value = "/register/info", method = RequestMethod.POST)
	public @ResponseBody BaseResponse register(@RequestBody RegisterRequest request)
			throws ResponseException, IOException, InterruptedException {
		BaseResponse response = new BaseResponse();
		IntCbbtaTxEmployee emp = new IntCbbtaTxEmployee();
		LocalTime.now();
		Math.random();
		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yy");
		String formattedDate = year.format(myFormatObj);
		String customerNo = String.format("%s%s%s", formattedDate, "2", RandomStringUtils.random(3, false, true));
		IntCbbtaTxCustomerInfo o = new IntCbbtaTxCustomerInfo();
		o.setCustomerNo(customerNo);
		o.setNameEn(request.getFirstname());
		o.setLastnameEn(request.getLastname());
		o.setAccessStatus(LookupConstant.WHITELIST);
		o.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
		o.setMobileNo(request.getMobile());
		o.setEmail(request.getEmail());
		o.setLoginpwd(request.getPassword());
		o.setPosition(request.getRole());
		o.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
		ResponseCode rc;
		try {
			if (!(request.getImg64() == null)) {
				logger.debug("Image64:" + request.getImg64().length());
				FaceExtractionPayload payload = new FaceExtractionPayload();
				payload.setImage(request.getImg64());
				payload.setUser_id(customerNo);
				String pathPrimary = deviceService.findPath();
				socketService.faceExtraction(pathPrimary, payload);
			}
			rc = userService.register(o);
		} catch (ResponseException e) {
			rc = e.getResponseCode();
		} catch (DataIntegrityViolationException e) {
			logger.error(e.getMostSpecificCause().getMessage(), e);
			rc = ResponseCode.BAD_REQUEST;
		} catch (Exception e) {
			logger.error(request.getMobile(), e);
			rc = ResponseCode.INTERNAL_ERROR;
		}

		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		return response;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody LoginResponse loginByMobileNo(@RequestBody LoginRequest req) {
		IntCbbtaTxCustomerInfo o = new IntCbbtaTxCustomerInfo();
		o.setMobileNo(req.getMobileNo());
		o.setLoginpwd(req.getPassword());

		LoginResponse res = new LoginResponse();
		res.setReqRefNo(req.getReqRefNo());
		res.setRespRefNo(RestRefNoHelper.generateRefNo());
		ResponseCode rc;
		try {
			IntCbbtaTxCustomerInfo ci = userService.loginByMobile(o);
			rc = ResponseCode.APPROVED;
			Map<String, Object> claims = new HashMap<>();
			claims.put("sub", ci.getCustomerNo());
			claims.put("mob", ci.getMobileNo());
			claims.put("created", new Date());
			res.setToken(Jwts.builder().setClaims(claims).signWith(SignatureAlgorithm.HS512, tokenSecret).compact());
			res.setCustomerNo(ci.getCustomerNo());
			res.setMobileNo('0' + ci.getMobileNo().substring(2, ci.getMobileNo().length()));
			res.setLevel(userService.findLevel(ci.getPosition()));
		} catch (ResponseException e) {
			rc = e.getResponseCode();
		} catch (DataIntegrityViolationException e) {
			logger.error(e.getMostSpecificCause().getMessage(), e);
			rc = ResponseCode.BAD_REQUEST;
		} catch (Exception e) {
			logger.error(req.getMobileNo(), e);
			rc = ResponseCode.INTERNAL_ERROR;
		}
		res.setRespCode(rc.code());
		res.setRespDesc(rc.desc());
		return res;
	}

	@RequestMapping(value = "/user_info", method = RequestMethod.POST)
	public @ResponseBody UserInfoResponse userInfo(@RequestBody UserInfoRequest request) throws IOException {
		UserInfoResponse response = new UserInfoResponse();
		ResponseCode rc = null;
		try {
			IntCbbtaTxCustomerInfo info = userService.info(request.getMobileNo());
			response.setRecId(info.getRecId());
			response.setEmployeeNo(info.getCustomerNo());
			response.setFname(info.getNameEn());
			response.setLname(info.getLastnameEn());
			if (info.getFaceRegisStatus().equals(ResponseCode.FACE_ALREADY_REGISTER.code())
					|| info.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_REQUEST.code())
					|| info.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_DECLINED.code())) {
				response.setImage(userService.getImg64(info.getCustomerNo().toString()));
			} else {
				response.setImage(null);
			}
			response.setMobileNo(info.getMobileNo());
			response.setRole(info.getPosition());
			response.setEmail(info.getEmail());
			response.setFaceRegisStatus(info.getFaceRegisStatus());
			response.setFaceStatus(info.getAccessStatus());
			rc = ResponseCode.APPROVED;
			
		} catch (DataIntegrityViolationException e) {
			logger.error(e.getMostSpecificCause().getMessage(), e);
			rc = ResponseCode.BAD_REQUEST;
			
		} catch (Exception e) {
			logger.error(request.getMobileNo(), e);
			rc = ResponseCode.INTERNAL_ERROR;
			
		}
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}
	
	@RequestMapping(value = "/user_delete", method = RequestMethod.POST)
	public@ResponseBody  BaseResponse deleteState(@RequestBody UserInfoRequest request) {
		BaseResponse response = new BaseResponse();
		ResponseCode rc = ResponseCode.DECLINED;
		logger.info(request.getId());
		try {
			boolean check = userService.deleteState(request.getId());
			logger.info("delete Controller:"+String.valueOf(check));
			if(check) {
				FaceDistributePayload payload = new  FaceDistributePayload();
				payload.setUser_id(Long.valueOf(request.getId()));
				socketService.deleteface(payload);
				rc=ResponseCode.APPROVED;
			}else {
				rc = ResponseCode.DECLINED;
			}
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}
	
	@RequestMapping(value = "/staff_info", method = RequestMethod.POST)
	public @ResponseBody UserInfoResponse staffInfo(@RequestBody UserInfoRequest request) throws IOException {
		UserInfoResponse response = new UserInfoResponse();
		
		try {
			IntCbbtaTxCustomerInfo info = userService.infoByCode(request.getId());
			response.setRecId(info.getRecId());
			response.setEmployeeNo(info.getCustomerNo());
			response.setFname(info.getNameEn());
			response.setLname(info.getLastnameEn());
			if (info.getFaceRegisStatus().equals(ResponseCode.FACE_ALREADY_REGISTER.code())
					|| info.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_REQUEST.code())
					|| info.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_DECLINED.code())|| info.getFaceRegisStatus().equals(ResponseCode.FACE_REGISTER_REQUEST.code())) {
				response.setImage(userService.getImg64(info.getCustomerNo().toString()));
			} else {
				response.setImage(null);
			}
			String mobileNo = (Pattern.matches(LookupConstant.MOBILE_NO_PATTERN,info.getMobileNo()))?"0"+info.getMobileNo().substring(2, info.getMobileNo().length()):info.getMobileNo();
			logger.info("280:"+mobileNo);
			response.setMobileNo(mobileNo);
			response.setRole(info.getPosition());
			response.setEmail(info.getEmail());
			response.setFaceRegisStatus(info.getFaceRegisStatus());
			response.setFaceStatus(info.getAccessStatus());
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
		} catch (DataIntegrityViolationException e) {
			logger.error(e.getMostSpecificCause().getMessage(), e);
			response.setRespCode(ResponseCode.BAD_REQUEST.code());
			response.setRespDesc(ResponseCode.BAD_REQUEST.desc());
		} catch (Exception e) {
			logger.error(request.getId(), e);
			response.setRespCode(ResponseCode.INTERNAL_ERROR.code());
			response.setRespDesc(ResponseCode.INTERNAL_ERROR.desc());
		}
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}
	
	@RequestMapping(value = "/request_staff_info", method = RequestMethod.POST)
	public @ResponseBody UserInfoResponse staffInfoRequest(@RequestBody UserInfoRequest request) throws IOException {
		UserInfoResponse response = new UserInfoResponse();
		
		try {
			IntCbbtaTxCustomerInfo info = userService.infoByCode(request.getId());
			response.setRecId(info.getRecId());
			response.setEmployeeNo(info.getCustomerNo());
			response.setFname(info.getNameEn());
			response.setLname(info.getLastnameEn());
			if (info.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_REQUEST.code())
					|| info.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_DECLINED.code())|| info.getFaceRegisStatus().equals(ResponseCode.FACE_REGISTER_REQUEST.code())) {
				response.setImage(userService.getImg64Upadte(info.getCustomerNo().toString()));
			} else {
				response.setImage(null);
			}
			String mobileNo = (Pattern.matches(LookupConstant.MOBILE_NO_PATTERN,info.getMobileNo()))?"0"+info.getMobileNo().substring(2, info.getMobileNo().length()):info.getMobileNo();
			logger.info("280:"+mobileNo);
			response.setMobileNo(mobileNo);
			response.setRole(info.getPosition());
			response.setEmail(info.getEmail());
			response.setFaceRegisStatus(info.getFaceRegisStatus());
			response.setFaceStatus(info.getAccessStatus());
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
		} catch (DataIntegrityViolationException e) {
			logger.error(e.getMostSpecificCause().getMessage(), e);
			response.setRespCode(ResponseCode.BAD_REQUEST.code());
			response.setRespDesc(ResponseCode.BAD_REQUEST.desc());
		} catch (Exception e) {
			logger.error(request.getId(), e);
			response.setRespCode(ResponseCode.INTERNAL_ERROR.code());
			response.setRespDesc(ResponseCode.INTERNAL_ERROR.desc());
		}
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}

	@RequestMapping(value = "/update_info", method = RequestMethod.POST)
	public @ResponseBody UserInfoResponse updateInfo(@RequestBody UserInfoUpdateRequest request) {
		UserInfoResponse response = new UserInfoResponse();
		IntCbbtaTxCustomerInfo info = userService.infoByCode(request.getEmployeeNo());
		List<IntCbbtaTxCustomerInfo> allUser = userService.getFace();
		// check Duplicate
		for (IntCbbtaTxCustomerInfo e : allUser) {
			if (e.getMobileNo().equals(request.getMobileNo()) && !e.getRecId().equals(request.getRecId())) {
				response.setRespCode(ResponseCode.ALREADY_EXISTS_MOBILE_NO.code());
				response.setRespDesc(ResponseCode.ALREADY_EXISTS_MOBILE_NO.desc());
				response.setReqRefNo(request.getReqRefNo());
				response.setRespRefNo(RestRefNoHelper.generateRefNo());
				return response;
			}
		}

		info.setNameEn(request.getFname());
		info.setLastnameEn(request.getLname());
		info.setMobileNo(request.getMobileNo());
		info.setPosition(request.getRole());
		info.setEmail(request.getEmail());
		info.setFaceRegisStatus(request.getFaceRegisStatus());
		info.setAccessStatus(request.getFaceStatus());
		info.setRecId(request.getRecId());

		try {
			IntCbbtaTxCustomerInfo infoUpdate = userService.updateInfo(info);
			response.setRecId(infoUpdate.getRecId());
			response.setEmployeeNo(infoUpdate.getCustomerNo());
			response.setFname(infoUpdate.getNameEn());
			response.setLname(infoUpdate.getLastnameEn());
			if (infoUpdate.getFaceRegisStatus().equals(ResponseCode.FACE_ALREADY_REGISTER.code())) {
				response.setImage(userService.getImg64(info.getCustomerNo().toString()));
				FaceDistributePayload updateInfoPayload = new FaceDistributePayload();
				updateInfoPayload.setImage(userService.getImg64(info.getCustomerNo().toString()));
				updateInfoPayload.setStatus(infoUpdate.getAccessStatus());
				updateInfoPayload.setUser_id(Long.valueOf(infoUpdate.getCustomerNo()));
				updateInfoPayload.setUsername(infoUpdate.getNameEn()+" "+infoUpdate.getLastnameEn());
				socketService.faceDistribution(updateInfoPayload);
			} else {
				response.setImage(null);
			}
			response.setMobileNo(infoUpdate.getMobileNo());
			response.setRole(infoUpdate.getPosition());
			response.setEmail(infoUpdate.getEmail());
			response.setFaceRegisStatus(infoUpdate.getFaceRegisStatus());
			response.setFaceStatus(infoUpdate.getAccessStatus());
			
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
		} catch (ResponseException e) {
			logger.error(e.getMessage(), e);
			response.setRespCode(e.getResponseCode().code());
			response.setRespDesc(e.getResponseCode().desc());
		} catch (DataIntegrityViolationException e) {
			logger.error("updateInfo error:" + e.getMostSpecificCause().getMessage(), e);
			response.setRespCode(ResponseCode.BAD_REQUEST.code());
			response.setRespDesc(ResponseCode.BAD_REQUEST.desc());
		} catch (Exception e) {
			logger.error("updateInfo error:" + request.getMobileNo(), e);
			response.setRespCode(ResponseCode.INTERNAL_ERROR.code());
			response.setRespDesc(ResponseCode.INTERNAL_ERROR.desc());
		}
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}

	@RequestMapping(value = "/update_staff", method = RequestMethod.POST)
	public @ResponseBody BaseResponse updateInfoStaff(@RequestBody UserInfoUpdateRequest request) {
		BaseResponse response = new UserInfoResponse();
		IntCbbtaTxCustomerInfo info = userService.infoByCode(request.getEmployeeNo());
		String mobileNo = request.getMobileNo();
		logger.info("Pattern Mobile no:"+Pattern.matches(LookupConstant.MOBILE_NO_PATTERN,mobileNo));
		if(!Pattern.matches(LookupConstant.MOBILE_NO_PATTERN,mobileNo)) {
			mobileNo=LookupConstant.MOBILE_NO_PREFIX_TH+mobileNo.substring(1, mobileNo.length());
			logger.info("info mobileNo:"+mobileNo);
		}
		List<IntCbbtaTxCustomerInfo> allUser = userService.getFace();
		// check Dup mobileno
		for (IntCbbtaTxCustomerInfo e : allUser) {
			if (e.getMobileNo().equals(mobileNo) && !e.getRecId().equals(request.getRecId())) {
				response.setRespCode(ResponseCode.ALREADY_EXISTS_MOBILE_NO.code());
				response.setRespDesc(ResponseCode.ALREADY_EXISTS_MOBILE_NO.desc());
				response.setReqRefNo(request.getReqRefNo());
				response.setRespRefNo(RestRefNoHelper.generateRefNo());
				return response;
			}
		}
		logger.info(request.getFname());
		logger.info(request.getLname());
		logger.info(mobileNo);
		logger.info(request.getRole());
		logger.info(request.getEmail());
		logger.info(request.getFaceRegisStatus());
		logger.info(request.getFaceStatus());
		logger.info(String.valueOf(request.getRecId()));
		logger.info(String.valueOf(request.getImage().length()));
////////////////
		info.setNameEn(request.getFname());
		info.setLastnameEn(request.getLname());
		info.setMobileNo(mobileNo);
		info.setPosition(request.getRole());
		info.setEmail(request.getEmail());
		info.setFaceRegisStatus(request.getFaceRegisStatus());
		info.setRecId(request.getRecId());
		
		ResponseCode rc = null;
		
		try {
			 IntCbbtaTxCustomerInfo user = userService.updateInfo(info);
			rc = ResponseCode.APPROVED;
			if(user.getFaceRegisStatus().equals(ResponseCode.FACE_ALREADY_REGISTER.code())||user.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_REQUEST.code())||user.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_DECLINED.code())) {
				if(!userService.getImg64(info.getCustomerNo()).equals(request.getImage())) {
					FaceExtractionPayload facePayload = new FaceExtractionPayload();
					facePayload.setImage(request.getImage());
					facePayload.setUser_id(request.getEmployeeNo());
					String primary = deviceService.findPath();
					socketService.faceExtraction(primary, facePayload);
				}else {
					FaceDistributePayload updateInfoPayload = new FaceDistributePayload();
					updateInfoPayload.setImage(request.getImage());
					updateInfoPayload.setStatus(user.getAccessStatus());
					updateInfoPayload.setUser_id(Long.valueOf(request.getEmployeeNo()));
					updateInfoPayload.setUsername(request.getFname()+" "+request.getLname());
					socketService.faceDistribution(updateInfoPayload);
				}
				
			}else if(!user.getFaceRegisStatus().equals(ResponseCode.FACE_ALREADY_REGISTER.code())) {
				FaceExtractionPayload facePayload = new FaceExtractionPayload();
				facePayload.setImage(request.getImage());
				facePayload.setUser_id(request.getEmployeeNo());
				String primary = deviceService.findPath();
				socketService.faceExtraction(primary, facePayload);
				
			}
			
			
		} catch (ResponseException e) {
			logger.error(e.getMessage(), e);
			rc = e.getResponseCode();

		} catch (DataIntegrityViolationException e) {
			logger.error("updateInfo error:" + e.getMostSpecificCause().getMessage(), e);
			rc = ResponseCode.BAD_REQUEST;

		} catch (Exception e) {
			logger.error("updateInfo error:" + request.getMobileNo(), e);
			rc = ResponseCode.INTERNAL_ERROR;

		}
		
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public @ResponseBody BaseResponse logout(@RequestBody BaseRequest req) {
		BaseResponse response = new BaseResponse();
		response.setRespCode(ResponseCode.APPROVED.code());
		response.setRespDesc(ResponseCode.APPROVED.desc());
		response.setReqRefNo(req.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}

	@RequestMapping(value = "/visitor", method = RequestMethod.POST)
	public @ResponseBody BaseResponse visitor(@RequestBody LogVisiterRequest request)
			throws ResponseException, IOException {
		IntCbbtaTxAttendance log = new IntCbbtaTxAttendance();
		String no = request.getDateTime();
		logger.info("getId:" + request.getId());
		logger.info("getUsername:" + request.getUsername());
		logger.info("getImage:" + request.getImage());
		logger.info("getDateTime:" + request.getDateTime());
		logger.info("getScore:" + request.getScore());
		logger.info("getStatus:" + request.getStatus());
		logger.debug(request.getUsername());
		logger.error(request.getUsername());
		if (request.getUsername().equals("UNKNOWN")) {
			no = no.replaceAll("\\s", "");
			no = no.replaceAll("\\.", "");
			no = no.replaceAll(":", "");
			no = no.replaceAll("-", "");
			log.setUserNo(Long.valueOf(no));
			userService.saveUNKNOWN(request.getImage(), no);
			log.setUsername("UNKNOWN");
			log.setDateTime(request.getDateTime());
			log.setScore(request.getScore());
			log.setRole(request.getStatus());

		} else {
			no = no.replaceAll("\\s", "");
			no = no.replaceAll("\\.", "");
			no = no.replaceAll(":", "");
			no = no.replaceAll("-", "");
			no = request.getId() + no;
			userService.saveUNKNOWN(request.getImage(), no);
			log.setUserNo(Long.valueOf(request.getId()));
			log.setUsername(request.getUsername());
			log.setDateTime(request.getDateTime());
			log.setScore(request.getScore());
			log.setRole(request.getStatus());

		}

		userService.inserVisitor(log);
		BaseResponse response = new BaseResponse();
		logger.info("visiter -> " + request.getReqRefNo());
		response.setRespCode(ResponseCode.APPROVED.code());
		response.setRespDesc(ResponseCode.APPROVED.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/get_user", method = RequestMethod.POST)
	public @ResponseBody FaceUserResponse getFace(@RequestBody BaseRequest request) throws IOException {
		List<IntCbbtaTxCustomerInfo> empInfo = userService.getFace();
		List<UserModel> emp = new ArrayList<UserModel>();
		UserModel em;
		for (IntCbbtaTxCustomerInfo e : empInfo) {
			logger.error(e.getFaceRegisStatus());
			if (e.getFaceRegisStatus().equals(ResponseCode.FACE_ALREADY_REGISTER.code())
					|| e.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_REQUEST.code())
					|| e.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_DECLINED.code())) {
				em = new UserModel(e.getCustomerNo(), e.getNameEn(), e.getLastnameEn(),
						userService.getImg64(e.getCustomerNo()), e.getAccessStatus());
				emp.add(em);
			} else {
				em = new UserModel(e.getCustomerNo(), e.getNameEn(), e.getLastnameEn(), null, e.getAccessStatus());
				emp.add(em);
			}
		}
		FaceUserResponse response = new FaceUserResponse();
		response.setModel(emp);
		response.setRespCode(ResponseCode.APPROVED.code());
		response.setRespDesc(ResponseCode.APPROVED.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/face_extraction", method = RequestMethod.POST)
	public @ResponseBody BaseResponse faceExtraction(@RequestBody FaceRegisterRequest request)
			throws ResponseException, IOException {
		BaseResponse response = new BaseResponse();
		// set new face status
		userService.updateStatusFaces(request.getUserid(), ResponseCode.FACE_WAITING_REGISTER.code());
		FaceExtractionPayload payload = new FaceExtractionPayload();
		payload.setUser_id(request.getUserid());
		payload.setImage(request.getImage());
		payload.setCmd(request.getCmd());
		logger.info("/faceExtraction:" + payload.getUser_id());
		String pathPrimary = deviceService.findPath();
		socketService.faceExtraction(pathPrimary, payload);
		response.setRespCode(ResponseCode.FACE_WAITING_REGISTER.code());
		response.setRespDesc(ResponseCode.FACE_WAITING_REGISTER.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/status_extraction", method = RequestMethod.POST)
	public @ResponseBody BaseResponse faceExtractionUpdate(@RequestBody FaceUpdateStatusRequest request)
			throws ResponseException, IOException {
		BaseResponse response = new BaseResponse();
		userService.updateStatusFaces(request.getId(), request.getStatusExtraction());
		logger.info("/faceUpdate info: getStatusExtraction:" + request.getStatusExtraction() + " reqRefNo:"
				+ request.getReqRefNo());
		logger.debug("/faceUpdate debug: getStatusExtraction:" + request.getStatusExtraction() + " reqRefNo:"
				+ request.getReqRefNo());
		boolean checkStatus = userService.updateStatusFaces(request.getId(), request.getStatusExtraction());
		logger.info("checkStatus:" + checkStatus);
		if (checkStatus) {
			IntCbbtaTxCustomerInfo info = userService.infoByCode(request.getId());
			FaceDistributePayload payload = new FaceDistributePayload();
			payload.setImage(request.getImage());
			payload.setUser_id(Long.valueOf(request.getId()));
			payload.setStatus(info.getAccessStatus());
			payload.setUsername(info.getNameEn() + " " + info.getLastnameEn());
			logger.info("checkStatus in condition :" + payload.getUser_id());
			logger.info("checkStatus in condition :" + payload.getUsername());
			logger.info("checkStatus in condition :" + payload.getImage().length());
			logger.info("checkStatus in condition :" + payload.getStatus());
			logger.info("checkStatus in condition :" + request.getId());
			socketService.faceDistribution(payload);
			userService.saveImageEmp(request.getImage(), request.getId());
		}
		response.setRespCode(ResponseCode.APPROVED.code());
		response.setRespDesc(ResponseCode.APPROVED.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/attendance", method = RequestMethod.POST)
	public @ResponseBody AttendanceResponse attendance(@RequestBody BaseRequest request) throws IOException {
		AttendanceResponse response = new AttendanceResponse();
		logger.info(request.getReqRefNo());
		List<IntCbbtaTxAttendance> getLog = userService.getLogAll();
		List<AttendanceModel> am = new ArrayList<AttendanceModel>();
		for (IntCbbtaTxAttendance e : getLog) {
			am.add(new AttendanceModel(e.getRecId().toString(), e.getUserNo().toString(), e.getUsername(),
					e.getDateTime(), e.getScore(), e.getRole()));
		}
		response.setAttendance(am);
		response.setRespCode(ResponseCode.APPROVED.code());
		response.setRespDesc(ResponseCode.APPROVED.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}

	@RequestMapping(value = "/accessibility", method = RequestMethod.POST)
	public @ResponseBody BaseResponse accessibility(@RequestBody WhiteBlackRequest request) throws IOException {
		BaseResponse response = new BaseResponse();
		IntCbbtaTxCustomerInfo info = userService.infoByCode(request.getId());
		info.setAccessStatus(request.getStatus());
		ResponseCode rc = null;
		try {
			userService.updateInfo(info);
			FaceDistributePayload payload = new FaceDistributePayload();
			payload.setImage(userService.getImg64(request.getId()));
			payload.setUser_id(Long.valueOf(request.getId()));
			payload.setStatus(request.getStatus());
			payload.setUsername(info.getNameEn() + " " + info.getLastnameEn());
			logger.info("accessibility" + request.getStatus());
			socketService.faceDistribution(payload);
			rc = ResponseCode.APPROVED;
		} catch (ResponseException e) {
			rc = e.getResponseCode();
		} catch (IOException e) {
			rc = ResponseCode.INTERNAL_ERROR;
		} catch (Exception e) {
			rc = ResponseCode.INTERNAL_ERROR;
		}
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/face_update_request", method = RequestMethod.POST)
	public @ResponseBody BaseResponse updateFaceResponse(@RequestBody FaceRegisterRequest request) {
		BaseResponse response = new BaseResponse();
		ResponseCode rc = null;

		try {
			userService.updateStatusFaces(request.getUserid(), ResponseCode.FACE_UPDATE_REQUEST.code());
			userService.saveImageUpdate(request.getImage(), request.getUserid());
			rc = ResponseCode.FACE_WAITING_REGISTER;
		} catch (Exception e) {

			rc = ResponseCode.BAD_REQUEST;
		}
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/face_register_request", method = RequestMethod.POST)
	public @ResponseBody BaseResponse registerFaceRequest(@RequestBody FaceRegisterRequest request) {
		BaseResponse response = new BaseResponse();
		ResponseCode rc = null;
		try {
			userService.updateStatusFaces(request.getUserid(), ResponseCode.FACE_REGISTER_REQUEST.code());
			userService.saveImageUpdate(request.getImage(), request.getUserid());
			rc = ResponseCode.FACE_WAITING_REGISTER;
		} catch (Exception e) {

			rc = ResponseCode.BAD_REQUEST;
		}
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/faceupdate_list", method = RequestMethod.POST)
	public @ResponseBody FaceUserResponse updateFaceListResponse(@RequestBody BaseRequest request) throws IOException {
		List<IntCbbtaTxCustomerInfo> empInfo = userService.getFaceUpdate();
		List<UserModel> emp = new ArrayList<UserModel>();
		UserModel em;
		ResponseCode rc = null;
		try {
			for (IntCbbtaTxCustomerInfo e : empInfo) {
				logger.error(e.getFaceRegisStatus());
				if (e.getFaceRegisStatus().equals(ResponseCode.FACE_UPDATE_REQUEST.code())||e.getFaceRegisStatus().equals(ResponseCode.FACE_REGISTER_REQUEST.code())) {
					em = new UserModel(e.getCustomerNo(), e.getNameEn(), e.getLastnameEn(),
							userService.getImg64Update(e.getCustomerNo()), e.getAccessStatus());
					emp.add(em);
				} else {
					em = new UserModel(e.getCustomerNo(), e.getNameEn(), e.getLastnameEn(), null, e.getAccessStatus());
					emp.add(em);
				}

			}
			rc = ResponseCode.APPROVED;
		} catch (IOException e) {
			rc = ResponseCode.INTERNAL_ERROR;
		}
		FaceUserResponse response = new FaceUserResponse();
		response.setModel(emp);
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}

	@RequestMapping(value = "/visitor_image", method = RequestMethod.POST)
	public @ResponseBody InfoVisitorResponse infoVisitor(@RequestBody InfoVisitorRequest request) throws IOException {
		InfoVisitorResponse response = new InfoVisitorResponse();
		IntCbbtaTxAttendance info = userService.logInfo(request.getId());
		String no = "";
		logger.info("id:" + request.getId());
		logger.info("id:" + request.getUsername());
		ResponseCode rc = null;
		try {
			if (request.getUsername().equals("UNKNOWN")) {
				no = String.valueOf(info.getUserNo());
				logger.info("UNKNOWN:" + no);
				response.setImage(userService.getImg64Log(no));
				rc = ResponseCode.APPROVED;
			} else {
				no = info.getUserNo() + info.getDateTime();
				no = no.replaceAll("\\s", "");
				no = no.replaceAll("\\.", "");
				no = no.replaceAll(":", "");
				no = no.replaceAll("-", "");
				logger.info("USER:" + no);
				response.setImage(userService.getImg64Log(no));
				rc = ResponseCode.APPROVED;
			}
		} catch (IOException e) {
			rc = ResponseCode.INTERNAL_ERROR;
		} catch (DataIntegrityViolationException e) {
			rc = ResponseCode.BAD_REQUEST;
		}
		response.setRespCode(rc.code());
		response.setRespDesc(rc.desc());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		response.setReqRefNo(request.getReqRefNo());
		return response;
	}
}
