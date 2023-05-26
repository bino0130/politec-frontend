package kr.ac.kopo.ctc.kopo10.service;

import kr.ac.kopo.ctc.kopo10.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo10.dto.Pagination;

public class StudentItemServiceTest {
	// junit
	
		public static void main(String[] args) {
			
			
			StudentItemDao studentItemDao = new StudentItemDaoMock();
			StudentItemService studentItemService = new StudentItemServiceImpl();
			
			studentItemService.setStudentItemDao(studentItemDao);
			
			Pagination p = studentItemService.getPagination(0, 0);
			
			
		}
}	
