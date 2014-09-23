package kr.or.voj.webapp.processor;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class AttachProcessor implements ProcessorService{

	private static final SimpleDateFormat YYYYMM_FORMAT = new SimpleDateFormat("yyyy_MM/dd");

	public  Object execute(ProcessorParam processorParam) throws Exception {
		CaseInsensitiveMap params = processorParam.getParams();
		HttpServletRequest request = (HttpServletRequest)processorParam.getRequest();

		Map<String, List<Map<String, Object>>> result = new HashMap<String, List<Map<String,Object>>>();

		
		if (! (request instanceof MultipartHttpServletRequest)) {
			return null;
		}
		MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
		
		Iterator<String> it = mRequest.getFileNames();
		
		while (it.hasNext()) {
			String attachId = it.next();//파일콘트롤명
			String attachGroupFieldName = StringUtils.substringBeforeLast(attachId, "_file");
			String attachGroupId = mRequest.getParameter(attachGroupFieldName);
			List<MultipartFile> files = mRequest.getFiles(attachId);
			
			for(MultipartFile file : files){
				long fileSize = file.getSize();
				String fileName = file.getOriginalFilename();
				
				if(fileSize<1) continue;

				String ext = StringUtils.substringAfterLast(fileName, ".");
				ext = ext!=null ? ext.toLowerCase() : "";

				InputStream is = file.getInputStream();
				//파일을 저장소에 파일을 저장한다.
				saveFile(result, attachId, attachGroupId, is, fileName, fileSize);
			}
		}
		
		List<Map<String,Object>> attchFileList = new ArrayList<Map<String,Object>>();
		
		for(String key : result.keySet()){
			attchFileList.addAll(result.get(key));
		}
		
		params.put("_atach_all", attchFileList);
		params.put("_atach", result);
		
		ProcessorServiceFactory.executeQuery("attach", "insert", params);
		return null;
	}

	private void saveFile(Map<String, List<Map<String, Object>>> result, String attachId, String attachGroupId, InputStream is, String fileName, long fileSize) throws Exception{
		
		String ext = StringUtils.substringAfterLast(fileName, ".");
		ext = ext!=null ? ext.toLowerCase() : "";


		List<Map<String, Object>> attchFileList = result.get(attachId);
		
		if(attchFileList==null){
			attchFileList = new ArrayList<Map<String,Object>>();
			result.put(attachId, attchFileList);
		}
		
		String fileId = UUID.randomUUID().toString();
		Map<String, Object> fileMap = new HashMap<String, Object>();
		//파일저장 TODO
		String filePath = ProcessorServiceFactory.getRepositoryPath() + YYYYMM_FORMAT.format(new Date());
		File f = new File(filePath);
		
		if(!f.exists()){
			f.mkdirs();
		}
		filePath += "/" + fileId;
		FileOutputStream fos = null;
		
		try {
			fos = new FileOutputStream(new File(filePath));
			IOUtils.copyLarge(is, fos);
		}finally{
			if(fos!=null){
				try {
					fos.close();
				} catch (Exception e2) {
					// TODO: handle exception
				}
			}
		}
		fileMap.put("fieldId", attachId);
		fileMap.put("id", fileId);
		fileMap.put("group_id", attachGroupId);
		fileMap.put("name", fileName);
		fileMap.put("path", filePath);
		fileMap.put("ext", ext);
		fileMap.put("size", fileSize);
		
		
		attchFileList.add(fileMap);
		
	}

	
}
