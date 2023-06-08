package kr.ac.kopo.ctc.kopo10.dao;

import java.sql.*;
import java.util.*;
import java.io.*;

import kr.ac.kopo.ctc.kopo10.domain.StudentItem;

public class StudentItemDaoImpl implements StudentItemDao{
	String URL = "jdbc:mysql://192.168.23.59:33060/kopo10";
	String ID = "root";
	String PWD =  "kopoctc";
	String DRIVE = "com.mysql.cj.jdbc.Driver";
	
	@Override
	public void createTable() {
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection k10_conn = DriverManager.getConnection(URL, ID, PWD);
			
			Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			k10_stmt.execute("create table twice("
					 +"name varchar(20), " // 학생 이름
			            +"studentid int not null primary key, " // 학번
			            +"kor int, " // 국어 점수
			            +"eng int, " // 영어 점수
			            +"mat int) " // 수학 점수
			            +"DEFAULT CHARSET=utf8mb4;" // UTF-8로 default
			             );
			
			k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
	}
	
	@Override
	public void dropTable() {
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection k10_conn = DriverManager.getConnection(URL, ID, PWD);
			
			Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			k10_stmt.execute("drop table if exists twice;"); // twice 테이블 통째로 삭제
			
			k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
	}
	
	@Override
	public StudentItem create() { // C
		StudentItem si = new StudentItem();
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection k10_conn = DriverManager.getConnection(URL, ID, PWD);
			
			Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			for (int i = 1; i <= 50; i++) {
				String name = "홍길" + String.valueOf(i);
				
//				int kor = ;
				si.setStudentid(i);
				si.setKor((int) (Math.random()*10) * 10 + 10);
				si.setEng((int) (Math.random()*10) * 10 + 10);
				si.setMat((int) (Math.random()*10) * 10 + 10);
				
				String QueryTxt = String.format("insert into twice (name, studentid, kor, eng, mat) "
						+ "value ('%s', %d, %d, %d, %d);",name,si.getStudentid(),si.getKor(),si.getEng(),si.getMat());
				k10_stmt.execute(QueryTxt);
			}
			
			k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
		
		return si;
	}

	@Override
	public StudentItem selectOne(int id) { // R
		StudentItem si = new StudentItem();
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection k10_conn = DriverManager.getConnection(URL, ID, PWD);
			
			Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			String QueryTxt = String.format("select * from twice where studentid = %d",id);
			ResultSet k10_rset = k10_stmt.executeQuery(QueryTxt);
			
			
			while (k10_rset.next()) { // rset이 있으면
				si.setName(k10_rset.getString(1)); // id 출력
				si.setStudentid(k10_rset.getInt(2));
				si.setKor(k10_rset.getInt(3));
				si.setEng(k10_rset.getInt(4));
				si.setMat(k10_rset.getInt(5));
			}
			
			k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
			
			
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
		
		return si; // return 변경해주기
	}

	@Override
	public List<StudentItem> selectAll(int page, int countPerPage) { // R
		List<StudentItem> lsi = new ArrayList<StudentItem>();
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection k10_conn = DriverManager.getConnection(URL, ID, PWD);
			
			Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			int bf_page = (page - 1) * countPerPage;
			if(bf_page < 0) {
				bf_page = 0;
			}
			
			String QueryTxt = String.format("select * from twice limit %d, %d;",bf_page, countPerPage);
			ResultSet k10_rset = k10_stmt.executeQuery(QueryTxt);
			
			
			while (k10_rset.next()) { // rset이 있으면
				StudentItem si = new StudentItem();
				si.setName(k10_rset.getString(1)); // id 출력
				si.setStudentid(k10_rset.getInt(2));
				si.setKor(k10_rset.getInt(3));
				si.setEng(k10_rset.getInt(4));
				si.setMat(k10_rset.getInt(5));
				
				lsi.add(si);
			}
			
			k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
		
		return lsi;
	}

	@Override
	public int totalCount() {
		// TODO Auto-generated method stub
		return 75;
	}
}
