package com.service;

import java.util.List;

import com.entities.Menu;

public interface MenuService {

	//根据项目id和用户id查询出一级菜单
	public List<Menu> getMenuByProjectIdAndAccountId(Integer accountId, Integer projectId);
	
	//查询二级菜单或者三级菜单
	public List<Menu> getMenuLikeMenuGrade(String menuGrade,Integer accountId,Integer projectId);
	
	//查询项目的所有一级菜单或二三级菜单
	public List<Menu> getAllMenuByProjectId(Integer projectId,String menuGrade);
	
	//添加一个菜单
	public boolean doInsertMenu(Menu menu);
	
	//通过菜单Id获取菜单
	public Menu getMenuByMenuId(Integer menuId);
	 //修改菜单
	public boolean doUpdateMenu(Menu menu); 
	//删除菜单
	public boolean doDeleteMenu(Integer menuId);
		
}
