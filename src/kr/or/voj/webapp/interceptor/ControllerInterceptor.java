package kr.or.voj.webapp.interceptor;

import java.text.SimpleDateFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.HtmlUtils;


public class ControllerInterceptor extends HandlerInterceptorAdapter{	
	private String[] mbl = {"iPhone", "iPod", "BlackBerry", "Android", "Windows CE", "LG", "MOT", "SAMSUNG", "SonyEricsson"};

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	
		//serReq(request);
		checkMobile(request);
		return true;
	}

	private void serReq(HttpServletRequest request){
		Map<String, String> req = new CaseInsensitiveMap();
		for(String key : request.getParameterMap().keySet()){
			String value = request.getParameter(key);
			req.put(key, HtmlUtils.htmlEscape(value));
		}
		request.setAttribute("req", req);
		
		try {
			JSONObject js = new JSONObject();
			for(String key : request.getParameterMap().keySet()){
				String value = request.getParameter(key);
				js.put(key, HtmlUtils.htmlEscape(value));
			}
			request.setAttribute("reqJS", js);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	private void checkMobile(HttpServletRequest request){
		HttpSession session = request.getSession();
		boolean isMobile = false;

		//세션 초기화
		if(session.getAttribute("isMobile")==null){
			String userAgent = request.getHeader("user-agent");

			for(String ml : mbl){
				if(StringUtils.containsIgnoreCase(userAgent, ml) ){
					isMobile = true;
					break;
				}
			}
						
			session.setAttribute("isMobile", isMobile);
		}
		
		//모바일모드로 수동 변경 요청시 처리
		String mb = request.getParameter("mb");
		if(StringUtils.isNotEmpty(mb)){
			isMobile = StringUtils.equalsIgnoreCase(mb, "Y");
			
			session.setAttribute("isMobile", isMobile);
		}
		
		request.setAttribute("isMobile", session.getAttribute("isMobile"));
	}

}
