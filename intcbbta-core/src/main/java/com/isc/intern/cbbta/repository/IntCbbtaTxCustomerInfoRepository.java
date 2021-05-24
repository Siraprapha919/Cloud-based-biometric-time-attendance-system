package com.isc.intern.cbbta.repository;

import java.util.List;

import com.isc.intern.cbbta.common.constant.LookupConstant;
import com.isc.intern.cbbta.entity.IntCbbtaTxCustomerInfo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
public interface IntCbbtaTxCustomerInfoRepository extends JpaRepository<IntCbbtaTxCustomerInfo, Long>,
		QueryDslPredicateExecutor<IntCbbtaTxCustomerInfo> {
	
	@Query("select o from IntCbbtaTxCustomerInfo o where o.recId = ?1")
	IntCbbtaTxCustomerInfo findByRecId(Long recId);

	@Query("select o from IntCbbtaTxCustomerInfo o where o.customerNo = ?1 and o.recordStatus = 'Y'")
	IntCbbtaTxCustomerInfo findByCustomerNo(String customerNo);

	@Query("select o from IntCbbtaTxCustomerInfo o where o.cifNo = ?1 and o.recordCreatedBankCode = ?2")
	IntCbbtaTxCustomerInfo findByCifNo(String cifNo, String bankCode);

	@Query("select o from IntCbbtaTxCustomerInfo o where o.email = ?1 and o.recordStatus = 'Y'")
	IntCbbtaTxCustomerInfo findByEmail(String email);

	@Query("select o from IntCbbtaTxCustomerInfo o where o.mobileNo = ?1 and o.recordStatus = 'Y'")
	IntCbbtaTxCustomerInfo findByMobileNo(String mobileNo);
	
	@Query("select o from IntCbbtaTxCustomerInfo o where  o.recordStatus = 'Y'")
	List<IntCbbtaTxCustomerInfo> findAllActive();
	
	@Query("select o from IntCbbtaTxCustomerInfo o where  o.recordStatus = 'Y' and o.faceRegisStatus = '6008'or o.faceRegisStatus = '6013'")
	List<IntCbbtaTxCustomerInfo> findAllUpdate();

	@Query("select o from IntCbbtaTxCustomerInfo o where o.cifNo = ?1 and o.recordCreatedBankCode = ?2 and o.recordStatus = 'Y'")
	List<IntCbbtaTxCustomerInfo> findAllByCifNo(String cifNo, String bankCode);

	@Query("select o from IntCbbtaTxCustomerInfo o where o.cifNo in ?1 and o.recordCreatedBankCode = ?2 and o.recordStatus = 'Y'")
	List<IntCbbtaTxCustomerInfo> findAllByCifNoList(List<String> cifNoList, String bankCode);

	@Query("select o from IntCbbtaTxCustomerInfo o where o.customerNo in ?1 and o.recordCreatedBankCode = ?2 and o.recordStatus = 'Y'")
	List<IntCbbtaTxCustomerInfo> findAllByCustomerNoList(List<String> customerNoList, String bankCode);

}
