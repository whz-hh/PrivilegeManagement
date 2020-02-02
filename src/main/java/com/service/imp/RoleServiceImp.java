package com.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.RoleDao;
import com.entities.Role;
import com.service.RoleService;

@Service
public class RoleServiceImp implements RoleService {
	@Autowired
	private RoleDao roleDao;

	@Transactional(readOnly = true)
	@Override
	public List<Role> getAllRole() {
		List<Role> role = this.roleDao.getAllRole();
		return role;
	}

	@Transactional(readOnly = true)
	@Override
	public Role getRoleByRoleId(Integer roleId) {
		return this.roleDao.getRoleByRoleId(roleId);
	}

	@Override
	public void insertRole(String roleName) {
		this.roleDao.insertRole(roleName);

	}

	@Override
	public void deleteRole(int roleId) {
		this.roleDao.deleteRole(roleId);

	}

	@Override
	public void updateRole(Role Role) {
		this.roleDao.updateRole(Role);

	}
	@Transactional(readOnly = true)
	@Override
	public List<Role> getRoleByLikeRoleName(String roleName) {
		List<Role> role =this.roleDao.getRoleByLikeRoleName("%"+roleName+"%");
		return role;
	}

}
