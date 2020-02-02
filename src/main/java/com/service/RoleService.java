package com.service;

import java.util.List;

import com.entities.Role;

public interface RoleService {
	    //查找所有角色
		public List<Role> getAllRole();
		//根据id查找名字
		public Role getRoleByRoleId(Integer roleId);
		// 增加角色
		public void insertRole(String roleName);
		// 删除角色用户
		public void deleteRole(int roleId);
		// 改变角色
		public void updateRole(Role Role);
		//根据名字查询
		public List<Role> getRoleByLikeRoleName(String roleName);

}
