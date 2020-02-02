package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entities.Account;
import com.entities.AccountRole;
import com.entities.Role;
import com.service.AccountRoleService;

@RequestMapping("/accountrolecontroller")
@Controller
public class AccountRoleController {

	@Autowired
	private AccountRoleService accountRoleService;
	
	@ResponseBody
	@RequestMapping(value="/getAccountAndRoleLikeAccountName",method=RequestMethod.POST)
	public List<Account> getAccountAndRoleLikeAccountName(String lastName){
		return this.accountRoleService.getAccountAndRoleLikeAccountName(lastName);
	}
	
	@ResponseBody
	@RequestMapping(value="/getRole",method=RequestMethod.POST)
	public List<Role> getRole(){
		return this.accountRoleService.getRole();
	}
	
	@ResponseBody
	@RequestMapping(value="/doDelAccountRole",method=RequestMethod.POST)
	public boolean doDelAccountRole(Integer accountId){
		this.accountRoleService.doDelAccountRole(accountId);
		return true;
	}
	
	@ResponseBody
	@RequestMapping(value="/doInsAccountRole",method=RequestMethod.POST)
	public boolean doInsAccountRole(AccountRole accountRole){
		this.accountRoleService.doInsAccountRole(accountRole);
		return true;
	}
}
