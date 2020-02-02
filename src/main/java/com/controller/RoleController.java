package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entities.Role;
import com.service.RoleService;
@RequestMapping(value="/roleController")
@Controller
public class RoleController {
	@Autowired
	private RoleService roleService;

	@ResponseBody
	@RequestMapping(value="/getAllRole",method = RequestMethod.POST)
	public List<Role> getAllRole() {
		List<Role> role=this.roleService.getAllRole();
		return role;
		
	}
	@ResponseBody
	@RequestMapping(value="/getAllRoleById",method = RequestMethod.POST)
	public Role getRoleByRoleId(Integer roleId) {
		Role role=this.roleService.getRoleByRoleId(roleId);
		return role;
		
	}
	@ResponseBody
	@RequestMapping(value="/insertRole",method = RequestMethod.POST)
		public boolean insertRole(String roleName) {
			this.roleService.insertRole(roleName);
			return true;
			
		}
	@ResponseBody
	@RequestMapping(value="/deleteRole",method = RequestMethod.POST)
		public boolean deleteRole(int roleId) {
			try {
				this.roleService.deleteRole(roleId);
			} catch (Exception e) {
				return false;
				
			}
				return true;
				
			}
	
	@ResponseBody
	@RequestMapping(value="/updateRole",method = RequestMethod.POST)
		public boolean updateRole(Role Role) {
			boolean flag=false;
			this.roleService.updateRole(Role);
			flag=true;
			return flag;
		}
	@ResponseBody
	@RequestMapping(value="/getRoleByLikeRoleName",method = RequestMethod.POST)
	public List<Role> getRoleByLikeRoleName(String roleName) {
		List<Role> role=this.roleService.getRoleByLikeRoleName(roleName);
		return role;
		
	}

}
