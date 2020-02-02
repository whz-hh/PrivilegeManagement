package com.dao;

import java.util.List;

import com.entities.Account;
import com.entities.AccountRole;
import com.entities.Role;

public interface AccountRoleDao {
	
	//模糊查询所有用户
	public List<Account> getAccountAndRoleLikeAccountName(String lastName);
	
	//查询用户的所有角色
	public List<Role> getRoleByAccountIdAndProjectId(Integer accountId);
	
	//查询所有角色
	public List<Role> getRole();
	
	//删除用户的所有角色
	public void doDelAccountRole(Integer accountId);
	
	//添加用户的角色
	public void doInsAccountRole(AccountRole accountRole);
	
}
