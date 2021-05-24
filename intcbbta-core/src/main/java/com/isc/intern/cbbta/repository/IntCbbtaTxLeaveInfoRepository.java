package com.isc.intern.cbbta.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;

import com.isc.intern.cbbta.entity.IntCbbtaTxCustomerInfo;
import com.isc.intern.cbbta.entity.IntCbbtaTxLeaveInfo;

public interface IntCbbtaTxLeaveInfoRepository extends JpaRepository<IntCbbtaTxLeaveInfo, Long>,
QueryDslPredicateExecutor<IntCbbtaTxLeaveInfo> {

}
