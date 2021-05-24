package com.isc.intern.cbbta.service;

import java.util.Date;
import java.util.List;

import org.jasypt.digest.PooledStringDigester;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.isc.intern.cbbta.common.constant.BaseLookupConstant;
import com.isc.intern.cbbta.common.constant.LookupConstant;

import com.isc.intern.cbbta.entity.IntCbbtaMsCategory;
import com.isc.intern.cbbta.entity.IntCbbtaTxDeviceInfo;
import com.isc.intern.cbbta.repository.IntCbbtaMsCategoryRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxDeviceInfoRepository;

import de.bytefish.fcmjava.requests.groups.AddDeviceGroupMessage;

@Service
public class DeviceService {
	private static final Logger logger = LoggerFactory.getLogger(DeviceService.class);
	@Autowired
	private IntCbbtaTxDeviceInfoRepository intCbbtaTxDeviceInfoRepository;
	
	@Autowired
	private IntCbbtaMsCategoryRepository intCbbtaMsCategoryRepository;
	
	@Autowired
	@Qualifier("strongDigester")
	private PooledStringDigester digester;

	@Value("${intcbbta.password.hash}")
	private Boolean isHashPassword;
	
	Date date = new Date();
	
	@Transactional
	public boolean deviceRegister(IntCbbtaTxDeviceInfo device) {
		IntCbbtaTxDeviceInfo deviceInfo = new IntCbbtaTxDeviceInfo();
		deviceInfo = intCbbtaTxDeviceInfoRepository.findByDeviceActive(device.getCode());
		if(deviceInfo == null) {
			if(device.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)) {
				IntCbbtaMsCategory category = intCbbtaMsCategoryRepository.findByName(LookupConstant.DEVICE_PRIMARY);
				category.setRecordStatus(LookupConstant.RECORD_STATUS_N);
				intCbbtaMsCategoryRepository.save(category);
				intCbbtaTxDeviceInfoRepository.save(device);
				return true;
			}
			intCbbtaTxDeviceInfoRepository.save(device);
			return true;
		}
		return false;
	}
	@Transactional
	public boolean updateDevice(IntCbbtaTxDeviceInfo deviceNew) {
		IntCbbtaTxDeviceInfo deviceOld = intCbbtaTxDeviceInfoRepository.findByRecId(deviceNew.getRecId());
		IntCbbtaMsCategory category = intCbbtaMsCategoryRepository.findByName(LookupConstant.DEVICE_PRIMARY);
		IntCbbtaTxDeviceInfo findPrimary = intCbbtaTxDeviceInfoRepository.findByDeviceExtraction(LookupConstant.DEVICE_PRIMARY);
		
		if(findPrimary == null) {
			if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)) {
				logger.info("1:");
				deviceOld.setCode(deviceNew.getCode());
				deviceOld.setName(deviceNew.getName());
				deviceOld.setMsCategory(deviceNew.getMsCategory());
				intCbbtaTxDeviceInfoRepository.save(deviceOld);
				category.setRecordStatus(LookupConstant.RECORD_STATUS_N);
				intCbbtaMsCategoryRepository.save(category);
				return true;
			}
			else if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_GENERAL)&&deviceOld.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)){
				logger.info("2:");
				deviceOld.setCode(deviceNew.getCode());
				deviceOld.setName(deviceNew.getName());
				deviceOld.setMsCategory(deviceNew.getMsCategory());
				intCbbtaTxDeviceInfoRepository.save(deviceOld);
				category.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
				intCbbtaMsCategoryRepository.save(category);
				return true;
			}else if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)&&deviceOld.getMsCategory().equals(LookupConstant.DEVICE_GENERAL)){
				logger.info("3:");
				deviceOld.setCode(deviceNew.getCode());
				deviceOld.setName(deviceNew.getName());
				deviceOld.setMsCategory(LookupConstant.DEVICE_PRIMARY);
				intCbbtaTxDeviceInfoRepository.save(deviceOld);
				category.setRecordStatus(LookupConstant.RECORD_STATUS_N);
				intCbbtaMsCategoryRepository.save(category);
				return true;
			}else if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_GENERAL)) {
				logger.info("4:");
					deviceOld.setCode(deviceNew.getCode());
					deviceOld.setName(deviceNew.getName());
					deviceOld.setMsCategory(deviceNew.getMsCategory());
					intCbbtaTxDeviceInfoRepository.save(deviceOld);
					category.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
					intCbbtaMsCategoryRepository.save(category);
					return true;
			}
			
		}else {
				findPrimary.setMsCategory(LookupConstant.DEVICE_GENERAL);
				intCbbtaTxDeviceInfoRepository.save(findPrimary);
				if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)) {
					logger.info("1:");
					deviceOld.setCode(deviceNew.getCode());
					deviceOld.setName(deviceNew.getName());
					deviceOld.setMsCategory(deviceNew.getMsCategory());
					intCbbtaTxDeviceInfoRepository.save(deviceOld);
					category.setRecordStatus(LookupConstant.RECORD_STATUS_N);
					intCbbtaMsCategoryRepository.save(category);
					
					return true;
				}
				else if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_GENERAL)&&deviceOld.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)){
					logger.info("2:");
					deviceOld.setCode(deviceNew.getCode());
					deviceOld.setName(deviceNew.getName());
					deviceOld.setMsCategory(deviceNew.getMsCategory());
					intCbbtaTxDeviceInfoRepository.save(deviceOld);
					category.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
					intCbbtaMsCategoryRepository.save(category);
					return true;
				}else if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)&&deviceOld.getMsCategory().equals(LookupConstant.DEVICE_GENERAL)){
					logger.info("3:");
					deviceOld.setCode(deviceNew.getCode());
					deviceOld.setName(deviceNew.getName());
					deviceOld.setMsCategory(LookupConstant.DEVICE_PRIMARY);
					intCbbtaTxDeviceInfoRepository.save(deviceOld);
					category.setRecordStatus(LookupConstant.RECORD_STATUS_N);
					intCbbtaMsCategoryRepository.save(category);
					return true;
				}else if(deviceNew.getMsCategory().equals(LookupConstant.DEVICE_GENERAL)) {
					logger.info("4:");
						deviceOld.setCode(deviceNew.getCode());
						deviceOld.setName(deviceNew.getName());
						deviceOld.setMsCategory(deviceNew.getMsCategory());
						intCbbtaTxDeviceInfoRepository.save(deviceOld);
						category.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
						intCbbtaMsCategoryRepository.save(category);
						return true;
				}
		
		}
