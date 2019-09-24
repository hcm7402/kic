package com.kic.groupware.model1.user;

public class UserTO {
	int eno;
	String ename;
	String pno;
	String hiredate;
	String sal;
	String birth;
	String address;
	String deptno;
	String email;
	String ephoto;
	String eid;
	String epw;
	String authphoto;
	int level;

	
	public String getDeptno() {
		return deptno;
	}
	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}
	public String getPno() {
		return pno;
	}
	public void setPno(String pno) {
		this.pno = pno;
	}
	public String getSal() {
		return sal;
	}
	public void setSal(String sal) {
		this.sal = sal;
	}
	public int getEno() {
		return eno;
	}
	public void setEno(int eno) {
		this.eno = eno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getHiredate() {
		return hiredate;
	}
	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEphoto() {
		return ephoto;
	}
	public void setEphoto(String ephoto) {
		this.ephoto = ephoto;
	}
	public String getEid() {
		return eid;
	}
	public void setEid(String eid) {
		this.eid = eid;
	}
	public String getEpw() {
		return epw;
	}
	public void setEpw(String epw) {
		this.epw = epw;
	}
	public String getAuthphoto() {
		return authphoto;
	}
	public void setAuthphoto(String authphoto) {
		this.authphoto = authphoto;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
}
