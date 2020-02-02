package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entities.Project;
import com.service.ProjectService;


@RequestMapping(value="/projectcontroller")
@Controller
public class ProjectController {

	@Autowired
	private ProjectService projectService;
	
	
	@ResponseBody
	@RequestMapping(value="/getProjectLikeProjectName",method=RequestMethod.POST)
	public List<Project> getProjectLikeProjectName(String projectName){
		List<Project> projects = this.projectService.getProjectLikeProjectName(projectName);
		return projects;
	}
	@ResponseBody
	@RequestMapping(value="/doDelProject",method=RequestMethod.POST)
	public boolean doDelProject(Integer projectId){
		this.projectService.doDelProject(projectId);
		return true;
	}
	
	@ResponseBody
	@RequestMapping(value="/doInsProject",method=RequestMethod.POST)
	public boolean doInsProject(Project project){
		this.projectService.doInsProject(project);
		return true;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/doUpdProject",method=RequestMethod.POST)
	public boolean doUpdProject(Project project){
		this.projectService.doUpdProject(project);
		return true;
	}
}
