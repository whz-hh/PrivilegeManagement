package com.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class RoleMenu {

	private Integer roleId;
	private Integer menuId;
	private List<Integer> menus;
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public List<Integer> getMenus() {
		return menus;
	}
	public void setMenus(List<Integer> menus) {
		this.menus = menus;
	}
	
}
