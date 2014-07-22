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
<script type="text/javascript" src="useeasy/auction/js/company/pmhbeian.js" language="javascript"></script>
<script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>
<title>宁波市在线同步拍卖交易平台</title>

</head>
<body>
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<div class="header">
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
		
			<div class="msg">
        	<%-- 滚动栏 --%>
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=4  >
				<s:iterator value="auctionTopInfo_list" var="aucTopInfo_list">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="###" onclick="alert(<s:property value="#aucTopInfo_list.id"/>)"><s:property value="#aucTopInfo_list.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
		</div>
		<!--end header-->	
		
		<!--main-->
		<div class="main">
			<!--left-->
			<div class="left">
			<ul>
				<li><a href="auctionManage_index?currentPage=1">拍卖会管理</a></li>
				<li><a href="companyPayment_index?currentPage=1">收支明细</a></li>
				<li><a href="companyManage_edit" >拍卖公司注册信息</a></li>
				<!--<li><a onclick="companyMessageAction();" href="#">留言管理</a></li> class="current"-->
				<li><a href="companyBulletin_index?currentPage=1">拍卖公告管理</a></li>
				<li><a href="auctionManage_fileResource">相关资料</a></li>
				<li><a href="companyManage_passEdit">密码修改</a></li>
				<li><a href="auctionLogin_frameLogout">退出登录</a></li>
			</ul>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
	  			<div class="tit">
  				<div class="l">拍卖活动后备案信息</div>
	  			<div class="r"></div>
	  			</div> 
	  			 						  
  			<form name="" action="itemManage_saveAfter" method="post" >
	   		<input type="hidden" name="pmh_id" value="<s:property value="#request.auctionFlag"/>"/>
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		  <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">报备时间:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
         
              	 
              	<input type="text" name="after.createTime" id=""   />
              </td>
            </tr>
      
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖会名称:</span></td>
              <td bgcolor="#FFFFFF" colspan=7>
              	<input type="text" name="after.pmhName" id="" maxlength="50" size="50" value=" "/>
               
              </td>
            </tr>
          	 
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖会时间:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="after.pmhTime" id="" maxlength="20" size="20" value=""/>
              	 
              </td>
              
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">成交数:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="after.cheJiao" id="" maxlength="50" size="20" value=" "/>
               
              </td>
               <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">成交额:</span></td>
               <td bgcolor="#FFFFFF">
              	<input type="text" name="after.chenJiaoE" id="" maxlength="50" size="20" value=" "/>
               
              </td>
             
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">竟买人数:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="after.jinMaiRen" id="" maxlength="50" size="20" value=" "/>
               
              </td>
            
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">流拍数:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="after.liuPai"   maxlength="50" size="20" value=" "/>
              	 
              </td>
             
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">撤拍数:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="after.chePai"  maxlength="50" size="20" value=" "/>
              	 
              </td>
               </tr>
               <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">拍卖会现场情况:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
              	<input type="text" name="after.xianChangQk"   maxlength="50" size="20" value=" "/>
              </td>
            </tr>
             
              <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">1 拍卖标的是否均为他人委拖:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
                 是
              	<input type="radio" name="after.taRenWeiTuo" id=""  value="0"/>否
              	<input type="radio" name="after.taRenWeiTuo" id=""  value="1"/>
              </td>
            </tr>
             
              <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">2是否公布工商行政管理机关举报电话:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
              	   是
              	<input type="radio" name="after.pubGongHangTel" id=""  value="0"/>否
              	<input type="radio" name="after.pubGongHangTel" id=""  value="1"/>
              </td>
            </tr>
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">3成交拍卖标的是否均经过拍卖竟价程序:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
              	   是
              	<input type="radio" name="after.jingJiaChenXun" id=""  value="0"/>否
              	<input type="radio" name="after.jingJiaChenXun" id=""  value="1"/>
              </td>
            </tr>
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">4委托人是否亲自或委托他人参与竟买:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
                 是
              	<input type="radio" name="after.weiTuoJinMai" id=""  value="0"/>否
              	<input type="radio" name="after.weiTuoJinMai" id=""  value="1"/>
              </td>
            </tr>
              <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left"> 5是否在拍卖前泄露需要保密的拍卖标的底价:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
                 是
              	<input type="radio" name="after.diJiaXieLou" id=""  value="0"/>否
              	<input type="radio" name="after.diJiaXieLou" id=""  value="1"/>
              </td>
            </tr>
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left"> 6拍卖企业是否与竟买人私下定价:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
              	   是
              	<input type="radio" name="after.shiXiaDingJia" id=""  value="0"/>否
              	<input type="radio" name="after.shiXiaDingJia" id=""  value="1"/>
              </td>
            </tr>
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan=3><span class="td_left">7竟买人间有无联合压价、约定价格现像:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
              	   是
              	<input type="radio" name="after.yaJia" id=""  value="0"/>否
              	<input type="radio" name="after.yaJia" id=""  value="1"/>
              </td>
            </tr>
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan="3"><span class="td_left"> 8竟买人间有无欺行霸市的现象       :</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
                                        是
              	<input type="radio" name="after.qiHangBaShi" id=""  value="0"/>否
              	<input type="radio" name="after.qiHangBaShi" id=""  value="1"/>
              </td>
            </tr>
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan="3"><span class="td_left" >  9拍卖会有无发生投诉等情况:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
                                           是
              	<input type="radio" name="after.touShu" id=""  value="0"/>否
              	<input type="radio" name="after.touShu" id=""  value="0"/>
              </td>
            </tr>
              <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan="3"><span class="td_left" >  其他:</span></td>
               <td bgcolor="#FFFFFF" colspan=4>
                                        <textarea rows="10" cols="20" name="after.other"></textarea>
              </td>
            </tr>
            <tr>
            	<td align="center" colspan="8">
            		<input class="large_btn"  type="submit" value="报备 "   />
				</td>
            </tr>
          	
          	</table>
          	</form>
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
	<script language="javascript" type="text/javascript">
		function doChangePicArea(str){
			if(str == "-1"){
				$(".large_btn").show();
				alert("文件上传失败！");
			}else if(str == "-2"){
				$(".large_btn").show();
				alert("文件上传出现异常！");
			}else{
				$(".large_btn").show();
				$("#customPicVal").val(str.substring(str.indexOf(",")+1));
				$("#img_sp_fir").hide();
				$("#img_sp_sec").hide();
				$("#identityCardPic_Img").attr("src","<%=request.getContextPath()%>"+str.substring(0,str.indexOf(",")));
			}
		}
	</script>
</body>
</html>
