package com.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entities.Menu;
import com.service.MenuService;

@RequestMapping(value = "/menucontroller")
@Controller
public class MenuController {

	public Integer accountId1;
	public Integer projectId1;
	
	@Autowired
	private MenuService menuService;
	
	@ResponseBody
	@RequestMapping(value="/getMenuByProjectIdAndAccountId", method=RequestMethod.POST)
	public List<Menu> getMenuByProjectIdAndAccountId(Integer accountId, Integer projectId){
		accountId1 = accountId;
		projectId1 = projectId;
		return this.menuService.getMenuByProjectIdAndAccountId(accountId, projectId);
	}
	
	@ResponseBody
	@RequestMapping(value="/getMenuLikeMenuGrade",method=RequestMethod.POST)
	public List<Menu> getMenuLikeMenuGrade(String menuGrade){
		return this.menuService.getMenuLikeMenuGrade(menuGrade,accountId1,projectId1);
	}
	
	@ResponseBody
	@RequestMapping(value="/getMenuByProjectId",method=RequestMethod.POST)
	public List<Menu> getMenuByProjectId(Integer projectId ,String menuGrade){
		return this.menuService.getAllMenuByProjectId(projectId,menuGrade);
	}
	@ResponseBody
	@RequestMapping(value="/doInsertMenu",method=RequestMethod.POST)
	public boolean doInsertMenu(Menu menu){
		return this.menuService.doInsertMenu(menu);
	}
	@ResponseBody
	@RequestMapping(value="/getMenuByMenuId",method=RequestMethod.POST)
	public Menu getMenuByMenuId(Integer menuId){
		return this.menuService.getMenuByMenuId(menuId);
	}
	@ResponseBody
	@RequestMapping(value="/doUpdateMenu",method=RequestMethod.POST)
	public boolean doUpdateMenu(Menu menu){
		return this.menuService.doUpdateMenu(menu);
	}
	
	@ResponseBody
	@RequestMapping(value="/doDeleteMenu",method=RequestMethod.POST)
	public boolean doDeleteMenu(Integer menuId){
		return this.menuService.doDeleteMenu(menuId);
	}
}
