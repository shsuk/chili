package kr.or.voj.webapp.utils;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.axis.utils.XMLUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.jxpath.Container;
import org.apache.commons.jxpath.JXPathContext;
import org.apache.commons.jxpath.XMLDocumentContainer;
import org.apache.commons.lang.StringUtils;
import org.jdom.Attribute;
import org.jdom.Element;
import org.jdom.input.DOMBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlUtil {

	private Map<String, Boolean> pathMap = new HashMap<String, Boolean>();
	private String iconPath = "../../../images/icon/";

	public String getXml2tree(String xml) throws Exception{
		//String path = "D:/temp/test.xml";

		Map<String, Object> json = new HashMap<String, Object>();

		InputStream is = IOUtils.toInputStream(xml);
        DOMBuilder domBuilder = new DOMBuilder();

			
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder;
        dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(is);
	
      
        Element el = domBuilder.build(doc).getRootElement();
        String name = el.getName();
        json.put("id",name);
        json.put("title",name);
        json.put("type", "path");
        json.put("path", name);
        json.put("hideCheckbox", true);
        json.put("expand", true);
     
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		addChildren(name, el.getChildren(), json, list);
		
		JSONArray ja = new JSONArray();
		ja.add(json);
		
		return ja.toString();
	}
	private void addChildren(String path, List<Element> list, Map<String, Object> parentObj, List<Map<String,Object>> children){
		
		if(list==null || list.size()<1){
			parentObj.put("icon", iconPath+"node.png");
			return;
		}
		
		parentObj.put("isFolder", true);
		
		for(Element el : list){
			String name = el.getName();
			String newPath = path + "/" + name;
			
			Map<String, Object> elObj = new HashMap<String, Object>();
			//System.out.println(el.getName() + " = " + el.getTextTrim());
			elObj.put("id",name);
			elObj.put("path", newPath);

	        String val = el.getTextTrim();
	        
	        if(StringUtils.isEmpty(val)){
	        	elObj.put("title",name);
	        	elObj.put("type", "path");
	        	elObj.put("hideCheckbox", true);
	        }else{
	        	elObj.put("title",name + " - " + val);
	        	elObj.put("type", "node");
	        }
	        
	        elObj.put("value", val);
	        
			if(pathMap.containsKey(newPath)){
				elObj.put("hideCheckbox", true);				
			}else{
				parentObj.put("expand", true);
			}
			
			pathMap.put(newPath, true);
			
			List<Map<String,Object>> elChildren = new ArrayList<Map<String,Object>>();
			List<Attribute> ats =  el.getAttributes();
			if(ats!=null){
				
				for(Attribute at : ats){
					Map<String, Object> attObj = new HashMap<String, Object>();
					String atName = at.getName();
					String attPath = newPath + "@" + atName;
					attObj.put("id", atName);
					attObj.put("title", atName + "-" + at.getValue());
					attObj.put("value", at.getValue());
					attObj.put("type", "attr");
					attObj.put("icon", iconPath+"attr.png");
					attObj.put("path", attPath);
					
					if(pathMap.containsKey(attPath)){
						attObj.put("hideCheckbox", true);				
					}else{
						elObj.put("expand", true);
					}
					
					pathMap.put(attPath, true);

					elChildren.add(attObj);
				}
				elObj.put("children", elChildren);
			}

			children.add(elObj);
			
			addChildren(newPath, el.getChildren(), elObj, elChildren);
		}
		
		parentObj.put("children", children);
	}
	
}
