package com.dto;

import java.util.Date;

public class UsersVo {
	private String uid;
	private String upw;
	private String unm;
	private String utel;
	private String umail;
	private String ubirth;
	private Date ustart;
	private Date uend;
	private String use_yn; //사용여부 : 'y','n'만 가능
	private String urole; 
	//역할: user-사용자, sub-중간관리자, super-최고관리자
	
	public UsersVo() {}
	 
	// Getter/Setter
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public String getUnm() {
		return unm;
	}
	public void setUnm(String unm) {
		this.unm = unm;
	}
	public String getUtel() {
		return utel;
	}
	public void setUtel(String utel) {
		this.utel = utel;
	}
	public String getUmail() {
		return umail;
	}
	public void setUmail(String umail) {
		this.umail = umail;
	}
	public String getUbirth() {
		return ubirth;
	}
	public void setUbirth(String ubirth) {
		this.ubirth = ubirth;
	}
	public Date getUstart() {
		return ustart;
	}
	public void setUstart(Date ustart) {
		this.ustart = ustart;
	}
	public Date getUend() {
		return uend;
	}
	public void setUend(Date uend) {
		this.uend = uend;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getUrole() {
		return urole;
	}
	public void setUrole(String urole) {
		this.urole = urole;
	}
	@Override
	public String toString() {
		return "UsersVo [uid=" + uid + ", upw=" + upw + ", unm=" + unm + ", utel=" + utel + ", umail=" + umail
				+ ", ubirth=" + ubirth + ", ustart=" + ustart + ", uend=" + uend + ", use_yn=" + use_yn + ", urole="
				+ urole + "]";
	}
	
	
}
