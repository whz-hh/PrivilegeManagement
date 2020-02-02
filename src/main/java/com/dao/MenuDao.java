package com.dao;

import java.util.List;

import com.entities.Menu;

public interface MenuDao {

	//查询该用户的所有角色
	public List<AccountRoleDao> getRoleByAccountId(Integer accountId);
	
	//查询这个角色的所有菜单
//	public RoleMenu getMenuByRole(List<AccountRole> roles);
	
	//查询该用户的菜单
	public List<Integer> getMenuByAccountId(Integer accountId);
	
	//查询该个项目的菜单
	public List<Menu> getMenuByMenuId(List<Integer> menuId,Integer projectId);
	
	//查询出二级菜单列表,或者获取三级菜单
	public List<Menu> getMenuLikeMenuGrade(String menuGrade,Integer accountId,Integer projectId);
	
	//获取该项目所有一级菜单或二级三级菜单
	public List<Menu> getAllMenuByProjectId(Integer projectId ,String menuGrade);
	//查询三级菜单列表
//	public List<Menu> getMenuLikeMenuGrade2(String menuGrade);
	
	//添加菜单
	public void doInsertMenu(Menu menu);
	
	//获取最大的等级
	public String getMenuGrade(Menu menu);
	
	//通过菜单Id 查询菜单
	public Menu getMenuByMenu(Integer menuId);
	//修改菜单
	public void doUpdateMenu(Menu menu);
	
	//删除菜单
	public void doDeleteMenu(Integer menuId);
	//通过角色等级来获取菜单
	public Menu getMenuByMenuGrade(String menuGrade);
}
