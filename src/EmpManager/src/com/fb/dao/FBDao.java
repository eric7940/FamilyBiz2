package com.fb.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.fb.util.RowBounds;

public interface FBDao {
	
	public Object queryForObject(String name, Object critObj) throws DataAccessException;

	public List queryForList(String name, Object critObj) throws DataAccessException;

	public List queryForList(String name, Object critObj, RowBounds rowBounds) throws DataAccessException;
	
	public Object insert(String name, Object paramObj) throws DataAccessException;

	public int update(String name, Object paramObj) throws DataAccessException;
	
	public int delete(String name, Object paramObj) throws DataAccessException;
	
	public Map call(String name, Map paramMap) throws DataAccessException;

}
