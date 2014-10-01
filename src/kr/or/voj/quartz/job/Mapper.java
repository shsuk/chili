package kr.or.voj.quartz.job;

import java.io.File;

public interface Mapper {
	public void setMapperInfo(MapperInfo xmInfo, File file);
	public int execute() throws Exception;
}
