package kr.or.voj.webapp.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.voj.webapp.processor.ProcessorServiceFactory;
import kr.or.voj.webapp.utils.CookieUtils;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class AutoController {
	protected static final Logger LOGGER = Logger.getLogger(AutoController.class);

	@RequestMapping(value = "-{tplPath}/-{uiId}.sh")
	public ModelAndView autoMain(HttpServletRequest request, HttpServletResponse response, @PathVariable("tplPath") String tplPath, @PathVariable("uiId") String uiId) throws Exception {
		tplPath = tplPath.replace('-', '/');
		//response.setHeader("Cache-Control", "no-store");
		//response.setHeader("Pragma", "no-cache");
		
		//response.setHeader("X-Frame-Option", "DENY");
		ModelAndView mv = new ModelAndView("main");
		mv.addObject("UI_TPL", tplPath);
		mv.addObject("UI_ID", uiId);
		return mv;
	}
	@RequestMapping(value = "piece/-{uiId}-{type}.sh")
	public ModelAndView autoPiece(HttpServletRequest request, HttpServletResponse response, @PathVariable("uiId") String uiId, @PathVariable("type") String type) throws Exception {
		ModelAndView mv = new ModelAndView("at/piece");
		mv.addObject("UI_ID", uiId);
		mv.addObject("PIECE_TYPE", type);
		return mv;
	}
	
	@RequestMapping(value = "-{tplPath}/{page}.sh")
	public ModelAndView mainPage(HttpServletRequest request, HttpServletResponse response, @PathVariable("tplPath") String tplPath, @PathVariable("page") String page) throws Exception {
		tplPath = tplPath.replace('-', '/');

		ModelAndView mv = new ModelAndView("main");
		mv.addObject("UI_TPL", tplPath);
		mv.addObject("IMPORT_PAGE", tplPath + "/../" + page.replace('-', '/'));
		return mv;
	}
	@RequestMapping(value = "{path}/{page}.sh")
	public ModelAndView page(HttpServletRequest request, HttpServletResponse response, @PathVariable("path") String path, @PathVariable("page") String page) throws Exception {
		path = path + "/"+ page;
		path = path.replace('-', '/');
		ModelAndView mv = new ModelAndView(path);
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
