package com.isc.intern.cbbta.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.mail.MessagingException;

import org.apache.commons.lang3.RandomStringUtils;
import org.jasypt.digest.PooledStringDigester;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.isc.intern.cbbta.common.constant.LookupConstant;
import com.isc.intern.cbbta.common.exception.ResponseException;
import com.isc.intern.cbbta.constant.ResponseCode;
import com.isc.intern.cbbta.entity.IntCbbtaLkRole;
import com.isc.intern.cbbta.entity.IntCbbtaMsTimeConfig;
import com.isc.intern.cbbta.entity.IntCbbtaTxAttendance;
import com.isc.intern.cbbta.entity.IntCbbtaTxCustomerInfo;
import com.isc.intern.cbbta.entity.IntCbbtaTxEmployee;
import com.isc.intern.cbbta.entity.IscSamStaff;
import com.isc.intern.cbbta.repository.IntCbbtaLkRoleRepository;
import com.isc.intern.cbbta.repository.IntCbbtaMsTimeConfigRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxAttendanceRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxBlacklistInfoRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxCustomerInfoRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxEmployeeRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxLeaveDateRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxLeaveInfoRepository;
import com.isc.intern.cbbta.repository.IntCbbtaTxWhitelistInfoRepository;
import com.isc.intern.cbbta.repository.IscSamStaffRepository;

@Service
public class UserService {
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
	@Autowired
	private IntCbbtaTxEmployeeRepository intCbbtaTxEmployeeRepository;

	@Autowired
	private IntCbbtaTxLeaveInfoRepository intCbbtaTxLeaveInfoRepository;

	@Autowired
	private IntCbbtaTxWhitelistInfoRepository intCbbtaTxWhitelistInfoRepository;

	@Autowired
	private IntCbbtaTxBlacklistInfoRepository intCbbtaTxBlacklistInfoRepository;

	@Autowired
	private IntCbbtaTxLeaveDateRepository intCbbtaTxLeaveDateRepository;

	@Autowired
	private IscSamStaffRepository iscSamStaffRepository;

	@Autowired
	private IntCbbtaTxAttendanceRepository intCbbtaTxAttendanceRepository;

	@Autowired
	private IntCbbtaTxCustomerInfoRepository intCbbtaTxCustomerInfoRepository;

	@Autowired
	private IntCbbtaLkRoleRepository intCbbtaLkRoleRepository;

	@Autowired
	private IntCbbtaMsTimeConfigRepository intCbbtaMsTimeConfigRepository;

	@Autowired
	@Qualifier("strongDigester")
	private PooledStringDigester digester;

	@Value("${intcbbta.password.hash}")
	private Boolean isHashPassword;
	
	@Transactional
	public boolean inserVisitor(IntCbbtaTxAttendance in) {
		return intCbbtaTxAttendanceRepository.save(in) != null;
	}

	

	@Transactional
	public boolean  config(IntCbbtaMsTimeConfig request) {
		IntCbbtaMsTimeConfig config = intCbbtaMsTimeConfigRepository.findByOrderByRecordUpdatedDateDesc();
		config.setScoreFaceCompare(request.getScoreFaceCompare());
		config.setTimeAttendanceStart(request.getTimeAttendanceStart());
		config.setTimeAttendanceBeforeLate(request.getTimeAttendanceBeforeLate());
		config.setTimeAttendanceEnd(request.getTimeAttendanceEnd());
		config.setSickDays(Long.valueOf(request.getSickDays()));
		config.setCasualDays(Long.valueOf(request.getCasualDays()));
		config.setVacationDays(Long.valueOf(request.getVacationDays()));
		
		config.setRecordCreatedId(request.getRecordCreatedId());
		config.setRecordCreatedName(request.getRecordCreatedName());
		config.setRecordCreatedDate(request.getRecordCreatedDate());
		config.setRecordCreatedTeamCode(request.getRecordCreatedTeamCode());
		
		config.setRecordStatus(request.getRecordStatus());
		config.setRecordUpdatedId(request.getRecordCreatedId());
		config.setRecordUpdatedName(request.getRecordCreatedName());
		config.setRecordUpdatedTeamCode(request.getRecordUpdatedTeamCode());
		config.setRecordUpdatedDate(request.getRecordUpdatedDate());
	try {intCbbtaMsTimeConfigRepository.save(config);
	return true;
	}catch(Exception e) {
		return false;
	}
		
	}
	
