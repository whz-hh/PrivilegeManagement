package com.service;

public interface RoleMenuService {
	//为菜单设置角色权限
	public boolean doInsertRoleMenu(String[] reoleIds,Integer menuId);
}