//		logger.info("findPrimary:"+findPrimary.getCode());
		logger.info("deviceNew:"+deviceNew.getMsCategory());
		logger.info("deviceOld:"+deviceOld.getMsCategory());
//		logger.debug("findPrimary:"+findPrimary.getCode());
		logger.debug("deviceNew:"+deviceNew.getMsCategory());
		logger.debug("deviceOld:"+deviceOld.getMsCategory());
//		logger.error("findPrimary:"+findPrimary.getCode());
		logger.error("deviceNew:"+deviceNew.getMsCategory());
		logger.error("deviceOld:"+deviceOld.getMsCategory());
		
		return false;
	}
	@Transactional
	public boolean deviceDelete(String deviceCode) {	
		IntCbbtaTxDeviceInfo deviceInfo = intCbbtaTxDeviceInfoRepository.findByDeviceActive(deviceCode);
		if(deviceInfo.getMsCategory().equals(LookupConstant.DEVICE_PRIMARY)) {
			IntCbbtaMsCategory categoryChangeStatus = intCbbtaMsCategoryRepository.findByName(deviceInfo.getMsCategory());
			if(categoryChangeStatus.getRecordStatus().equals(LookupConstant.RECORD_STATUS_N)) {
				categoryChangeStatus.setRecordStatus(LookupConstant.RECORD_STATUS_Y);
				intCbbtaMsCategoryRepository.save(categoryChangeStatus);
			}else {
				deviceInfo.setMsCategory(LookupConstant.DEVICE_GENERAL);
				deviceInfo.setRecordStatus(LookupConstant.RECORD_STATUS_N);
			}
		}else {
			deviceInfo.setMsCategory(LookupConstant.DEVICE_GENERAL);
			deviceInfo.setRecordStatus(LookupConstant.RECORD_STATUS_N);
		}
		intCbbtaTxDeviceInfoRepository.save(deviceInfo);
		return true;
	}
	
	@Transactional
	public List<IntCbbtaMsCategory> category() {
		return  intCbbtaMsCategoryRepository.findByRecordStatus(LookupConstant.RECORD_STATUS_Y);
	}
	
	@Transactional
	public List<IntCbbtaMsCategory> categoryAll() {
		return  intCbbtaMsCategoryRepository.findAll();
	}
	
	@Transactional
	public List<IntCbbtaTxDeviceInfo> getDeviceAll() {
		return intCbbtaTxDeviceInfoRepository.findByRecordStatus(LookupConstant.RECORD_STATUS_Y);	
	}
	
	@Transactional
	public String findPath() {
		IntCbbtaTxDeviceInfo device = intCbbtaTxDeviceInfoRepository.findByMsCategory(LookupConstant.DEVICE_PRIMARY);
		String primary = "";
		if(device!=null) {
			return primary = device.getCode();
		}
		return primary;
	}
}
