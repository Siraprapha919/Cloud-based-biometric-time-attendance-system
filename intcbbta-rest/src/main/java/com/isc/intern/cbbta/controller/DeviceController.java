package com.isc.intern.cbbta.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.isc.intern.cbbta.bean.BaseRequest;
import com.isc.intern.cbbta.bean.BaseResponse;
import com.isc.intern.cbbta.bean.CategoryResponse;
import com.isc.intern.cbbta.bean.DeviceDeleteRequest;
import com.isc.intern.cbbta.bean.DeviceInfoResponse;
import com.isc.intern.cbbta.bean.DeviceRegisterRequest;
import com.isc.intern.cbbta.common.constant.BaseLookupConstant;
import com.isc.intern.cbbta.config.CategoryDevice;
import com.isc.intern.cbbta.constant.ResponseCode;
import com.isc.intern.cbbta.entity.IntCbbtaMsCategory;
import com.isc.intern.cbbta.entity.IntCbbtaTxDeviceInfo;
import com.isc.intern.cbbta.helper.RestRefNoHelper;
import com.isc.intern.cbbta.model.DeviceModel;
import com.isc.intern.cbbta.service.DeviceService;

@RestController
@RequestMapping("/device")
public class DeviceController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	@Autowired
	DeviceService deviceService;
		
	Date date = new Date();
	LocalDate year = LocalDate.now();
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public @ResponseBody BaseResponse regisDevice(@RequestBody DeviceRegisterRequest request) {
		logger.debug("Regis Request:"+request.getMsCategory());
		BaseResponse response = new BaseResponse();
		IntCbbtaTxDeviceInfo device = new IntCbbtaTxDeviceInfo();
//		device.setAddress(request.getAddress());
		device.setCode(request.getCode());
//		device.setLicense(request.getLicense());
		device.setMsCategory(request.getMsCategory());
//		device.setMsDistrictCode(request.getMsDistrictCode());
//		device.setMsSubdistrictCode(request.getMsSubdistrictCode());
//		device.setMsProvinceCode(request.getMsProvinceCode());
		device.setName(request.getName());
		device.setRecordCreatedDate(date);
		device.setRecordCreatedId(Long.valueOf(1111));
		device.setRecordCreatedName("ADMIN");
		device.setRecordCreatedTeamCode("ISC");
		device.setRecordCreatedTeamName("ISC");
		device.setRecordStatus(BaseLookupConstant.RECORD_STATUS_Y);
		List<IntCbbtaTxDeviceInfo> deviceAll = deviceService.getDeviceAll();
		for(IntCbbtaTxDeviceInfo e: deviceAll) {
			if(e.getCode().equals(request.getCode())&&!String.valueOf(e.getRecId()).equals(String.valueOf(request.getRec_id()))){
				response.setRespCode(ResponseCode.ALREADY_EXIST_CODE.code());
				response.setRespDesc(ResponseCode.ALREADY_EXIST_CODE.desc());
				response.setReqRefNo(request.getReqRefNo());
				response.setRespRefNo(RestRefNoHelper.generateRefNo());
				return response;
			}
			if(e.getName().equals(request.getName())&&!String.valueOf(e.getRecId()).equals(String.valueOf(request.getRec_id()))){
				response.setRespCode(ResponseCode.ALREADY_EXIST_NAME.code());
				response.setRespDesc(ResponseCode.ALREADY_EXIST_NAME.desc());
				response.setReqRefNo(request.getReqRefNo());
				response.setRespRefNo(RestRefNoHelper.generateRefNo());
				return response;
			}
		}
		boolean check = deviceService.deviceRegister(device);
		if(check) {
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());
			response.setReqRefNo(request.getReqRefNo());
			return response;
		}
		response.setRespCode(ResponseCode.ALREADY_EXISTS.code());
		response.setRespDesc(ResponseCode.ALREADY_EXISTS.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public @ResponseBody BaseResponse updateDevice(@RequestBody DeviceRegisterRequest request) {
		BaseResponse response = new BaseResponse();
		IntCbbtaTxDeviceInfo device = new IntCbbtaTxDeviceInfo();
//		device.setAddress(request.getAddress());
		device.setRecId(request.getRec_id());
		device.setCode(request.getCode());
//		device.setLicense(request.getLicense());
		device.setMsCategory(request.getMsCategory());
//		device.setMsDistrictCode(request.getMsDistrictCode());
//		device.setMsSubdistrictCode(request.getMsSubdistrictCode());
//		device.setMsProvinceCode(request.getMsProvinceCode());
		device.setName(request.getName());
		device.setRecordStatus(BaseLookupConstant.RECORD_STATUS_Y);
		device.setRecordUpdatedDate(date);
		device.setRecordUpdatedId(Long.valueOf(1111));
		device.setRecordUpdatedName("ADMIN");
		device.setRecordUpdatedTeamCode("ISC");
		device.setRecordUpdatedTeamName("ISC");
		List<IntCbbtaTxDeviceInfo> deviceAll = deviceService.getDeviceAll();
		for(IntCbbtaTxDeviceInfo e: deviceAll) {
			if(e.getCode().equals(request.getCode())&&!String.valueOf(e.getRecId()).equals(String.valueOf(request.getRec_id()))){
				response.setRespCode(ResponseCode.ALREADY_EXIST_CODE.code());
				response.setRespDesc(ResponseCode.ALREADY_EXIST_CODE.desc());
				response.setReqRefNo(request.getReqRefNo());
				response.setRespRefNo(RestRefNoHelper.generateRefNo());
				return response;
			}
			if(e.getName().equals(request.getName())&&!String.valueOf(e.getRecId()).equals(String.valueOf(request.getRec_id()))){
				response.setRespCode(ResponseCode.ALREADY_EXIST_NAME.code());
				response.setRespDesc(ResponseCode.ALREADY_EXIST_NAME.desc());
				response.setReqRefNo(request.getReqRefNo());
				response.setRespRefNo(RestRefNoHelper.generateRefNo());
				return response;
			}
		}
		boolean check = deviceService.updateDevice(device);
		logger.info("updateDevice:"+check);
		if(check) {
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());
			response.setReqRefNo(request.getReqRefNo());
			return response;
		}
		response.setRespCode(ResponseCode.ALREADY_EXISTS.code());
		response.setRespDesc(ResponseCode.ALREADY_EXISTS.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody BaseResponse deleteDevice(@RequestBody DeviceDeleteRequest request) {
		BaseResponse response = new BaseResponse();
		boolean check = deviceService.deviceDelete(request.getDeviceCode());
		if(check) {
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());
			response.setReqRefNo(request.getReqRefNo());
			return response;
		}
		response.setRespCode(ResponseCode.ALREADY_EXISTS.code());
		response.setRespDesc(ResponseCode.ALREADY_EXISTS.desc());
		response.setReqRefNo(request.getReqRefNo());
		response.setRespRefNo(RestRefNoHelper.generateRefNo());
		return response;
	}
	@RequestMapping(value = "/category", method = RequestMethod.POST)
	public @ResponseBody CategoryResponse category(@RequestBody BaseRequest request){
		System.out.println(request.getReqRefNo());
		CategoryResponse response = new CategoryResponse();
		List<IntCbbtaMsCategory> category = deviceService.category();
		List<CategoryDevice> categoryDevice = new ArrayList<CategoryDevice>();
		CategoryDevice cd;
		if(category!=null) {
			for (int i = 0; i < category.size(); i++) {
				 cd = new CategoryDevice(category.get(i).getCode(),category.get(i).getName(),category.get(i).getRecordStatus());
				 categoryDevice.add(cd);
			}
			response.setCategory(categoryDevice);
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());
			response.setReqRefNo(request.getReqRefNo());
		}
		else {
			response.setRespCode(ResponseCode.BAD_REQUEST.code());
			response.setRespDesc(ResponseCode.BAD_REQUEST.desc());
			response.setReqRefNo(request.getReqRefNo());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());	
		}
		return response;
	}
	
	@RequestMapping(value = "/category/all", method = RequestMethod.POST)
	public @ResponseBody CategoryResponse categoryAll(@RequestBody BaseRequest request){
		System.out.println(request.getReqRefNo());
		CategoryResponse response = new CategoryResponse();
		List<IntCbbtaMsCategory> category = deviceService.categoryAll();
		List<CategoryDevice> categoryDevice = new ArrayList<CategoryDevice>();
		CategoryDevice cd;
		if(category!=null) {
			for (int i = 0; i < category.size(); i++) {
				 cd = new CategoryDevice(category.get(i).getCode(),category.get(i).getName(),category.get(i).getRecordStatus());
				 categoryDevice.add(cd);
			}
			response.setCategory(categoryDevice);
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());
			response.setReqRefNo(request.getReqRefNo());
		}
		else {
			response.setRespCode(ResponseCode.BAD_REQUEST.code());
			response.setRespDesc(ResponseCode.BAD_REQUEST.desc());
			response.setReqRefNo(request.getReqRefNo());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());	
		}
		return response;
	}
	
	@RequestMapping(value = "/deviceAll", method = RequestMethod.POST)
	public @ResponseBody DeviceInfoResponse getAllDevice(@RequestBody BaseRequest request){
		System.out.println(request.getReqRefNo());
		DeviceInfoResponse response = new DeviceInfoResponse();
		List<IntCbbtaTxDeviceInfo> deviceInfo = deviceService.getDeviceAll();
		List<DeviceModel> deviceResponse = new ArrayList<DeviceModel>();
		DeviceModel drr;
		if(deviceInfo!=null) {
			for (int i = 0; i < deviceInfo.size(); i++) {
				drr =new DeviceModel(deviceInfo.get(i).getRecId(),deviceInfo.get(i).getMsCategory(),deviceInfo.get(i).getCode(),deviceInfo.get(i).getName());
				deviceResponse.add(drr);
			}
			response.setDeviceAll(deviceResponse);
			response.setRespCode(ResponseCode.APPROVED.code());
			response.setRespDesc(ResponseCode.APPROVED.desc());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());
			response.setReqRefNo(request.getReqRefNo());
		}
		else {
			response.setRespCode(ResponseCode.BAD_REQUEST.code());
			response.setRespDesc(ResponseCode.BAD_REQUEST.desc());
			response.setReqRefNo(request.getReqRefNo());
			response.setRespRefNo(RestRefNoHelper.generateRefNo());	
		}
		return response;
	}
	
	}
