package com.isc.intern.cbbta.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.transaction.annotation.Transactional;

import com.isc.intern.cbbta.entity.IntCbbtaTxAttendance;
@Transactional(readOnly=true)
public interface IntCbbtaTxAttendanceRepository extends JpaRepository<IntCbbtaTxAttendance,Long>,QueryDslPredicateExecutor<IntCbbtaTxAttendance>{
}
