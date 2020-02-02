package com.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ProjectDao;
import com.entities.Project;
import com.service.ProjectService;

@Service
public class ProjectServiceImp implements ProjectService {

	@Autowired
	private ProjectDao projectDao;
	@Transactional(readOnly = true)
	@Override
	public List<Project> getProjectLikeProjectName(String projectName) {
		
		return this.projectDao.getProjectLikeProjectName("%"+projectName+"%");
	}
	@Transactional
	@Override
	public void doDelProject(Integer projectId) {
		this.projectDao.doDelProject(projectId);
		
	}
	@Transactional
	@Override
	public void doInsProject(Project project) {
		this.projectDao.doInsProject(project);
		
	}
	@Transactional
	@Override
	public void doUpdProject(Project project) {
		this.projectDao.doUpdProject(project);
		
	}

}
