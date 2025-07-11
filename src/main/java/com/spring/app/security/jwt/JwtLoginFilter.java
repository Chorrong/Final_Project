		package com.spring.app.security.jwt;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.naming.AuthenticationNotSupportedException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.spring.app.auditLog.AuditLogService;
import com.spring.app.user.UserService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class JwtLoginFilter extends UsernamePasswordAuthenticationFilter {
	
	private AuthenticationManager authenticationManager;
	
	private JwtTokenManager jwtTokenManager;
	
	private AuditLogService auditLogService;
	
	@Autowired
	private UserService userService;
	
	public JwtLoginFilter(JwtTokenManager jwtTokenManager, AuthenticationManager authenticationManager, AuditLogService auditLogService) {
		this.authenticationManager=authenticationManager;
		this.jwtTokenManager=jwtTokenManager;
		this.auditLogService=auditLogService;
		this.setFilterProcessesUrl("/users/login");
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
		// TODO Auto-generated method stub
		// 사용자가 입력한 값 가져오기
		// 입력한 값과 DB에 저장된 값 비교
		request.getMethod();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String loginType = request.getParameter("loginType");
		
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);
		
		Authentication authentication = this.authenticationManager.authenticate(token);
		
		String role=authentication.getAuthorities().toString();
		
		if (loginType.equals("trainer") && !username.contains("T") && !username.equals("admin")) {
			throw new AuthenticationServiceException("트레이너 계정이 아닙니다.");
		}
		
		return authentication;
		
		
	}

	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
			Authentication authResult) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// 로그인 요청이 성공했으므로 토큰 생성
		String token = jwtTokenManager.createToken(authResult);
		Cookie cookie = new Cookie("accessToken", token);
		
		boolean isAuto = "true".equals(request.getParameter("auto"));

		cookie.setMaxAge(120);
		cookie.setPath("/");
		cookie.setHttpOnly(true);
		
		// 로그/감사 기록용
		String username = authResult.getName();
		
		try {
			auditLogService.log(
			        username,
			        "LOGIN_SUCCESS",
			        "USER",
			        username,
			        username.concat("이 로그인 성공"),
			        request
			    );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.addCookie(cookie);
		response.sendRedirect("/");
	}

	@Override
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException failed) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		// 로그/감사 기록용
		String username = request.getParameter("username");
		String ip ="";
		String userAgent="login";
		try {
			auditLogService.log(
					null,
			        "LOGIN_FAIL",
			        "USER",
			        "anonymous",
			        "anonymous이 " + username + "으로 로그인하려다 실패",
			        request
			    );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		String loginType = request.getParameter("loginType");
		
		if (loginType.equals("member")) {
			response.sendRedirect("/user/login/login?error=" +
				    URLEncoder.encode(failed.getMessage(), StandardCharsets.UTF_8));
			return;
		}
		
		response.sendRedirect("/user/login/trainerLogin?error=" +
			    URLEncoder.encode(failed.getMessage(), StandardCharsets.UTF_8));

	}

}
