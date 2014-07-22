<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/main.css"	rel="stylesheet" type="text/css" />
 
<title>宁波市在线同步拍卖交易平台</title>
<script type="text/javascript">
   function hitCount(obj){
  
     $.post("businessAction_hitCount?id="+obj,null,null);
    // location.reload();
    location.href="businessAction_getIndex?id="+obj;
   }
  

</script>
</head>
<body> 
	<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<!--header-->
		<div class="header">
			
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
			
			<div class="search">
		 
			<table width="920" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="18"><img src="useeasy/auction/images/main/icon_s.gif" width="14" height="14" /></td>
					<td class="title">搜索类别</td>
					<td width="15">&nbsp;</td>
					<td><input type="radio" id="search_type_fir" name="auction_radio" value="1" checked="checked"/></td>
					<td>拍卖会</td>
					<td width="12">&nbsp;</td>
					<td><input type="radio" id="search_type_sec" name="auction_radio" value="2"/></td>
					<td>拍卖标的</td>
					<td width="10">&nbsp;</td>
					<td>拍卖公司：</td>
					<td>
						<select id="companyName_val" name="companyName" style="width:100pt">
							<s:if test="#request.companyFlag == 0">
							<option value="0" selected="selected"></option>
							<s:iterator value="#request.companyInfoDtoList" var="companyInfoDtoList">
								<option value="<s:property value="#companyInfoDtoList.id"/>"><s:property value="#companyInfoDtoList.companyName"/></option>
							</s:iterator>
							</s:if>
							<s:else>
								<option value="0" ></option>
								<s:iterator value="#request.companyInfoDtoList" var="companyInfoDtoListFir">
									<s:if test="#request.companyFlag == #companyInfoDtoListFir.id">
										<option value="<s:property value="#companyInfoDtoListFir.id"/>" selected="selected"><s:property value="#companyInfoDtoListFir.companyName"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="#companyInfoDtoListFir.id"/>"><s:property value="#companyInfoDtoListFir.companyName"/></option>
									</s:else>
								</s:iterator>
							</s:else>
						</select>
					</td> 
					<td width="10">&nbsp;</td>
					<td>标的类别：</td>
					<td>
						<select  id="seracher_val"  >
							<s:if test="#request.auctionType == 1">
							<option value="1" selected="selected" style="width:100px"></option>
							</s:if>
							<s:else>
							<option value="1" style="width:100px"></option>
							</s:else>
							<s:if test="#request.auctionType == 2">
							<option value="2" selected="selected">房地产</option>
							</s:if>
							<s:else>
							<option value="2">房地产</option>
							</s:else>
							<s:if test="#request.auctionType == 3">
							<option value="3" selected="selected">机动车</option>
							</s:if>
							<s:else>
							<option value="3">机动车</option>
							</s:else>
							<s:if test="#request.auctionType == 4">
							<option value="4" selected="selected">物资设备</option>
							</s:if>
							<s:else>
							<option value="4">物资设备</option>
							</s:else>
							<s:if test="#request.auctionType == 5">
							<option value="5" selected="selected">股权</option>
							</s:if>
							<s:else>
							<option value="5">股权</option>
							</s:else>
							<s:if test="#request.auctionType == 6">
							<option value="6" selected="selected">民品</option>
							</s:if>
							<s:else>
							<option value="6">民品</option>
							</s:else>
							<s:if test="#request.auctionType == 7">
							<option value="7" selected="selected">文物艺术品</option>
							</s:if>
							<s:else>
							<option value="7">文物艺术品</option>
							</s:else>
							<s:if test="#request.auctionType == 8">
							<option value="8" selected="selected">其他</option>
							</s:if>
							<s:else>
							<option value="8">其他</option>
							</s:else>
						</select>
					</td>
					<td width="10">&nbsp;</td>
					<td>关键字：</td>
					<td><input id="key_val" type="text" value="<s:property value="#request.key"/>"/></td>
					<td><a href="javascript:void(0);" onclick="doSearch();return false;"><img border="0" src="useeasy/auction/images/main/search_btn.gif"/></a></td>
				</tr>
			</table>
			</div>
			
			<div class="msg">
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=3  >
				<s:iterator value="#request.auctionInfoDtoListTop" var="auctionInfoDtoListTop">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoDtoListTop.id'/>&currentPage=1"><s:property value="#auctionInfoDtoListTop.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
				
		</div>
		<!--end header-->
		
		<!--banner-->
		
		<!--end banner-->
		
		<!--main-->
		<div class="main">
			
			
			<!--right-->
			<div id="right" class="right_s" >
				<div class="sidebar">
					
					<div class="title">
						<span class="text"><img src="/useeasy/auction/images/tit_pmzs.gif" /></span>
						<span class="more"></span>
					</div>
					
					<div class="wrap">
						<div class="inside min-height">
							<center>
						
							 <div> 
	    	<table class="infoList01" width="100%" >
                <tr>
                  <td>标题</td>
                   <td>标题图</td>
                  <td>访问次数</td>
               </tr>
               <s:iterator value="#request.list" var="list" status="flag" begin="0">
  
                <tr>
                      <td title="<s:property value="#list.title"/>"> 
                     <a href="businessAction_getIndex?id=<s:property value="#list.id"/>"  >
                      <s:if test="#list.title.length()>10">
                    <s:property value="#list.title.substring(0,10)"/>...
                     </s:if>
                     <s:else>
                         <s:property value="#list.title"/>
                    </s:else>          
                 </a>   
                      </td>
       
                      <td> 
                      <img onclick="hitCount(<s:property value='#list.id'/>)" src="<s:property value="#list.imgPath"/>" width="200" height="150" alt=" <s:property value="#list.title"/>"/>  
                     </td>  
                     <td><s:property value="#list.hitcount"/>  </td>
        
                   </tr>
            </s:iterator>
          </table>
          </div>
                  <pmh_tag:pageTag pageSize="${requestScope.pageSize}" gotoURI="businessAction_getIndexList"></pmh_tag:pageTag>               
              </center>  
		 </div>
							
						 
							
						</div> 
						<div class="bottom"></div>
					</div>
					
					
				</div>
				
				
				
			</div>
			<!--end right-->
		
		<!--end main-->
	<center>
		<!--link-->
		<jsp:include page="../main/link.jsp" flush="true"/>
		<!--submenu-->
		<jsp:include page="../main/submenu.jsp" flush="true"/>
		<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
 </center>	
</div>
</body>
</html>
