package kr.ac.kopo.ctc.kopo10.service;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import kr.ac.kopo.ctc.kopo10.dao.StudentItemDaoImpl;
import kr.ac.kopo.ctc.kopo10.dto.Pagination;

class StudentServiceJtest {

   @Test
   void test_1_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(1, 5);
      assertEquals(pagination.getC(),1);
      assertEquals(pagination.getPp(),-1);
      assertEquals(pagination.getP(),-1);
      assertEquals(pagination.getS(),1);
      assertEquals(pagination.getE(),10);
      assertEquals(pagination.getN(),11);
      assertEquals(pagination.getNn(),11);
   }
   
   @Test
   void test_0_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(0, 5);
      assertEquals(pagination.getC(),1);
      assertEquals(pagination.getPp(),-1);
      assertEquals(pagination.getP(),-1);
      assertEquals(pagination.getS(),1);
      assertEquals(pagination.getE(),10);
      assertEquals(pagination.getN(),11);
      assertEquals(pagination.getNn(),11);
   }
   
   @Test
   void test_m1_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(-1, 5);
      assertEquals(pagination.getC(),1);
      assertEquals(pagination.getPp(),-1);
      assertEquals(pagination.getP(),-1);
      assertEquals(pagination.getS(),1);
      assertEquals(pagination.getE(),10);
      assertEquals(pagination.getN(),11);
      assertEquals(pagination.getNn(),11);
   }
   
   @Test
   void test_10_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(10, 5);
      assertEquals(pagination.getS(),1);
      assertEquals(pagination.getE(),10);
      assertEquals(pagination.getC(),10);
      assertEquals(pagination.getPp(),-1);
      assertEquals(pagination.getP(),-1);
      assertEquals(pagination.getN(),11);
      assertEquals(pagination.getNn(),11);
   }
   
   @Test
   void test_11_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(11, 5);
      assertEquals(pagination.getS(),11);
      assertEquals(pagination.getE(),15);
      assertEquals(pagination.getC(),11);
      assertEquals(pagination.getPp(),1);
      assertEquals(pagination.getP(),1);
      assertEquals(pagination.getN(),-1);
      assertEquals(pagination.getNn(),-1);
   }
   
   @Test
   void test_14_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(14, 5);
      assertEquals(pagination.getS(),11);
      assertEquals(pagination.getE(),15);
      assertEquals(pagination.getC(),14);
      assertEquals(pagination.getPp(),1);
      assertEquals(pagination.getP(),1);
      assertEquals(pagination.getN(),-1);
      assertEquals(pagination.getNn(),-1);
   }
   
   @Test
   void test_15_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(15, 5);
      assertEquals(pagination.getS(),11);
      assertEquals(pagination.getE(),15);
      assertEquals(pagination.getC(),15);
      assertEquals(pagination.getPp(),1);
      assertEquals(pagination.getP(),1);
      assertEquals(pagination.getN(),-1);
      assertEquals(pagination.getNn(),-1);
   }
   
   @Test
   void test_16_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(16, 5);
      assertEquals(pagination.getS(),11);
      assertEquals(pagination.getE(),15);
      assertEquals(pagination.getC(),15);
      assertEquals(pagination.getPp(),1);
      assertEquals(pagination.getP(),1);
      assertEquals(pagination.getN(),-1);
      assertEquals(pagination.getNn(),-1);
   }
   
   @Test
   void test_20_5() {
      StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

      StudentItemService studentItemService = new StudentItemServiceImpl();
      studentItemService.setStudentItemDao(studentItemDao);
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount();

      Pagination pagination = studentItemService.getPagination(20, 5);
      assertEquals(pagination.getS(),11);
      assertEquals(pagination.getE(),15);
      assertEquals(pagination.getC(),15);
      assertEquals(pagination.getPp(),1);
      assertEquals(pagination.getP(),1);
      assertEquals(pagination.getN(),-1);
      assertEquals(pagination.getNn(),-1);
   }
   
 @Test
 void test_test() {
    StudentItemDaoMock studentItemDao = new StudentItemDaoMock();

    StudentItemService studentItemService = new StudentItemServiceImpl();
    studentItemService.setStudentItemDao(studentItemDao);
    StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
    int totalCount = studentItemDaoImpl.totalCount();

    Pagination pagination = studentItemService.getPagination(20000, 0);
    assertEquals(pagination.getC(),1);
    assertEquals(pagination.getPp(),-1);
    assertEquals(pagination.getP(),-1);
    assertEquals(pagination.getS(),1);
    assertEquals(pagination.getE(),1);
    assertEquals(pagination.getN(),-1);
    assertEquals(pagination.getNn(),-1);
 }
   
   
   
   

}