package kr.or.voj.webapp.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.voj.webapp.processor.ProcessorServiceFactory;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.util.FieldUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.InternalResourceViewResolver;



@Controller
public class AutoController {
	protected static final Logger LOGGER = Logger.getLogger(AutoController.class);

	@RequestMapping(value = "_{mainPath}/_{uiId}.sh")
	public ModelAndView autoMain(HttpServletRequest request, HttpServletResponse response, @PathVariable("mainPath") String mainPath, @PathVariable("uiId") String uiId) throws Exception {
		mainPath = mainPath.replace('_', '/');

		ModelAndView mv = new ModelAndView(mainPath + "/main");
		mv.addObject("UI_ID", uiId);
		return mv;
	}
	@RequestMapping(value = "piece/_{uiId}.sh")
	public ModelAndView autoPiece(HttpServletRequest request, HttpServletResponse response, @PathVariable("uiId") String uiId) throws Exception {
		ModelAndView mv = new ModelAndView("at/piece");
		mv.addObject("UI_ID", uiId);
		return mv;
	}
	@RequestMapping(value = "unit/_{uiId}.sh")
	public ModelAndView autoUnit(HttpServletRequest request, HttpServletResponse response, @PathVariable("uiId") String uiId) throws Exception {
		ModelAndView mv = new ModelAndView("at/unit");
		mv.addObject("UI_ID", uiId);
		return mv;
	}

	@RequestMapping(value = "_{mainPath}/{page}.sh")
	public ModelAndView mainPage(HttpServletRequest request, HttpServletResponse response, @PathVariable("mainPath") String mainPath, @PathVariable("page") String page) throws Exception {
		mainPath = mainPath.replace('_', '/');
		ModelAndView mv = new ModelAndView(mainPath + "/main");
		mv.addObject("IMPORT_PAGE", "../" + mainPath + "/" + page.replace('_', '/'));
		return mv;
	}
	@RequestMapping(value = "{path}/{page}.sh")
	public ModelAndView page(HttpServletRequest request, HttpServletResponse response, @PathVariable("path") String path, @PathVariable("page") String page) throws Exception {
		path = path.replace('_', '/');
		ModelAndView mv = new ModelAndView(path + "/" + page);
		return mv;
	}

	/**
	 * 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "dl.sh")
	public ModelAndView dowonload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<String> processorList = new ArrayList<String>();
		processorList.add("mybatis");
		processorList.add("download");
		
		ProcessorServiceFactory.executeMainTransaction(processorList, new CaseInsensitiveMap(), "attach", "dowonload", null, request, response);
			
		
		return null;
	}
}
