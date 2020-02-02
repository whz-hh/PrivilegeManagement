package com.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.AccountRoleDao;
import com.entities.Account;
import com.entities.AccountRole;
import com.entities.Role;
import com.service.AccountRoleService;

@Service
public class AccountRoleServiceImp implements AccountRoleService {

	@Autowired
	private AccountRoleDao accountRoleDao;
	@Transactional
	@Override
	public List<Account> getAccountAndRoleLikeAccountName(String lastName) {
		
		return this.accountRoleDao.getAccountAndRoleLikeAccountName("%"+lastName+"%");
	}
	@Transactional(readOnly = true)
	@Override
	public List<Role> getRole() {
		
		return this.accountRoleDao.getRole();
	}
	@Transactional
	@Override
	public void doDelAccountRole(Integer accountId) {
		this.accountRoleDao.doDelAccountRole(accountId);
		
	}
	@Transactional
	@Override
	public void doInsAccountRole(AccountRole accountRole) {
		if(accountRole.getRoleId() != null) {
			this.accountRoleDao.doInsAccountRole(accountRole);
		}
	}

}
