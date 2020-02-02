package com.dao;

import java.util.List;

import com.entities.Account;

public interface AccountDao {

	public Account loginAccount(String accountName, String accountPassword);

	public Account getAccountByAccountIdAndProjectId(Integer accountId, Integer projectId);

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

	//根据ID查找用户
	public Account getAccountByAccountId(Integer accountId);

}