	@Transactional
	public IntCbbtaMsTimeConfig findConfig() {
		return intCbbtaMsTimeConfigRepository.findByOrderByRecordUpdatedDateDesc();
	}

	@Transactional
	public String findLevel(String role) {
		IntCbbtaLkRole level = intCbbtaLkRoleRepository.findByName(role);
		return level.getRecordStatus();
	}

	@Transactional
	public List<String> findPosition() {
		return intCbbtaLkRoleRepository.findByColumnName();
	}

	@Transactional
	public List<IntCbbtaTxAttendance> getLogAll() {
		return intCbbtaTxAttendanceRepository.findAll();
	}

	@Transactional
	public IntCbbtaTxEmployee userInfo(Long empNo) {
		return intCbbtaTxEmployeeRepository.findByEmployeeNo(empNo);
	}

	@Transactional
	public IntCbbtaTxCustomerInfo loginByMobile(IntCbbtaTxCustomerInfo in)
			throws MessagingException, ResponseException {
		String subString = LookupConstant.MOBILE_NO_PREFIX_TH
				+ in.getMobileNo().substring(1, in.getMobileNo().length());
		IntCbbtaTxCustomerInfo ci = intCbbtaTxCustomerInfoRepository.findByMobileNo(subString);
		logger.info("loginByMobile getMobileNo:" + in.getMobileNo());
		logger.info("loginByMobile subString:" + subString);

		if (ci == null) {
			logger.info("4");
			throw new ResponseException(ResponseCode.INVALID_AUTH);
		}
		if (!LookupConstant.RECORD_STATUS_Y.equals(ci.getRecordStatus())) {
			logger.info("3");
			throw new ResponseException(ResponseCode.INVALID_AUTH);
		}
		if (isHashPassword) {
			if (!digester.matches(in.getLoginpwd(), ci.getLoginpwd())) {
				logger.info("2");
				throw new ResponseException(ResponseCode.INVALID_AUTH);
			}
		} else {
			if (!in.getLoginpwd().equals(ci.getLoginpwd())) {
				logger.info("1");
				throw new ResponseException(ResponseCode.INVALID_AUTH);
			}
		}
		logger.info(digester.digest(ci.getLoginpwd()));
		logger.info(ci.getLoginpwd());
		return ci;
	}

	@Transactional
	public ResponseCode register(IntCbbtaTxCustomerInfo in) throws ResponseException {
		IntCbbtaTxCustomerInfo ci = intCbbtaTxCustomerInfoRepository.findByMobileNo(in.getMobileNo());
		logger.info(in.getLoginpwd());
		if (ci == null) {
			String encryp = digester.digest(in.getLoginpwd());
			in.setLoginpwd(encryp);
			intCbbtaTxCustomerInfoRepository.save(in);
			throw new ResponseException(ResponseCode.APPROVED);
		} else if (in.getMobileNo().equals(ci.getMobileNo())) {
			throw new ResponseException(ResponseCode.ALREADY_EXISTS_MOBILE_NO);
		} else if (in.getEmail().equals(ci.getEmail())) {
			throw new ResponseException(ResponseCode.INVALID_EMAIL);
		}
		return ResponseCode.APPROVED;
	}

