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
<script type="text/javascript" src="/useeasy/auction/js/company/pmhbeian.js" language="javascript"></script>
<script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>
<title>宁波市在线同步拍卖交易平台</title>
<script type="text/javascript">   
window.onload = function(){       
	var oFCKeditor1 = new FCKeditor( 'befor.zgzfyj' ) ;
	oFCKeditor1.BasePath	="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor1.ToolbarSet = "Custom";
	oFCKeditor1.Height = 400;
	oFCKeditor1.ReplaceTextarea() ;

	var oFCKeditor2 = new FCKeditor( 'befor.pmggfyj' ) ;
	oFCKeditor2.BasePath ="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor2.ToolbarSet = "Custom";
	oFCKeditor2.Height = 400;
	oFCKeditor2.ReplaceTextarea() ;
	var oFCKeditor3 = new FCKeditor( 'befor.bdqd' ) ;
	oFCKeditor3.BasePath ="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor3.ToolbarSet = "Custom";
	oFCKeditor3.Height = 400;
	oFCKeditor3.ReplaceTextarea() ;
	var oFCKeditor4 = new FCKeditor( 'befor.spwj' ) ;
	oFCKeditor4.BasePath ="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor4.ToolbarSet = "Custom";
	oFCKeditor4.Height = 400;
	oFCKeditor4.ReplaceTextarea() ;
	var oFCKeditor5 = new FCKeditor( 'befor.tbgd' ) ;
	oFCKeditor5.BasePath ="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor5.ToolbarSet = "Custom";
	oFCKeditor5.Height = 400;
	oFCKeditor5.ReplaceTextarea() ;
};
</script>
</head>
<body>
b<!--container-->
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
			 <%@include file="/WEB-INF/pages/useeasy/auction/main/left.jsp" %>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
	  			<div class="tit">
  				<div class="l">拍卖公司工商前备案信息</div>
	  			<div class="r"></div>
	  			</div> 
	  		 					  
  			<form name="" action="itemManage_saveBefor" method="post"  >
  		 
	   		<input type="hidden" name="befor.pmh_id" value="<s:property value="#request.auctionFlag"/>"/>
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖会名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pmhName" id="companyName" maxlength="50" size="50" value="<s:property value="#request.auctionInfo.auctionName"/>"/>
               
              </td>
            </tr>
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖会地址:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pmhAddress" id="companyAddress" maxlength="50" size="50" value="<s:property value="#request.auctionInfo.auctionAddress"/>"/>
               
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖会时间:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pmhTime" id="companyLinker" maxlength="20" size="50" value="<s:property value="#request.auctionInfo.auctionStartTime"/>"/>
              	 
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">主要拍品:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pp" id="companyPhone" maxlength="50" size="50" value="<s:property value="#request.auctionInfo.auctionDescription"/>"/>
               
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">公告发布媒体:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.ggmt" id="companyTel" maxlength="50" size="50" value="<s:property value="#request.auctionInfo.companyTel"/>"/>
               
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">公告发布日期:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pubTime" id="companyPost" maxlength="50" size="50" value="<s:property value="#request.auctionInfo.companyPost"/>"/>
              	 
              </td>
            </tr>
           <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖标的展示地址:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.biaoAddress" id="companyPost" maxlength="50" size="50" value="<s:property value="#request.auctionInfo.companyPost"/>"/>
              	 
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖师姓名:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pmsName" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
               
              </td>
            </tr>
            
            
             <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">报备类型:</span></td>
              <td bgcolor="#FFFFFF">
                 <select name="befor.bbType">
                    <option value="1"> 法院</option>
                    <option value="0"> 工商</option>
                 </select>
               
              </td>
            </tr>
            
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖标的展示日期 :</span></td>
              <td bgcolor="#FFFFFF">
                 	<!--<input type="text" name="befor.biaoTime"   maxlength="50" size="20" value=""/>-->
               
              </td>
            </tr>
   
 
  
    
    
   
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖师证号:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.pmNumber" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
               
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">现场负责人姓名:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.fzrName" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
              	 
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖委托书份数:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.accountBook" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
              	 
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖委托金额:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.wtMoney" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
               
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">联系人:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.lxr" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
              	 
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">联系方式:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="befor.lxTel" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
               
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF" colspan="2"><span class="td_left">其他需要提供材料：</span></td>
              
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">  拍卖师资格证复印件:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="befor.zgzfyj" rows="20" cols="180" style="width:100%;height:200px"></textarea>
              </td>
            </tr> 
            <tr> 
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">  拍卖公告复印件:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="befor.pmggfyj" rows="20" cols="180" style="width:100%;height:200px"></textarea>
              </td>
            </tr> 
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">  拍卖标的清单:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="befor.bdqd" rows="20" cols="180" style="width:100%;height:200px"></textarea>
              </td>
            </tr> 
            <tr>   
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">  相关审批文件:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="befor.spwj" rows="20" cols="180" style="width:100%;height:200px"></textarea>
              </td>
            </tr> 
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">  竞买人须知及拍卖特别规定:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="befor.tbgd" rows="20" cols="180" style="width:100%;height:200px"></textarea>
              </td>
            </tr> 
              <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">填表企业名称:</span></td>
              <td bgcolor="#FFFFFF">
              	 <input type=text name="befor.qymc"/>
              </td>
            </tr> 
            <tr> 
            	<td align="center" colspan="2">
            		<input class="large_btn"  type="submit" value="确认提交 "   />
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
	 
</body>
</html>
