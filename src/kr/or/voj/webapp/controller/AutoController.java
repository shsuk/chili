package kr.or.voj.webapp.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.voj.webapp.processor.ProcessorServiceFactory;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class AutoController {
	protected static final Logger LOGGER = Logger.getLogger(AutoController.class);

	@RequestMapping(value = "{page}.sh")
	public ModelAndView autoMain(HttpServletRequest request, HttpServletResponse response, @PathVariable("page") String page) throws Exception {
		ModelAndView mv = new ModelAndView("main");
		page = page.replace('_', '/');
		mv.addObject("IMPORT_PATH", page);
		return mv;
	}
	@RequestMapping(value = "{mainPath}/{page}.sh")
	public ModelAndView autoMain2(HttpServletRequest request, HttpServletResponse response, @PathVariable("mainPath") String mainPath, @PathVariable("page") String page) throws Exception {
		ModelAndView mv = new ModelAndView(mainPath + "/main");
		page = page.replace('_', '/');
		mv.addObject("IMPORT_PATH", mainPath + "/" + page);
		return mv;
	}
	@RequestMapping(value = "{mainPath1}/{mainPath2}/{page}.sh")
	public ModelAndView autoMain3(HttpServletRequest request, HttpServletResponse response, @PathVariable("mainPath1") String mainPath1, @PathVariable("mainPath2") String mainPath2, @PathVariable("page") String page) throws Exception {
		String mainPath = mainPath1 + "/" + mainPath2;
		
		ModelAndView mv = new ModelAndView(mainPath + "/main");
		page = page.replace('_', '/');
		mv.addObject("IMPORT_PATH", mainPath + "/" + page);
		return mv;
	}
	@RequestMapping(value = "{system}/{page}/bit.sh")
	public ModelAndView auto(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("page") String page) throws Exception {
		ModelAndView mv = new ModelAndView(system + "/" + page);
		mv.addObject("isForm", false);
		return mv;
	}
	@RequestMapping(value = "{system}/{subSystem}/{page}/bit.sh")
	public ModelAndView auto(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("subSystem") String subSystem, @PathVariable("page") String page) throws Exception {
		ModelAndView mv = new ModelAndView(system + "/" + subSystem + "/" + page);
		mv.addObject("isForm", false);
		return mv;
	}
	@RequestMapping(value = "{system}/{page}/form.sh")
	public ModelAndView autoForm(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("page") String page) throws Exception {
		ModelAndView mv = new ModelAndView(system + "/" + page);
		mv.addObject("isForm", true);
		return mv;
	}
	@RequestMapping(value = "{system}/{subSystem}/{page}/form.sh")
	public ModelAndView autoForm(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("subSystem") String subSystem, @PathVariable("page") String page) throws Exception {
		ModelAndView mv = new ModelAndView(system + "/" + subSystem + "/" + page);
		mv.addObject("isForm", true);
		return mv;
	}
	@RequestMapping(value = "dl.sh")
	public ModelAndView dowonload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<String> processorList = new ArrayList<String>();
		processorList.add("mybatis");
		processorList.add("download");
		
		ProcessorServiceFactory.executeMainTransaction(processorList, new CaseInsensitiveMap(), "attach", "dowonload", null, request, response);
			
		
		return null;
	}
}
