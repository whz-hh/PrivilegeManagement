package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.RoleMenuService;

@Controller
@RequestMapping("/roleMenuController")
public class RoleMenuController {

	@Autowired
	private RoleMenuService roleMenuService;
	
	@ResponseBody
	@RequestMapping(value="/doInsertRoleMenu",method=RequestMethod.POST)
	public boolean doInsertRoleMenu(String ins,Integer menuId){
		String[] roleIds=null;
		if(ins!="") {
			roleIds=ins.split(":");
		}
		return this.roleMenuService.doInsertRoleMenu(roleIds, menuId);
	}
	
}
