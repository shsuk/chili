package kr.or.voj.webapp.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;



@Controller
public class AutoController {
	protected static final Logger LOGGER = Logger.getLogger(AutoController.class);

	@RequestMapping(value = "{system}/atm.sh")
	public ModelAndView autoMain(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system) throws Exception {
		return new ModelAndView(system + "/main");
	}
	@RequestMapping(value = "{system}/{subSystem}/atm.sh")
	public ModelAndView autoMain2(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("subSystem") String subSystem) throws Exception {
		return new ModelAndView(system + "/" + subSystem + "/main");
	}
	@RequestMapping(value = "/{system}/{page}/at.sh")
	public ModelAndView auto(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("page") String page) throws Exception {
		return new ModelAndView(system + "/" + page);
	}
	@RequestMapping(value = "/{system}/{subSystem}/{page}/at.sh")
	public ModelAndView auto(HttpServletRequest request, HttpServletResponse response, @PathVariable("system") String system, @PathVariable("subSystem") String subSystem, @PathVariable("page") String page) throws Exception {
		return new ModelAndView(system + "/" + subSystem + "/" + page);
	}
}
