package dao;

import java.util.List;
import java.sql.*;

public interface ProductBoardDao {
	void createTable();
	
	void dropTable();
	
	void insertData(int id, String name, int num, String content, String image_url);
	
	void selectOne(int id);
	
	void selectAll(int id);
	
	void showList();
	
	void update();
	
	void delete();
}
