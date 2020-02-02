package com.entities;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Project implements Serializable{

	private Integer projectId;
	private String projectName;
	private String projectInfo;
	private String launchDate;
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectInfo() {
		return projectInfo;
	}
	public void setProjectInfo(String projectInfo) {
		this.projectInfo = projectInfo;
	}
	public String getLaunchDate() {
		return launchDate;
	}
	public void setLaunchDate(String launchDate) {
		this.launchDate = launchDate;
	}
	
}
