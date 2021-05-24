package com.isc.intern.cbbta.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;

import com.isc.intern.cbbta.entity.IntCbbtaTxLeaveDate;

public interface IntCbbtaTxLeaveDateRepository extends JpaRepository<IntCbbtaTxLeaveDate,Long>,QueryDslPredicateExecutor<IntCbbtaTxLeaveDate> {
	
}