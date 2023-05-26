package kr.ac.kopo.ctc.kopo10.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.*;

import kr.ac.kopo.ctc.kopo10.domain.StudentItem;


public interface StudentItemDao {
	
// CRUD
	
	void createTable();
	
	void dropTable();
	
	StudentItem create(); // CRUD 중 C (insert)
		
	StudentItem selectOne(int id); // CRUD 중 R
		
	List<StudentItem> selectAll(int page, int countPerPage); // CRUD 중 R
	
	int totalCount();
		
//	update // CRUD 중 U
		
//	delete // CRUD 중 D
}
