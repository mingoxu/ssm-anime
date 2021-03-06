package cn.edu.hstc.core.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 后台管理员系统过滤器
 * @author Runming
 *
 */
public class AdminFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
			throws IOException, ServletException {
		   HttpServletRequest req = (HttpServletRequest) request;
		   HttpServletResponse res = (HttpServletResponse) response;
		   StringBuffer url = req.getRequestURL();
		   if((url.indexOf("bgsystem")>0)&&(url.indexOf("jsp")>0)) {   //判断地址中是否有jsp
			  /*req.getRequestDispatcher("/toFrontIndex.action").forward(req, res);*/
			  res.sendRedirect(req.getContextPath());
			  return;
		   }else {
			   filterChain.doFilter(request, response);
		   }
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
}
