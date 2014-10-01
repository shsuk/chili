package kr.or.voj.quartz.job;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.voj.webapp.processor.ProcessorServiceFactory;

import org.apache.commons.collections.map.CaseInsensitiveMap;

public class MapperInfo {
	private String mapperId;
	private String sourcePath;
	private String mapperAdapteClass;
	private boolean isTransactional;
	private String sucessPath;
	private String errorPath;
	private List<MapperTriggerInfo> triggerList;
	
	public List<MapperTriggerInfo> getTriggerList() {
		return triggerList;
	}

	public String getMapperId() {
		return mapperId;
	}

	public String getSourcePath() {
		return sourcePath;
	}

	public String getSucessPath() {
		return sucessPath;
	}
	public String getErrorPath() {
		return errorPath;
	}
	public String getMapperAdapteClass() {
		return mapperAdapteClass;
	}

	public boolean isTransactional() {
		return isTransactional;
	}

	public MapperInfo(Map<String, Object> row) throws Exception{
		mapperId = (String)row.get("mapper_id");
		sourcePath = (String)row.get("source_path");
		sucessPath = (String)row.get("sucess_path");
		errorPath = (String)row.get("error_path");		
		isTransactional = "Y".equals((String)row.get("transactional"));			
		mapperAdapteClass = (String)row.get("mapper_adapter_class");			

		triggerList= new ArrayList<MapperTriggerInfo>();
		CaseInsensitiveMap param = new CaseInsensitiveMap();
		param.put("mapper_id", mapperId);
		Map<String, List<Map<String, Object>>> rtn = (Map<String, List<Map<String, Object>>>)ProcessorServiceFactory.executeQuery("system", "mapperTrigger", param);
		
		for(Map<String, Object> rw : rtn.get("rows")){
			MapperTriggerInfo xmlMapperTriggerInfo = new MapperTriggerInfo(rw);
			
			triggerList.add(xmlMapperTriggerInfo);
		}
	}
}
