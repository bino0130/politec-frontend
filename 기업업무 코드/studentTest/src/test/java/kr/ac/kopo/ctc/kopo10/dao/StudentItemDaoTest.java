package kr.ac.kopo.ctc.kopo10.dao;

//import static org.junit.Assert.assertEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;


import java.sql.SQLException;
import java.util.List;

import org.junit.jupiter.api.Test;

import kr.ac.kopo.ctc.kopo10.domain.StudentItem;

class StudentItemDaoTest {

	@Test
	void test_createTable() {
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		StudentItem studentItem = studentItemDao.selectOne(5);
		
		studentItemDao.createTable();
	}
	
//	@Test
	void test_drop() {
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		StudentItem studentItem = studentItemDao.selectOne(5);
		
		studentItemDao.dropTable();
	}
	
	@Test
	void test_create() {
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		StudentItem studentItem = studentItemDao.selectOne(5);
		
		studentItemDao.create();
	}
	
	@Test
	void test_select_one(){
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		StudentItem studentItem = studentItemDao.selectOne(5);
		
		assertEquals(studentItem.getName(), "홍길5");
		assertEquals(studentItem.getStudentid(),5);
		assertEquals(studentItem.getKor(),30);
		assertEquals(studentItem.getEng(),90);
		assertEquals(studentItem.getMat(),100);
	}
	
	@Test
	void test_select_All() {
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		List<StudentItem> sla = studentItemDao.selectAll(3, 2);
		StudentItem selAll = sla.get(0);
		
		assertEquals(selAll.getName(),"홍길5");
	}
}
