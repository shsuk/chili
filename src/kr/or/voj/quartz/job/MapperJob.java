package kr.or.voj.quartz.job;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import kr.or.voj.webapp.processor.MyBatisProcessor;
import kr.or.voj.webapp.processor.ProcessorServiceFactory;
import net.sf.json.JSONArray;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jdom.Attribute;
import org.jdom.Element;
import org.jdom.input.DOMBuilder;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;

import com.ibm.icu.text.SimpleDateFormat;

public class MapperJob extends QuartzJobBean {
	private static final Logger logger = Logger.getLogger(MapperJob.class);
	private MapperExecutor mapperExecutor;
	private static boolean isRun = false;
	
	public void setMapperExecutor(MapperExecutor mapperExecutor) {
		this.mapperExecutor = mapperExecutor;
	}
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		
		if(isRun) {
			return;
		}
		isRun = true;
		
		try {
			@SuppressWarnings("unchecked")
			Map<String, List<Map<String, Object>>> rtn = (Map<String, List<Map<String, Object>>>)ProcessorServiceFactory.executeQuery(MyBatisProcessor.PATH_MAPPER, "mapper", new CaseInsensitiveMap());
			
			for(Map<String, Object> row : rtn.get("rows")){
				MapperInfo xmlMapperInfo = new MapperInfo(row);
				
				run(xmlMapperInfo);					
			}
		} catch (Exception e) {
			logger.error("XML Mapper Error", e);
		}finally{
			isRun = false;
		}
	}
	/**
	 * 처리대상 파일을 체크한다.
	 */
	private void run(MapperInfo xmInfo) {
		String mapperId = xmInfo.getMapperId();
		File file = new File(xmInfo.getSourcePath());
		File[] list = file.listFiles();
		boolean isRun = false;
		SimpleDateFormat dateFormater = new SimpleDateFormat("yyyyMMdd-HHmmss");
		
		CaseInsensitiveMap param = new CaseInsensitiveMap();
		param.put("mapper_id", mapperId);
		
		writeDbLog(MyBatisProcessor.PATH_MAPPER, "mapperCheck", param, null);
		
		
		for(File f : list){
			try {
				if(!f.isFile()){
					continue;
				}
	 			if(!isRun){
					logger.info("Mapper [" + mapperId + "] : Start");
					
					writeDbLog(MyBatisProcessor.PATH_MAPPER, "mapperStart", param, null);
					
					isRun = true;
	 			}
				logger.info("Mapper [" + mapperId + "] : File = " + f.getName());
				//XML 파일을 처리한다
				prpcess(xmInfo, f);
				
				try{
					f.renameTo(new File(xmInfo.getSucessPath(), dateFormater.format(new Date()) + f.getName()));
				} catch (Exception e2) {
					writeDbLog(MyBatisProcessor.PATH_MAPPER, "mapperError", param, e2);
					logger.error("Mapper [" + mapperId + "] : Error = 처리 후 파일 이동 중 오류 발생", e2);
				}
			} catch (Exception e) {
				writeDbLog(MyBatisProcessor.PATH_MAPPER, "mapperError", param, e);
				logger.error("Mapper [Error] : " + mapperId, e);
				try {
					f.renameTo(new File(xmInfo.getErrorPath(), dateFormater.format(new Date()) + f.getName()));
				} catch (Exception e2) {
					writeDbLog(MyBatisProcessor.PATH_MAPPER, "mapperError", param, e);
					logger.error("Mapper [" + mapperId + "] : Error", e2);
				}
			}
		}
		
		if(isRun){
			logger.info("Mapper [" + mapperId + "] : End ");
			writeDbLog(MyBatisProcessor.PATH_MAPPER, "mapperEnd", param, null);
		}
	}
	
	private void writeDbLog(String queryPath, String action, CaseInsensitiveMap param, Exception e) {
		if(e!=null){
			StringBuffer sb = new StringBuffer(e.toString());
			StackTraceElement[] els = e.getStackTrace();
			
			for(int i=0; i<els.length && i<40; i++){
				sb.append(els[i].toString()).append('\n');
			}
			
			param.put("process_message", StringUtils.substring(sb.toString(),0, 4000));
		}
		
		try {
			ProcessorServiceFactory.executeQuery(queryPath, action, param);
		} catch (Exception e1) {
			logger.error("Mapper : Log Write Error", e1);
		}
		
	}
	/**
	 * 파일을 처리한다
	 */
	private void prpcess(MapperInfo xmInfo, File file) throws Exception{
		int count = mapperExecutor.execute(xmInfo, file);
		logger.info("Mapper [" + xmInfo.getMapperId() + "] : Change Count = " + count);			
	}

}