	@Transactional
	public ResponseCode checkRole(String username, String password) throws ResponseException {
		String subString = LookupConstant.MOBILE_NO_PREFIX_TH + username.substring(1, username.length());
		IntCbbtaTxEmployee findEmp = intCbbtaTxEmployeeRepository.findByMobileNo(subString);
		IscSamStaff findStaff = iscSamStaffRepository.findByStaffLoginname(username);
		if (findStaff == null && findEmp == null) {
			throw new ResponseException(ResponseCode.NOT_FOUND);
		} else {
			if (findStaff != null) {
				return ResponseCode.ROLE_ADMIN;
			} else
				return ResponseCode.ROLE_STAFF;
		}

	}

	@Transactional
	public IntCbbtaTxCustomerInfo info(String mobileNo) {
		if (Pattern.matches(LookupConstant.MOBILE_NO_PATTERN, mobileNo)) {
			return intCbbtaTxCustomerInfoRepository.findByMobileNo(mobileNo);
		} else {
			mobileNo = LookupConstant.MOBILE_NO_PREFIX_TH + mobileNo.substring(1, mobileNo.length());
			logger.info("info mobileNo:" + mobileNo);
			return intCbbtaTxCustomerInfoRepository.findByMobileNo(mobileNo);
		}

	}
	@Transactional
	public boolean deleteHeapTempFiles(String id) {
	        try {
	            File tempDir = new File(System.getProperty("D:\\intcbbta-database\\Face\\Employee\\"+id)); // NOI18N
	            DirectoryStream<Path> files = Files.newDirectoryStream(tempDir.toPath());

	            try {
	                for (Path p : files) {
	                    String fname = p.toFile().getName();
	                    if (fname.startsWith(id) && (fname.endsWith(".jpg") || fname.endsWith(".png") || fname.endsWith(".gc"))) { // NOI18N
	                       Files.delete(p);
	                       if(!tempDir.exists()){
	                    	   return true;
	                       }else {
	                    	   return false;
	                       }
	                    }
	                }
	            } finally {
	                files.close();
	            }
	        } catch (IOException ex) {
	            System.err.println("deleteHeapTempFiles failed");   // NOI18N
	            ex.printStackTrace();
	        }
	    return false;
	}
	@Transactional
	public boolean deleteTest(File file,String id) {
        boolean success = false;
        IntCbbtaTxCustomerInfo info = intCbbtaTxCustomerInfoRepository.findByCustomerNo(id);
        if (file.isDirectory()) {
            for (File deleteMe: file.listFiles()) {
                // recursive delete
            	deleteTest(deleteMe,id);
            }
        }
        success = file.delete();
        if (success) {
        	logger.info(file.getAbsoluteFile() + " Deleted");
        	info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
			info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
			intCbbtaTxCustomerInfoRepository.save(info);
        	return true;
           
        } else {
        	logger.info(file.getAbsoluteFile() + " Deletion failed!!!");
            return false;
        }
	}
	@Transactional
	public boolean delete(String id){
		IntCbbtaTxCustomerInfo info = intCbbtaTxCustomerInfoRepository.findByCustomerNo(id);
		String path = "D:\\intcbbta-database\\Face\\Employee\\"+id+".jpg";
        File file = new File(path);
		 
       return  deleteTest(file,id);
        
//		 if (checkDelete) {
//				info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
//				info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
//				intCbbtaTxCustomerInfoRepository.save(info);
//				return true;
//			} else {
//				return false;
//			}
		
//		IntCbbtaTxCustomerInfo info = intCbbtaTxCustomerInfoRepository.findByCustomerNo(id);
//		
//		   BufferedReader br = null;
//	        FileInputStream fis = null;
//	        File tempDir = new File(System.getProperty("D:\\intcbbta-database\\Face\\Employee\\")); 
//	        String path = "D:\\intcbbta-database\\Face\\Employee\\" + id + ".jpg";
//	        File f = new File(path);
//			
//		logger.info(String.valueOf(f.exists()));
//		
//        boolean checkDelete = f.delete();
//        logger.info(String.valueOf(checkDelete));
//        if (checkDelete) {
//			info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
//			info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
//			intCbbtaTxCustomerInfoRepository.save(info);
//			
//			try {
//				
//				br.close();
//				fis.close();
//				org.apache.tomcat.jni.File.close(0);
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			return true;
//		} else {
//			return false;
//		}
////		BufferedReader br = new BufferedReader (new FileReader (new File ("D:\\intcbbta-database\\Face\\Employee\\" + id + ".jpg"))); 
//		String path ="D:\\intcbbta-database\\Face\\Employee\\" + id + ".jpg";
//		File imageUser = new File(path);
//		 Path pathOfFile
//         = Paths.get("D:\\intcbbta-database\\Face\\Employee\\" + id + ".jpg");
//		 
//		 
//			try {
//				boolean checkDelete = imageUser.delete();
//				boolean checkDelete1 = java.nio.file.Files.deleteIfExists(Paths.get(path));
//				logger.info("delete image  checkDelete1 :"+String.valueOf(checkDelete1));
//				logger.info("Is file delete ? :"+String.valueOf(imageUser.delete()));
//				logger.info("Is file delete function? :"+String.valueOf(imageUser.delete()));
////				assertTrue(java.nio.file.Files.deleteIfExists(Paths.get(path)));
//				
//				
//				if (checkDelete) {
//					info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
//					info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
//					intCbbtaTxCustomerInfoRepository.save(info);
//					br.close();
//					return true;
//				} else {
//					return false;
//				}
//			}catch(IOException e) {
//				logger.info(e.toString());
//				e.printStackTrace();
//				logger.debug(e.getMessage());
//				logger.error(e.getMessage());
//				logger.info(e.getMessage());
//			}catch(Exception e) {
//				logger.info(e.toString());
//				e.printStackTrace();
//				logger.debug(e.getMessage());
//				logger.error(e.getMessage());
//				logger.info(e.getMessage());
//			}
//			
	

	}
	
