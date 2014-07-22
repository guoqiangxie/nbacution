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
<script type="text/javascript" src="useeasy/auction/js/register/register.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台--会员注册</title>

</head>
<body> 
		<div class="container">
			<div class="topnav">
				<div class="logo"></div>				 
			</div>
		</div>
		<center>
		   
		<div class="nav">
			<div class="line"></div>
			<div class="menu">
			
				<span class="text">欢迎您注册宁波市在线同步拍卖交易平台，以下信息请您慎重填写并牢记。</span>
			</div>
		</div>
		
		</center>
		
		<form name="" action="" method="post" enctype="multipart/form-data" >
			<div id="container">
				<fieldset>
					<legend>
						<b>&nbsp;&nbsp;注册信息</b><span>(&nbsp;请注意：带有<i>*</i>的项目必须填写&nbsp;)</span>
					</legend>
					<table>
						<tr>
							<th>
								<label for="userName">
									<i>*</i> 账号名：
								</label>
							</th>
							<td>
								<input type="text" id="usAccount" name="usAccount"  size="20" maxlength="20" onblur="checkAccountName();" /> <span style="color:red">账号名以字母开头，字母与数字长度应大于6位小于19位</span>
								<span style="display:none" id="name_err_fir" ><font color="red">（账号名以字母开头，字母与数字，_为合法输入）</font></span>
								<span style="display:none" id="name_err_sec"><font color="red">（该账号名已被使用）</font></span>
								<span style="display:none" id="name_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr>
						<tr>
							<th>
								<label for="password">
									<i>*</i> 登录密码：
								</label>
							</th>
							<td>
								<input type="password" id="usAccountPass" name="usAccountPass"  size="20" maxlength="20" onblur="checkAccountPass();"/>
								<span style="color:red">密码中要含有字母长度应大于6位小于20位</span>
								<span style="display:none" id="pass_err_fir" ><font color="red">（密码要含有字母大于6位为合法输入）</font></span>
								<span style="display:none" id="pass_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr>
						<tr>
							<th>
								<label for="rePass">
									<i>*</i> 确认密码：
								</label>
							</th>
							<td>
								<input type="password"  id="usConfirmPass"  name="usConfirmPass" size="20"  maxlength="20" onblur="checkConfirmAccountPass();"/>
							    <span style="color:red">密码中要含有字母长度应大于6位小于20位</span>
								<span style="display:none" id="passCon_err_fir" ><font color="red">（确认密码要含有字母大于6位为合法输入）</font></span>
								<span style="display:none" id="passCon_err_sec" ><font color="red">（确认密码与密码不一致）</font></span>
								<span style="display:none" id="passCon_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr> 
						<tr>
							<th>
								<label for="name">
									<i>*</i> 用户名：
								</label>
							</th>
							<td>
								<input type="text" id="userName" name="userName" maxlength="20" size="20"  onblur="checkUserName();"/>
								<span style="display:none" id="userName_err" ><font color="red">（以中文与字母为合法输入）</font></span>
								<span style="display:none" id="userName_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr> 
						<tr>
						  
							<td colspan="2">
								&nbsp;&nbsp;&nbsp;&nbsp; 
								&nbsp;&nbsp;&nbsp;&nbsp;
								 &nbsp;&nbsp;&nbsp;&nbsp; 
								&nbsp;&nbsp;&nbsp;&nbsp; 
								     &nbsp;<i><input type="radio" checked="checked" name="Card" value="1"  id="card1" onclick="javascript:$('#cardSelect').hide();" />身份证类型</i>
								     <i><input type="radio"   name="Card" value="2" id="card2"  onclick="javascript:$('#cardSelect').show();$('#identityCard_err').hide();"/>
								      其他证件类型 
								    <label id="cardSelect" style="display:none">
								      <select name="cardType">
								       
								        <option value="2">组织机构代码证</option>
								        <option value="3">护照号</option>
								        <option value="4">其他证件</option>
								      
								      
								      </select>
								   </label>
								     
								     </i>
								    
									
									
								 
							</td>
						</tr>	
						<tr>
							<th>
								<label for="name">
									<i>*</i> 证件号码：
								</label>
							</th>
							<td>
								<input type="text" id="identityCard" name="identityCard" maxlength="40" size="20" onblur="checkIdentityCard();"/>
								<span style="display:none" id="identityCard_err" ><font color="red">（以15位数字或18位数字（尾号可以为X））</font></span>
								<span style="display:none" id="identityCard_suc"><font color="blue">（可使用）</font></span>
							</td>
						 </tr> 
						 <tr>
							<th>
								<label>
								</label>
							</th>
							<td style="color:red">
								(该证件号码为审核用户身份时使用，请正确填写，不可修改)
							</td>
						</tr>
						<tr>
							<th>
								<label for="name">
									身份证影印件：
								</label>
							</th>
							<td>
								<input type="file" id="u_file" name="identityCardPic" />
								<input type=button value="上传 "  onclick="doUpload();"/>
								<div id="identityCardPic_Div" class="imgBorder_1" style="display:none">
								<img id="identityCardPic_Img" width="160" height="120"/>
								</div>
								<input type="hidden" id="customPicVal" name="customPicVal"/>
								<iframe id="uploadTarget" name="uploadTarget" style="display:none"></iframe>
																	
							</td>
						</tr> 
						<tr>
							<th>
								<label>
								</label>
							</th>
							<td style="color:red">
								(该证件为审核用户身份时使用，请上传身份证正面图片，不超2M，注册后不可修改)
							</td>
						</tr>
						<tr>
							<th>
								<label for="name">
									<i>*</i> 手机号码：
								</label>
							</th>
							<td>
								<input type="text" id="userPhone" name="userPhone" title="该手机号码为密码找回时使用，请正确填写"  size="20" maxlength="11" onblur="checkUserPhone();"/>
								<span style="display:none" id="userPhone_err" ><font color="red">（以11位数字）</font></span>
								<span style="display:none" id="userPhone_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr> 
						<tr>
							<th>
								<label>
								</label>
							</th>
							<td style="color:red">
								(该手机号码为密码找回时使用，请正确填写)
							</td>
						</tr>
						<tr>
							<th>
								<label for="name">
									固定电话：
								</label>
							</th>
							<td>
								<input type="text" name="userTel" id="userTel" size="20" maxlength="20" onblur="checkUserTel();"/>
								<span style="display:none" id="userTel_err" ><font color="red">(形式如:0574-12345678)</font></span>
								<span style="display:none" id="userTel_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr>
						<tr>
							<th>
								<label for="name">
									<i>*</i>E_mail：
								</label>
							</th>
							<td>
								<input type="text" id="userEmail" name="userEmail"  maxlength="50" size="20" onblur="checkUserEmail();"/>
								<span style="display:none" id="userEmail_err" ><font color="red">（形式如:xxx@xxx.com可包含特殊字符【_-】）</font></span>
								<span style="display:none" id="userEmail_suc"><font color="blue">（可使用）</font></span>
							</td>
						</tr>  
						<tr>
							<th>
								<label>
								</label>
							</th>
							<td style="color:red">
								(该邮箱为注册验证，用于激活账号，请正确填写)
							</td>
						</tr>	
						<tr>
							<th>
								<label for="name">
									<i>*</i>验证码：
								</label>
							</th>
							<td>
								<span><input name="validatecode" id="validatecode" class="input" maxlength="4" size="6" tabindex="3" onkeydown="if (event.keyCode==13) javascript:doLogin();"/></span>
								<img id="validationImage" title="换一张" src="" style="cursor:pointer;" />
							</td>
						</tr>			
					</table>
				</fieldset>
				<table>
					<tr>
						<td>
							<textarea name="agrContent" readonly="readonly" cols="96" rows="5" >
  亲爱的用户，欢迎您注册宁波市拍卖行业协会网络信息系统（网站）。您有意成为本系统的用户，必须签署本注册协议，以行使权利和履行义务。如您有任何疑问，请及时联系我们宁波市拍卖行业协会，电话:(0574)-87818288议内容如下：
  1、本“宁波拍卖平台”设有[注册]窗口，用户参与拍卖企业举行的现场与网络同步拍卖会，必须在“宁波拍卖平台”进行注册。
  2、用户可以在线注册，也可以到拍卖公司，在拍卖公司“导拍员”的指导下进行注册。
  3、注册时，必须填写真实的姓名、有效的身份证号或护照号、常用的手机号、电子邮件地址，并上传身份证明影印件。
  4、用户注册信息储存于“宁波拍卖平台”的竞买人数据库，成为用户进入“宁波拍卖平台”、浏览拍卖会信息、观摩直播的拍卖会、参与现场与网络同步拍卖会的前置条件。
  5、“宁波拍卖平台”对用户注册信息严格保密。
  6、为了保证拍卖会公开、公正、公平地进行，“宁波拍卖平台”发现用户注册信息失真、无效，拥有中止或暂停用户账户的权力。
  7、未经用户同意及确认之前，除非必须遵循国家法律法规的规定的义务，“宁波拍卖平台”不得将用户注册信息披露给第三方，或用于与“宁波拍卖平台”服务无关的用途。
  8、“宁波拍卖平台”有权对用户在“宁波拍卖平台”的注册登记、网上竞价、以及其它与“宁波拍卖平台”运行相关行为进行查阅。如果发现用户有违法违规嫌疑的，“宁波拍卖平台”有权向用户发出问询通知，要求用户作出解释，如果用户无法作出合理解释的，“宁波拍卖平台”有权立即停止用户登录“宁波拍卖平台”的资格。如果情况紧急，“宁波拍卖平台”有权立即停止用户登录“宁波拍卖平台”的资格。 
  9、宁波拍卖平台”保留在发现用户发布含有违反国家法律法规的信息情况下，立即删除该等信息，注销用户账户，终止双方法律关系，并视情况决定是否向有关部门举报的权利。
  10、“宁波拍卖平台”拥有向用户提供网络服务过程中所产生并储存于”宁波拍卖平台”服务器中的所有数据信息的所有权。“宁波拍卖平台”及其拥有者拥有“宁波拍卖平台”内容的著作权、网站域名权利、以及与“宁波拍卖平台”运行相关的一切商标、商业秘密、技术秘密等知识产权，未经“宁波拍卖平台”及其拥有者书面同意，任何人或用户均不得擅自对相关信息、内容、技术进行下载、复制、传输、改编、编辑、制作衍生作品、分发或公开展示，否则须承担相应的法律责任。
  11、“宁波拍卖平台”将尽最大努力保障“宁波拍卖平台”的正常运行，尽力避免服务中断或将中断时间限制在最短时间内，使得用户的网上竞价可以顺利进行。如因不可抗力、恶意攻击或“宁波拍卖平台”无法控制、无法预见的原因而使得“宁波拍卖平台”无法正常向用户提供服务、网上竞价无法完成、有关信息丢失等，“宁波拍卖平台”无须对此承担责任。如果因用户向“宁波拍卖平台”提供错误、不完整、不真实信息而造成用户不能正常使用“宁波拍卖平台”服务，并因此受损的，由用户自行承担一切后果。
  12、用户必须是具备完全民事行为能力的自然人，或者是具有法人主体资格的企业、公司或组织。用户提交本注册协议，即表示您已经阅读并同意接受和遵守拍卖公司制订的拍卖规则、拍卖特别规定、以及“宁波拍卖平台”的有关规定。同意接收来自“宁波拍卖平台”及拍卖企业所提供邮件、信息。
  13、用户不得超越其民事权利或行为能力范围从事交易，不得转让或出售在“宁波拍卖平台”注册的用户名、密码。如果用户个人信息发生变动，必须及时以书面文件形式通知“宁波拍卖平台”，凭合法有效证明向“宁波拍卖平台”申请更新注册信息。用户应申请变更而不申请，由此造成的一切后果由用户承担。如果用户不同意、不接受或不愿遵守“宁波拍卖平台”变更后的“宁波拍卖平台”有关规定、拍卖公司修改后的拍卖规则、拍卖特别规定，应当停止以“宁波拍卖平台”用户的身份登录“宁波拍卖平台”，终止与“宁波拍卖平台”的用户关系。
  14、用户必须遵守国家法律法规的规定，,不得在“宁波拍卖平台”上发布含有违反国家法律法规以及侵犯他人合法权益的信息，不得进行任何可能会对“宁波拍卖平台”及其运行造成损害、妨碍、干扰的行为，不得实施任何恶意攻击“宁波拍卖平台”的行为，不得实施或试图实施从“宁波拍卖平台”非法取得其他用户信息的行为。
  15、用户违反国家法律法规的规定，不仅在承担相应的刑事、行政法律责任，还应当赔偿“宁波拍卖平台”因此而遭受的所有损失，包括但不限于：任何直接和间接经济损失、精神损害赔偿、”宁波拍卖平台”因此遭受的第三方索赔或国家机关的处罚、为应对该等索赔和处罚及追究侵权者责任而支出的诉讼、仲裁、调查和聘请律师的合理费用。
  16、某一方违反本协议约定不承担义务的，承担违约责任，并向守约方支付违约金。本协议期间发生纠纷，首先通过协商方式解决，如果协商不成，主张权利的一方向宁波市仲裁委员会申请裁决。
  17、本协议在用户注册前，经由用户以在线提交的方式确认生效。</textarea>
						</td>
					</tr>
					<tr>
						<td align="middle" style="font-size:12px">
							<input type="checkbox" id="agreement"/>
							我同意《网络拍卖信息系统用户注册协议》
						</td>
						<td valign="top" class="desc">
						</td>
					</tr>
				</table>
				<div class="btn buttonWrapper" align="center">
					<img onclick="doSubmit();" style="cursor:pointer" src="useeasy/auction/images/register/register.gif" class="open2 prevbutton"/>
				</div>
			</div>
		</form>
	
	<script language="javascript" type="text/javascript">
		$("#validationImage").attr("src","validationCode_register");
	</script>
	
	<s:if test="#request.checkFlag == 1">
		<script language="javascript" type="text/javascript">
			$("#validatecode").val("");
			$("#validatecode").focus();
			alert("验证码码不正确！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 2">
		<script language="javascript" type="text/javascript">
			$("#u_file").focus();
			alert("请上传身份证图片！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 3">
		<script language="javascript" type="text/javascript">
			$("#usAccount").val("");
			$("#usAccount").focus();
			alert("账号已经存在！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 4">
		<script language="javascript" type="text/javascript">
			$("#identityCard").val("");
			$("#identityCard").focus();
			alert("身份证 已经存在！");
		</script>
	</s:if>
	
	<script language="javascript" type="text/javascript">
		function doChangePicArea(str){
			if(str == "-1"){
				$(".buttonWrapper").show();
				alert("文件上传失败！");
			}else if(str == "-2"){
				$(".buttonWrapper").show();
				alert("文件上传出现异常！");
			}else{
				$(".buttonWrapper").show();
				$("#customPicVal").val(str.substring(str.indexOf(",")+1));
				$("#identityCardPic_Div").show();
				$("#identityCardPic_Img").attr("src","<%=request.getContextPath()%>"+str.substring(0,str.indexOf(",")));
			}
		}
	</script>
	
	</body>	
</html>
