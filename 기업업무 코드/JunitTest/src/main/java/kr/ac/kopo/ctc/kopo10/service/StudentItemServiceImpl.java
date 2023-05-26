package kr.ac.kopo.ctc.kopo10.service;

import kr.ac.kopo.ctc.kopo10.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo10.dto.Pagination;

public class StudentItemServiceImpl implements StudentItemService {
	private StudentItemDao studentItemDao;
	
	@Override
	public Pagination getPagination(int page, int countPerPage) {
//		studentItemDao.selectAll(0, 0);
		
		Pagination pagination = new Pagination();
		
		int totalCount = studentItemDao.totalCount(); // 데이터 개수 : 75개로 고정
		int cnt = countPerPage; // cpp : cnt
		
		int totpageNum = (int) Math.ceil((double)totalCount/cnt);
		if (totpageNum < 1) {
			totpageNum = 1;
		}
		
		if (cnt < 1) {
			cnt = 1;
		}
		
		int showPageNum = 10; // showPageNum = cpp = cnt
		
		int currentPage=0;
		if (page < 1) {
			currentPage = 1;
		} else if (page > totpageNum) {
			currentPage = totpageNum;
		} else {
			currentPage = page;
		}
		pagination.setC(currentPage); // 현재 페이지 설정
		
		int from = (currentPage - 1) * cnt;
		
		int startPage = ((currentPage - 1) / showPageNum) * showPageNum + 1;
		int endPage = startPage + showPageNum - 1;
		if (endPage > totpageNum) {
			endPage = totpageNum;
		}
		
		pagination.setS(startPage); // 시작 페이지 설정
		pagination.setE(endPage); // 마지막 페이지 설정
		
		if (currentPage < 11) {
			pagination.setPp(-1);
		} else {
			pagination.setPp(1);
		}
		
		if (startPage < 2) {
			pagination.setP(-1);
		} else {
			pagination.setP(startPage - 10);
		}
		
//		int nextPage = (from + (cnt * 10)) / cnt + 1;
//		if (nextPage > totalCount) {
//			nextPage = (totalCount / cnt) * cnt;
//		}
//		pagination.setN(nextPage); // > 설정
//		pagination.setNn( ((totalCount/cnt) / 10 ) * 10 + 1); // >> 설정
		
		if (endPage == totpageNum) { // 현재 페이지의 끝페이지가 가장 끝페이지와 같을 때
			pagination.setNn(-1); // >> 설정
		} else if (endPage != totpageNum && totpageNum % 10 == 1){ // 맨 끝페이지가 21, 31, ... 일때
			pagination.setNn(totpageNum); // >> 설정
		} else {
			pagination.setNn(((totpageNum - 1) / 10) * 10 + 1); // -1 해준 뒤 나누기 10, 곱하기 10 해서 1의 자리 날리고 + 1
		}
		
		if (endPage == totpageNum) {
			pagination.setN(-1);
		} else {
			pagination.setN(endPage + 1);
		}
		
		if (countPerPage <= 0) { // countPerPage가 0 이하 수를 받을 때
			totpageNum = 1; // 전체 페이지 : 1
			pagination.setC(1);
			pagination.setPp(-1);
			pagination.setP(-1);
			pagination.setS(1);
			pagination.setE(1);
			pagination.setN(-1);
			pagination.setNn(-1);
		}
		
//		pagination.setC(5);
		
		return pagination;
	}

	@Override
	public StudentItemDao getStudentItemDao() {
		return studentItemDao;
	}
	
	@Override
	public void setStudentItemDao(StudentItemDao studentItemDao) {
		this.studentItemDao = studentItemDao;
		
	}
}