	@Transactional
	public boolean deleteState(String id){
		IntCbbtaTxCustomerInfo info = intCbbtaTxCustomerInfoRepository.findByCustomerNo(id);
		String path = "D:\\intcbbta-database\\Face\\Employee\\"+id+".jpg";
        File file = new File("D:\\intcbbta-database\\Face\\Employee");
        info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
		info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
		intCbbtaTxCustomerInfoRepository.save(info);
		try {
			info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
			info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
			intCbbtaTxCustomerInfoRepository.save(info);
			return true;
		
		}catch(Exception e) {
			
			logger.info(e.toString());
			e.printStackTrace();
			logger.debug(e.getMessage());
			logger.error(e.getMessage());
			logger.info(e.getMessage());
			return false;
		}
//      try {
//    	   DirectoryStream<Path> files = Files.newDirectoryStream(file.toPath());
//			boolean checkDelete = java.nio.file.Files.deleteIfExists(Paths.get(path));
//			logger.info("Is file delete ? :"+String.valueOf(checkDelete));
//			
//			if (checkDelete) {
//				info.setRecordStatus(LookupConstant.RECORD_STATUS_N);
//				info.setFaceRegisStatus(ResponseCode.FACE_NOT_REGISTER.code());
//				intCbbtaTxCustomerInfoRepository.save(info);
//				files.close();
//				return true;
//			} else {
//				files.close();
//				return false;
//			}
//			
//		}catch(IOException e) {
//			logger.info(e.toString());
//			e.printStackTrace();
//			logger.debug(e.getMessage());
//			logger.error(e.getMessage());
//			logger.info(e.getMessage());
//		}catch(Exception e) {
//			logger.info(e.toString());
//			e.printStackTrace();
//			logger.debug(e.getMessage());
//			logger.error(e.getMessage());
//			logger.info(e.getMessage());
//		}

	}

	@Transactional
	public IntCbbtaTxCustomerInfo infoByCode(String code) {
		return intCbbtaTxCustomerInfoRepository.findByCustomerNo(code);
	}

