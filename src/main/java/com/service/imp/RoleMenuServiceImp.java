package com.service.imp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.MenuDao;
import com.dao.RoleMenuDao;
import com.entities.Menu;
import com.service.RoleMenuService;
@Service
public class RoleMenuServiceImp implements RoleMenuService {
	@Autowired
	private RoleMenuDao roleMenuDao;
	@Autowired
	private MenuDao menuDao;
	
	@Transactional
	@Override
	public boolean doInsertRoleMenu(String[] reoleIds, Integer menuId) {
		//先查询出菜单详情
		Menu menu =this.menuDao.getMenuByMenu(menuId);
		//查询此菜单的子菜单的所有角色
		List<Integer> list=this.roleMenuDao.getSubMenuRoleIdsByMenuGrade(menu.getMenuGrade());
		//数组转化List;
		List<Integer> list2=new ArrayList<Integer>();
		if(reoleIds!=null) {
			for(int i=0;i<reoleIds.length;i++) {
				list2.add(Integer.parseInt(reoleIds[i]));
			}
		}
		boolean flag=false;
		if(list2.containsAll(list)) {
			this.roleMenuDao.doDeleteRoleMenuByMenuId(menuId);
			if(list2.size()!=0) {
				this.roleMenuDao.doInsertRoleMenu(list2, menuId);
			}
			//判断是几级菜单
			if(menu.getMenuGrade().length()==9) {
				//是三级菜单，给二级菜单和一级菜单添加角色
				Menu menu2=this.menuDao.getMenuByMenuGrade(menu.getMenuGrade().substring(0,6));
				List<Integer> listmenu2=this.roleMenuDao.getSubMenuRoleIdsByMenuGrade(menu2.getMenuGrade());
				this.roleMenuDao.doDeleteRoleMenuByMenuId(menu2.getMenuId());
				if(listmenu2.size()!=0) {
					this.roleMenuDao.doInsertRoleMenu(listmenu2, menu2.getMenuId());
				}
				Menu menu3=this.menuDao.getMenuByMenuGrade(menu.getMenuGrade().substring(0,3));
				List<Integer> listmenu3=this.roleMenuDao.getSubMenuRoleIdsByMenuGrade(menu3.getMenuGrade());
				this.roleMenuDao.doDeleteRoleMenuByMenuId(menu3.getMenuId());
				if(listmenu3.size()!=0) {
					this.roleMenuDao.doInsertRoleMenu(listmenu3, menu3.getMenuId());
				}
			}else if (menu.getMenuGrade().length()==6){
				//如果是二级菜单一级菜单添加角色
				Menu menu2=this.menuDao.getMenuByMenuGrade(menu.getMenuGrade().substring(0,3));
				List<Integer> listmenu2=this.roleMenuDao.getSubMenuRoleIdsByMenuGrade(menu2.getMenuGrade());
				this.roleMenuDao.doDeleteRoleMenuByMenuId(menu2.getMenuId());
				if(listmenu2.size()!=0) {
					this.roleMenuDao.doInsertRoleMenu(listmenu2, menu2.getMenuId());
				}
			}
			flag=true;
		}else {
			return false;
		}
		return flag;
	}

}
