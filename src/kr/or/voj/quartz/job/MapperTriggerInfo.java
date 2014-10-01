package kr.or.voj.quartz.job;

import java.util.Map;

public class MapperTriggerInfo {
	public String qyeryPath;
	public String queryAction;
	public String triggerXpath;
	public boolean isDeleteValue;
	
	public MapperTriggerInfo(Map<String, Object> row){
		qyeryPath = (String)row.get("qyery_path");
		queryAction = (String)row.get("query_action");
		triggerXpath = (String)row.get("trigger_xpath");
		isDeleteValue = "Y".equals((String)row.get("delete_value"));			
	}
}
