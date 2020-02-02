package com.service.imp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.MenuDao;
import com.entities.Menu;
import com.service.MenuService;

@Service
public class MenuServiceImp implements MenuService{

	@Autowired
	private MenuDao menuDao;

	@Transactional(readOnly = true)
	@Override
	public List<Menu> getMenuByProjectIdAndAccountId(Integer accountId, Integer projectId) {
		List<Integer> menuId = this.menuDao.getMenuByAccountId(accountId);
		List<Menu> menu = this.menuDao.getMenuByMenuId(menuId, projectId);
		List<Menu> menu3 = new ArrayList<>();
		for (Menu menu2 : menu) {
			if(menu2.getMenuGrade().length() == 3) {
				menu3.add(menu2);
			}
		}
		return menu3;
	}
	@Transactional(readOnly = true)
	@Override
	public List<Menu> getMenuLikeMenuGrade(String menuGrade,Integer accountId,Integer projectId) {
		
		return this.menuDao.getMenuLikeMenuGrade(menuGrade+"___",accountId,projectId);
	}
	
	@Transactional(readOnly = true)
	@Override
	public List<Menu> getAllMenuByProjectId(Integer projectId,String menuGrade) {
		return this.menuDao.getAllMenuByProjectId(projectId,menuGrade);
	}
	@Transactional()
	@Override
	public boolean doInsertMenu(Menu menu) {
		boolean flag=false;
		String menugrade=this.menuDao.getMenuGrade(menu);
		if(menugrade!=null) {
			Integer length=this.menuDao.getMenuGrade(menu).length();
			Integer menuGrade=Integer.parseInt(this.menuDao.getMenuGrade(menu))+1;
			menu.setMenuGrade(String.format("%0"+length+"d", menuGrade));
		}else {
			menu.setMenuGrade(menu.getMenuGrade()+"001");
		}
		this.menuDao.doInsertMenu(menu);
		flag=true;
		return flag;
	}
	@Transactional(readOnly = true)
	@Override
	public Menu getMenuByMenuId(Integer menuId) {
		return this.menuDao.getMenuByMenu(menuId);
	}

	@Override
	public boolean doUpdateMenu(Menu menu) {
		boolean flag=false;
		this.menuDao.doUpdateMenu(menu);
		flag=true;
		return flag;
	}

	@Override
	public boolean doDeleteMenu(Integer menuId) {
		boolean flag=false;
		try {
			this.menuDao.doDeleteMenu(menuId);
			flag=true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
}
