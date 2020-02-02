package com.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class AccountRole {

	private Integer accountId;
	private Integer roleId;
	private List<Integer> roles;
	public Integer getAccountId() {
		return accountId;
	}
	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public List<Integer> getRoles() {
		return roles;
	}
	public void setRoles(List<Integer> roles) {
		this.roles = roles;
	}
	
}
