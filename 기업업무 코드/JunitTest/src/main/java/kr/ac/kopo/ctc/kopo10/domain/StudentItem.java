package kr.ac.kopo.ctc.kopo10.domain;

public class StudentItem {
	 private String name;
	 private int studentid;
	 private int kor;
	 private int eng;
	 private int mat;
	   // 학번이랑 등등 알아서 넣으시고~
	   
//	 public int getId() {
//	      return id;
//	 }
//	 
//	 public void setId(int id) {
//	      this.id = id;
//	 }
	 
	 public String getName() {
	      return name;
	 }
	 
	 public void setName(String name) {
	      this.name = name;
	 }

	public int getStudentid() {
		return studentid;
	}

	public void setStudentid(int studentid) {
		this.studentid = studentid;
	}

	public int getKor() {
		return kor;
	}

	public void setKor(int kor) {
		this.kor = kor;
	}

	public int getEng() {
		return eng;
	}

	public void setEng(int eng) {
		this.eng = eng;
	}

	public int getMat() {
		return mat;
	}

	public void setMat(int mat) {
		this.mat = mat;
	}
}
