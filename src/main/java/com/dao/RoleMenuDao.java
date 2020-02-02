package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RoleMenuDao {
	//通过菜单id删除角色菜单关系表
	public void doDeleteRoleMenuByMenuId(Integer menuId);
	//传入数组和菜单来添加角色菜单
	public void doInsertRoleMenu(List<Integer> reoles,Integer menuId);
	//通过菜单等级来找出当前菜单的子菜单所有角色集合
	public List<Integer> getSubMenuRoleIdsByMenuGrade(@Param("menuGrade")String menuGrade);
}