	@Transactional
	public IntCbbtaTxCustomerInfo updateInfo(IntCbbtaTxCustomerInfo o) throws ResponseException {
		if (!Pattern.matches(LookupConstant.MOBILE_NO_PATTERN, o.getMobileNo())) {
			o.setMobileNo(o.getMobileNo().substring(0, o.getMobileNo().length()));
		}

		IntCbbtaTxCustomerInfo info = intCbbtaTxCustomerInfoRepository.findByCustomerNo(o.getCustomerNo());// find
																											// mobile
																											// from new
																											// mobile
																											// for check
																											// duplicate
		logger.info("update info:" + o.getNameEn());
		logger.info("update info:" + o.getLastnameEn());
		logger.info("update info:" + o.getEmail());
		logger.info("update info:" + o.getPosition());
		logger.info("update info:" + o.getMobileNo());
		if (!info.getRecId().equals(o.getRecId()) && o.getMobileNo().equals(info.getMobileNo())) {
			throw new ResponseException(ResponseCode.ALREADY_EXISTS_MOBILE_NO);
		} else {
			intCbbtaTxCustomerInfoRepository.save(o);
		}
		return intCbbtaTxCustomerInfoRepository.findByRecId(Long.valueOf(o.getRecId()));
	}

	@Transactional
	public List<IntCbbtaTxCustomerInfo> getFace() {
		List<IntCbbtaTxCustomerInfo> list = intCbbtaTxCustomerInfoRepository.findAllActive();
		return list;
	}

	@Transactional
	public List<IntCbbtaTxCustomerInfo> getFaceUpdate() {
		List<IntCbbtaTxCustomerInfo> list = intCbbtaTxCustomerInfoRepository.findAllUpdate();
		return list;
	}

	@Transactional
	public boolean updateStatusFaces(String id, String status) {
		IntCbbtaTxCustomerInfo emp = intCbbtaTxCustomerInfoRepository.findByCustomerNo(id);
		if (status.equals(ResponseCode.FACE_REGISTER_APPROVED.code())) {
			emp.setFaceRegisStatus(ResponseCode.FACE_ALREADY_REGISTER.code());
			intCbbtaTxCustomerInfoRepository.save(emp);
			return true;
		} else if (status.equals(ResponseCode.FACE_REGISTER_DECLINED.code())) {
			emp.setFaceRegisStatus(ResponseCode.FACE_REGISTER_DECLINED.code());
			intCbbtaTxCustomerInfoRepository.save(emp);
			return false;
		} else if (status.equals(ResponseCode.FACE_UPDATE_REQUEST.code())) {
			emp.setFaceRegisStatus(ResponseCode.FACE_UPDATE_REQUEST.code());
			intCbbtaTxCustomerInfoRepository.save(emp);
			return false;
		} else if (status.equals(ResponseCode.FACE_UPDATE_DECLINED.code())) {
			emp.setFaceRegisStatus(ResponseCode.FACE_UPDATE_DECLINED.code());
			intCbbtaTxCustomerInfoRepository.save(emp);
			return false;
		}else if (status.equals(ResponseCode.FACE_REGISTER_REQUEST.code())) {
			emp.setFaceRegisStatus(ResponseCode.FACE_REGISTER_REQUEST.code());
			intCbbtaTxCustomerInfoRepository.save(emp);
			return false;
	}
		return false;
	}

	@Transactional
	public IntCbbtaTxAttendance logInfo(String rec_id) {
		return intCbbtaTxAttendanceRepository.findOne(Long.valueOf(rec_id));
	}

