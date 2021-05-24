package com.isc.intern.cbbta.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.transaction.annotation.Transactional;

import com.isc.intern.cbbta.entity.IntCbbtaLkRole;

@Transactional(readOnly=true)
public interface IntCbbtaLkRoleRepository extends JpaRepository<IntCbbtaLkRole,Long>,QueryDslPredicateExecutor<IntCbbtaLkRole> {
	IntCbbtaLkRole findByName(String name);
	@Query("select name from IntCbbtaLkRole")
	List<String> findByColumnName();
}
