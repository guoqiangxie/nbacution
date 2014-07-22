<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
<link href="useeasy/auction/css/register/signup.css"	rel="stylesheet" type="text/css" />
<title>宁波市在线同步拍卖交易平台--会员注册</title>

</head>
<body> 
		<div class="container">
			<div class="topnav">
				<div class="logo"></div>				 
			</div>
		</div>
		<div class="nav">
			<div class="line"></div>
			<div class="menu">
				<span class="text">欢迎您注册宁波市在线同步拍卖交易平台。</span>
			</div>
		</div>
		
		
		<div id="container">
				<fieldset>
					<legend>
						<b>&nbsp;&nbsp;注册信息</b>
					</legend>
					<table>
						<tr>
							<th>
								<label>
								</label>
							</th>
							<td style="color:red">
								<span id="error_fir" style="display:none">
								对不起！账号激活失败，您可以登录网络拍卖系统重新注册并及时激活。
								</span>
								<span id="error_sec" style="display:none">
								账号已经激活，您可以登录网络拍卖系统。
								</span>
								<span id="error_thi" style="display:none">
								账号已经过期，如果需要激活请您联系上拍协管理员。
								</span>
								<br/>
								<span><a href="http://wangpai.staa.com.cn" target="_self">http://wangpai.staa.com.cn</a></span>
							</td>
						</tr>
					</table>
				</fieldset>
				
				
			</div>
		
		<s:if test="#request.checkFlag == 1">
			<script language="javascript" type="text/javascript">
				$("#error_fir").show();
				$("#error_sec").hide();
				$("#error_thi").hide();
			</script>
		</s:if>
		<s:if test="#request.checkFlag == 2">
			<script language="javascript" type="text/javascript">
				$("#error_fir").hide();
				$("#error_sec").show();
				$("#error_thi").hide();
			</script>
		</s:if>
		<s:if test="#request.checkFlag == 3">
			<script language="javascript" type="text/javascript">
				$("#error_fir").hide();
				$("#error_sec").hide();
				$("#error_thi").show();
			</script>
		</s:if>
	
	</body>	
</html>