	@Transactional
	public boolean saveUNKNOWN(String img64, String no) throws ResponseException, IOException {
		no = no.replaceAll("\\s", "");
		no = no.replaceAll("\\.", "");
		no = no.replaceAll(":", "");
		logger.info("no im service:" + no);
		byte[] decodeByte = Base64.getDecoder().decode(img64);
		ByteArrayInputStream byteimg64 = new ByteArrayInputStream(decodeByte);
		BufferedImage img = null;
		File imgFile = null;
		img = ImageIO.read(byteimg64);
		byteimg64.close();
		String imgPath = "D:\\intcbbta-database\\Face\\logger\\" + no + ".jpg";
		imgFile = new File(imgPath);
		boolean check = ImageIO.write(img, "png", imgFile);
		logger.info("check  write image:" + String.valueOf(check));
		if (check)
			return true;
		return false;
	}

	@Transactional
	public boolean saveImageEmp(String img64, String codeEmpString) throws ResponseException, IOException {
		byte[] decodeByte = Base64.getDecoder().decode(img64);
		ByteArrayInputStream byteimg64 = new ByteArrayInputStream(decodeByte);
		BufferedImage img = null;
		File imgFile = null;
		img = ImageIO.read(byteimg64);
		byteimg64.close();
		String imgPath = "D:\\intcbbta-database\\Face\\Employee\\" + codeEmpString + ".jpg";
		imgFile = new File(imgPath);
		boolean check = ImageIO.write(img, "png", imgFile);
		if (check)
			return true;
		return false;
	}

	@Transactional
	public boolean saveImageUpdate(String img64, String codeEmpString) throws ResponseException, IOException {
		byte[] decodeByte = Base64.getDecoder().decode(img64);
		ByteArrayInputStream byteimg64 = new ByteArrayInputStream(decodeByte);
		BufferedImage img = null;
		File imgFile = null;
		img = ImageIO.read(byteimg64);
		byteimg64.close();
		String imgPath = "D:\\intcbbta-database\\Face\\update\\" + codeEmpString + ".jpg";
		imgFile = new File(imgPath);
		boolean check = ImageIO.write(img, "png", imgFile);
		if (check)
			return true;
		return false;
	}

	public String getImg64(String codeEmpString) throws IOException {
		String imgPath = "D:\\intcbbta-database\\Face\\Employee\\" + codeEmpString + ".jpg";
		File file = new File(imgPath);
		FileInputStream fileInputStream = new FileInputStream(file);
		byte[] imageByte = new byte[(int) file.length()];
		fileInputStream.read(imageByte);
		return Base64.getEncoder().encodeToString(imageByte);
	}
	
	public String getImg64Upadte(String codeEmpString) throws IOException {
		String imgPath = "D:\\intcbbta-database\\Face\\Update\\" + codeEmpString + ".jpg";
		File file = new File(imgPath);
		FileInputStream fileInputStream = new FileInputStream(file);
		byte[] imageByte = new byte[(int) file.length()];
		fileInputStream.read(imageByte);
		return Base64.getEncoder().encodeToString(imageByte);
	}

	public String getImg64Update(String codeEmpString) throws IOException {
		String imgPath = "D:\\intcbbta-database\\Face\\Update\\" + codeEmpString +".jpg";
		File file = new File(imgPath);
		FileInputStream fileInputStream = new FileInputStream(file);
		byte[] imageByte = new byte[(int) file.length()];
		fileInputStream.read(imageByte);
		return Base64.getEncoder().encodeToString(imageByte);
	}

	public String getImg64Log(String codeEmpString) throws IOException {
		String imgPath = "D:\\intcbbta-database\\Face\\logger\\" + codeEmpString +".jpg";
		File file = new File(imgPath);
		FileInputStream fileInputStream = new FileInputStream(file);
		byte[] imageByte = new byte[(int) file.length()];
		fileInputStream.read(imageByte);
		return Base64.getEncoder().encodeToString(imageByte);
	}

	@Transactional
	public String code() {
		LocalTime.now();
		Date date = new Date();
		Math.random();
		LocalDate year = LocalDate.now();
		DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yy");
		String formattedDate = year.format(myFormatObj);
		String codeEmpString = String.format("%s%s%s", formattedDate, "7076", RandomStringUtils.random(3, false, true));
		return codeEmpString;
	}

}
