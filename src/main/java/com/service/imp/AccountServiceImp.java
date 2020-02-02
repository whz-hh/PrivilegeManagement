package com.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.AccountDao;
import com.entities.Account;
import com.service.AccountService;

@Service
public class AccountServiceImp implements AccountService {

	@Autowired
	private AccountDao accountDao;
	
	@Transactional(readOnly=true)
	@Override
	public Account loginAccount(String accountName, String accountPassword) {
		Account account = this.accountDao.loginAccount(accountName, accountPassword);
		return account;
	}
	@Transactional(readOnly=true)
	@Override
	public List<Account> getAllAccount() {
		List<Account> accountAll = this.accountDao.getAllAccount();
		return accountAll;
	}

	@Override
	public void insertAccount(Account account) {
		this.accountDao.insertAccount(account);
		
	}

	@Override
	public void deleteAccount(int accountId) {
		this.accountDao.deleteAccount(accountId);
		
	}

	@Override
	public void updateAccount(Account account) {
		this.accountDao.updateAccount(account);
		
	}
    @Transactional(readOnly = true)
	@Override
	public List<Account> getAccountByLastName(String lastName) {
		List<Account> account=this.accountDao.getAccountByLastName("%"+lastName+"%");
    	return account;
    
      }
	@Override
	public Account getAccountByAccountId(Integer accountId) {
		 
		return this.accountDao.getAccountByAccountId(accountId);
	}
}
