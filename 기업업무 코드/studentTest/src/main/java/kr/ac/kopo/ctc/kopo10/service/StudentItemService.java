package kr.ac.kopo.ctc.kopo10.service;

import kr.ac.kopo.ctc.kopo10.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo10.dto.Pagination;

public interface StudentItemService {
	StudentItemDao getStudentItemDao();
	void setStudentItemDao(StudentItemDao studentItemDao);
	
	Pagination getPagination(int page, int countPerPage);
}
