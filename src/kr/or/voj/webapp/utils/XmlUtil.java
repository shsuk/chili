package kr.or.voj.webapp.utils;

import java.io.File;
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

	public String test() throws Exception{
		String path = "D:/temp/dc1d4bd0-11ef-4b8c-b51a-d3fea736e4de.xml";
		


		Map<String, Object> json = new HashMap<String, Object>();
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder;
        dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(new File(path));
        DOMBuilder domBuilder = new DOMBuilder();
      
        Element el = domBuilder.build(doc).getRootElement();
        json.put("id",el.getName());
        json.put("title",el.getName());
        json.put("type", "path");
       
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		chi(el.getChildren(), json, list);
		
		JSONArray ja = new JSONArray();
		ja.add(json);
		
		return ja.toString();
	}
	private void chi(List<Element> list, Map<String, Object> json, List<Map<String,Object>> ja){
		String imgUrl = "../../../jquery/dynatree/doc/skin-custom/";
		
		if(list==null){
			return;
		}
		
		
		for(Element el : list){
			Map<String, Object> jo = new HashMap<String, Object>();
			//System.out.println(el.getName() + " = " + el.getTextTrim());
	        jo.put("id",el.getName());
	        String val = el.getTextTrim();
	        if(StringUtils.isEmpty(val)){
		        jo.put("title",el.getName());
				jo.put("type", "path");
	        }else{
		        jo.put("title",el.getName() + " - " + el.getTextTrim());
				jo.put("type", "node");
	        }
			
			List<Map<String,Object>> jaa = new ArrayList<Map<String,Object>>();
			List<Attribute> ats =  el.getAttributes();
			if(ats!=null){
				
				for(Attribute at : ats){
					Map<String, Object> joa = new HashMap<String, Object>();
					
					joa.put("id", at.getName());
					joa.put("title", at.getName() + "-" + at.getValue());
					joa.put("type", "attr");
					joa.put("icon", imgUrl+"folder_docs.gif");

					jaa.add(joa);
				}
				jo.put("children", jaa);
			}

			ja.add(jo);
			chi(el.getChildren(), jo, jaa);
		}
		json.put("children", ja);
	}
	
	public static String main()throws Exception {
		XmlUtil x = new XmlUtil();
		return x.test();
	}
}
