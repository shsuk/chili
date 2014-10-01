package kr.or.voj.quartz.job;

import java.io.File;

import org.apache.log4j.Logger;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ClassUtils;

public class MapperExecutor {
	private static final Logger logger = Logger.getLogger(MapperExecutor.class);

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int executeTransactional(MapperInfo xmInfo, File file) throws Exception {

		return executeNonTransactional(xmInfo, file);
	}
	public int execute(MapperInfo xmInfo, File file) throws Exception {

		if(xmInfo.isTransactional()){
			return executeTransactional(xmInfo, file);
		}else{
			return executeNonTransactional(xmInfo, file);
		}
	}
	
	public int executeNonTransactional(MapperInfo xmInfo, File file) throws Exception {
		
		Mapper mapper = (Mapper)ClassUtils.forName(xmInfo.getMapperAdapteClass(), ClassUtils.getDefaultClassLoader()).newInstance();
		
		mapper.setMapperInfo(xmInfo, file);
		return mapper.execute();
	}
}
