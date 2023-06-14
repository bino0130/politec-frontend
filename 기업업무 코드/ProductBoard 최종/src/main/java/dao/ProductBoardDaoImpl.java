package dao;

import java.sql.*;
import java.text.*;
import java.util.*;


public class ProductBoardDaoImpl implements ProductBoardDao{
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
			Connection conn = DriverManager.getConnection(URL, ID, PWD);
			Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			stmt.execute("create table if not exists product("
					 + "id int not null primary key, " // 학생 이름
			            + "name varchar(30), " // 이름
			            + "num int, " // 현재 재고수
			            + "checkDate date, " // 재고 확인날짜
			            + "registerDate date," // 재고 등록날짜
			            + "content text," // 내용
			            + "image_url text) " // 이미지 주소
			            + "DEFAULT CHARSET=utf8mb4;" // UTF-8로 default
			             );
			
			stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			conn.close(); // 리소스 정리 -> 메모리 누수 방지
			
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
			Connection conn = DriverManager.getConnection(URL, ID, PWD);
			Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			stmt.execute("drop table if exists product;");
			
			stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
	}
	
	@Override
	public void insertData(int id, String name, int num, String content, String image_url) {
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection conn = DriverManager.getConnection(URL, ID, PWD);
			Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			
			String Querytxt = String.format("insert into product values(%d, '%s', %d, '%s', '%s', '%s', '%s')",
											id, name, num, strToday, strToday, content, image_url);
			stmt.executeQuery(Querytxt);
			
			stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
	}
	
	@Override
	public void selectOne(int id) {
		
	}
	
	@Override
	public void selectAll(int id) {
		
	}
	
	@Override
	public void update() {
		
	}
	
	@Override
	public void delete() {
		
	}
	
	@Override // 재고 리스트
	public void showList() {
		try {
			Class.forName(DRIVE); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
			// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
			// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
			Connection conn = DriverManager.getConnection(URL, ID, PWD);
			Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
			
			stmt.executeQuery("select id, name, num, checkDate, registerDate from product");
			
			stmt.close(); // 리소스 정리 -> 메모리 누수 방지
			conn.close(); // 리소스 정리 -> 메모리 누수 방지
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
	}
	
	
}
