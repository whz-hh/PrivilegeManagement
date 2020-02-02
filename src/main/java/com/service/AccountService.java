package com.service;

import java.util.List;

import com.entities.Account;

public interface AccountService {

	public Account loginAccount(String accountName,String accountPassword);
	// 显示用户
		public List<Account> getAllAccount();
		// 增加用户
		public void insertAccount(Account account);
		// 删除用户
		public void deleteAccount(int accountId);
		// 改变用户信息
		public void updateAccount(Account account);
		// 查找用户
		public List<Account> getAccountByLastName(String lastName);

		public Account getAccountByAccountId(Integer accountId);

}
