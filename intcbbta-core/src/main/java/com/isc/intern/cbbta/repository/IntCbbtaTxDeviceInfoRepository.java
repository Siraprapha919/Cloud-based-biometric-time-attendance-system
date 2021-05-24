package com.isc.intern.cbbta.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.transaction.annotation.Transactional;

import com.isc.intern.cbbta.entity.IntCbbtaTxDeviceInfo;


@Transactional(readOnly=true)
public interface IntCbbtaTxDeviceInfoRepository extends JpaRepository<IntCbbtaTxDeviceInfo,Long>,QueryDslPredicateExecutor<IntCbbtaTxDeviceInfo>{

	IntCbbtaTxDeviceInfo findByCode(String code);
	IntCbbtaTxDeviceInfo findByRecId(Long code);
	IntCbbtaTxDeviceInfo findByLicense(String license);
//	@Query("select o from IntCbbtaTxDeviceInfo o where o.msCategory in ?1 and o.recordCreatedBankCode = ?2 and o.recordStatus = 'Y'")
	IntCbbtaTxDeviceInfo findByMsCategory(String primary);
	List<IntCbbtaTxDeviceInfo> findByRecordStatus(String status);
	@Query("select o from IntCbbtaTxDeviceInfo o where o.msCategory = ?1 and o.recordStatus = 'Y'")
	IntCbbtaTxDeviceInfo findByDeviceExtraction(String msCategory);
	@Query("select o from IntCbbtaTxDeviceInfo o where o.code = ?1 and o.recordStatus = 'Y'")
	IntCbbtaTxDeviceInfo findByDeviceActive(String code);
	
}

