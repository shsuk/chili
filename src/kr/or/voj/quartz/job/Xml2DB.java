package kr.or.voj.quartz.job;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import kr.or.voj.webapp.processor.ProcessorServiceFactory;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jdom.Attribute;
import org.jdom.Element;
import org.jdom.input.DOMBuilder;
import org.w3c.dom.Document;

public class Xml2DB implements Mapper {
	private static final Logger logger = Logger.getLogger(Xml2DB.class);
	private MapperInfo xmInfo;
	private File file;
	private CaseInsensitiveMap params;
	private int count = 0;
	
	public void setMapperInfo(MapperInfo xmInfo, File file) {
		this.xmInfo = xmInfo;
		this.file = file;

		params = new CaseInsensitiveMap();
	}

	public int execute() throws Exception{
		Element el = loadXmlElement(file);
		String path = el.getName();
		 
		searchNode(path, el.getChildren());
		
		return count;
	}

	@SuppressWarnings("unchecked")
	private void searchNode(String path, List<Element> list) throws Exception{

		for(Element el : list){
			String newPath = path + "/" + el.getName();
			String key = newPath.replaceAll("/", "/");
	        String val = el.getTextTrim();
			params.put(key, val);

			List<Attribute> ats =  el.getAttributes();
			
			if(ats!=null){
				for(Attribute at : ats){
					String atName = at.getName();
					String attPath = newPath + "@" + atName;
					String attVal = at.getValue();
					params.put(attPath, attVal);
				}
			}

			searchNode(newPath, el.getChildren());
			
			MapperTriggerInfo xmti = getTrigger(newPath);
			
			if(xmti==null){
				continue;
			}

			//쿼리 실행
			Map<String, Integer> rtn = (Map<String, Integer>)ProcessorServiceFactory.executeQuery(xmti.qyeryPath, xmti.queryAction, params);
			//업데이트 카운트 계산
			for(String rtnKey : rtn.keySet()){
				Object obj = rtn.get(rtnKey);
				
				if (obj instanceof Integer) {
					Integer cnt = (Integer) obj;
					count += cnt;
				}
			}
			//기 처리된 노드값 삭제
			deleteValue(xmti);
		}
	}
	
	private MapperTriggerInfo getTrigger(String path){
		List<MapperTriggerInfo> list = xmInfo.getTriggerList();
		
		for(MapperTriggerInfo xmti : list){
			if(StringUtils.equalsIgnoreCase(path, xmti.triggerXpath)) {
				return xmti;
			}
		}
		
		return null;
	}
	
	private void deleteValue(MapperTriggerInfo xmti) throws Exception {
		//이전값 유지 여부 체크
		if(!xmti.isDeleteValue){
			return;
		}
		
		List<String> list = new ArrayList<String>();
		String delXpath1 = xmti.triggerXpath +"/";
		String delXpath2 = xmti.triggerXpath +"@";
		
		for(Object key1 : params.keySet()){
			String key = (String)key1;
			
			if(key.startsWith(delXpath1) || key.startsWith(delXpath2) || key.startsWith(xmti.triggerXpath)){
				list.add(key);
			}
		}
		
		for(String key : list){
			params.remove(key);
		}
	}
	
	private Element loadXmlElement(File file) throws Exception{
        DOMBuilder domBuilder = new DOMBuilder();
			
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder;
        dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(file);
      
        return domBuilder.build(doc).getRootElement();
	}

	
}
