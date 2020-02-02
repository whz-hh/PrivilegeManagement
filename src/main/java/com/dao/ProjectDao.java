package com.dao;

import java.util.List;

import com.entities.Project;

public interface ProjectDao {

	//模糊查询所有项目
	public List<Project> getProjectLikeProjectName(String projectName);
	
	//删除单个项目
	public void doDelProject(Integer projectId);
	
	//添加一个项目
	public void doInsProject(Project project);
	
	//修改一个项目
	public void doUpdProject(Project project);
}
