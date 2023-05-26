package kr.ac.kopo.ctc.kopo10.dto;

public class Pagination {
	private int c; // 현재 페이지
	private int s; // 시작 페이지 (ex : 1~15 중 1)
	private int e; // 끝 페이지 (ex : 1~15 중 15)
	private int p; // <
	private int pp; // <<
	private int n; // >
	private int nn; // >>
	
	public int getC() {
		return c;
	}
	public void setC(int c) {
		this.c = c;
	}
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
	}
	public int getE() {
		return e;
	}
	public void setE(int e) {
		this.e = e;
	}
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public int getPp() {
		return pp;
	}
	public void setPp(int pp) {
		this.pp = pp;
	}
	public int getN() {
		return n;
	}
	public void setN(int n) {
		this.n = n;
	}
	public int getNn() {
		return nn;
	}
	public void setNn(int nn) {
		this.nn = nn;
	}
}