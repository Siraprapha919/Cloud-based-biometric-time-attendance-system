package com.isc.intern.cbbta.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.transaction.annotation.Transactional;

import com.isc.intern.cbbta.entity.IntCbbtaTxBlacklistInfo;



@Transactional(readOnly=true)
public interface IntCbbtaTxBlacklistInfoRepository extends JpaRepository<IntCbbtaTxBlacklistInfo,Long>,QueryDslPredicateExecutor<IntCbbtaTxBlacklistInfo> {
	IntCbbtaTxBlacklistInfo findByBlackId(String blackId);
}
