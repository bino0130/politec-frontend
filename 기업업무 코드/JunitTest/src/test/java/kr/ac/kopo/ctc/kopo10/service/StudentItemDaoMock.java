package kr.ac.kopo.ctc.kopo10.service;

import java.sql.SQLException;
import java.util.List;

import kr.ac.kopo.ctc.kopo10.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo10.domain.StudentItem;

public class StudentItemDaoMock implements StudentItemDao {
	@Override
	public StudentItem create() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StudentItem selectOne(int id) {
		StudentItem studentItem = new StudentItem();
		return studentItem;
	}

	@Override
	public List<StudentItem> selectAll(int page, int countPerPage) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int totalCount() {
		// TODO Auto-generated method stub
		return 75;
	}

	@Override
	public void createTable() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void dropTable() {
		// TODO Auto-generated method stub
		
	}
}
