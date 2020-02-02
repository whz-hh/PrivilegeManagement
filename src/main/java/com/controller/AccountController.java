package com.controller;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.entities.Account;
import com.service.AccountService;

@SessionAttributes(types=Account.class)
@RequestMapping(value="/accountController")
@Controller
public class AccountController {

	@Autowired
	private AccountService accountService;
	
	@ResponseBody
	@RequestMapping(value = "/loginAccount")
	public boolean loginAccount(String accountName,String accountPassword,Map<String, Object> map) {
		Account account = this.accountService.loginAccount(accountName, accountPassword);
		if(account != null) {
			map.put("account", account);
			return true;
		}else {
			return false;
		}
	}
	@ResponseBody
	 @RequestMapping(value="/getAllAccount",method=RequestMethod.POST)
		public List<Account> getAllAccount(Map<String, Object>map){
			List<Account> accountAll=this.accountService.getAllAccount();
		   map.put("accountAll",accountAll);
			return accountAll;
		}
	    @ResponseBody
		@RequestMapping(value="/insertAccount",method=RequestMethod.POST)
		public boolean insertAccount(Account account) {
			boolean flag=false;
			this.accountService.insertAccount(account);
			flag=true;
			return flag;
		}
		@ResponseBody
		@RequestMapping(value="/deleteAccount",method=RequestMethod.POST)
		public boolean deleteAccount(int accountId) {
			try {
				 this.accountService.deleteAccount(accountId);
			} catch (Exception e) {
				return false;
			}
			
			return true;
			
		}
		@ResponseBody
		@RequestMapping(value="/updateAccount",method=RequestMethod.POST)
		public boolean updateAccount(Account account) {
			boolean flag=false;
			this.accountService.updateAccount(account);
			flag=true;
			return flag;
		}
		@ResponseBody
		@RequestMapping(value="/lastNmaeAccount",method=RequestMethod.POST)
		public List<Account> getAccountByLastName(String lastName){
			List<Account> account= this.accountService.getAccountByLastName(lastName);
			return account;
			
		}
		@ResponseBody
		@RequestMapping(value="/getAccountId",method=RequestMethod.POST)
		public Account getAccountByAccountId(String accountId) {
			int id=Integer.parseInt(accountId);
		Account account=this.accountService.getAccountByAccountId(id);
			return account;
		}
}
