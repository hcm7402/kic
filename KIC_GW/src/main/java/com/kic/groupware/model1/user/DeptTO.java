package com.kic.groupware.model1.user;

import java.util.ArrayList;

public class DeptTO {
	int deptno;
	String dname;
	ArrayList<String> deptdata;
	
	public ArrayList<String> getDeptdata() {
		return deptdata;
	}
	public void setDeptdata(ArrayList<String> deptdata) {
		this.deptdata = deptdata;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
}
