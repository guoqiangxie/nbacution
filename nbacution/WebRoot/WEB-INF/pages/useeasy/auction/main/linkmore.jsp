<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page contentType="text/html; charset=utf-8"%>
	<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="keywords" content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
		<meta http-equiv="discription" content="网络拍卖信息系统" />
		<link href="useeasy/auction/css/main/layout.css" rel="stylesheet"
			type="text/css" />
		<link href="useeasy/auction/css/main/public.css" rel="stylesheet"
			type="text/css" />
		<link href="useeasy/auction/css/main/third.css" rel="stylesheet"
			type="text/css" />

		<title>宁波市在线同步拍卖交易平台</title>
		<script type="text/javascript" language="javascript">
$(document).ready(function(){
	$("#img_show").click(function(){
		var urlVal = $("#img_show").attr("src");
		window.showModalDialog("auctionIndex_imageDetail?imgUrl="+urlVal, "","dialogWidth=800px;dialogHeight=600px"); 
	});
});
function doShowImg(str){
	$("#img_show").attr("src",str);
}

</script>
	</head>
	<body>
		<!--container-->
		<div class="container">
			<!--topnav-->
			<jsp:include page="../main/topLogin.jsp" flush="true" />
			<!--end topnav-->

			<!--header-->
			<div class="header">

				<!--mainnav-->
				<div class="mainnav">
					<jsp:include page="../main/menu.jsp" flush="true" />
				</div>
				<!--end mainnav-->

				<div class="msg">
					<MARQUEE onmouseover=this.stop() onmouseout=this.start()
						scrollAmount=3>
					<s:iterator value="#request.auctionInfoDtoListTop"
						var="auctionInfoDtoListTop">
						<img src="useeasy/auction/images/main/icon06.gif" width="11"
							height="11" />
						<a target="_blank"
							href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoDtoListTop.id'/>&currentPage=1"><s:property
								value="#auctionInfoDtoListTop.auctionName" />
						</a>
					</s:iterator>
					</MARQUEE>
				</div>

			</div>
			<!--end header-->

			<div class="sale">


				<div class="info">

					<div>
						<div class="top-min-height">
							<div class="list">
								<ul>
									<li>
										<p class="item1">
											 <a href="www.zjaic.gov.cn/zjaic">中国拍卖行业协会 浙江省工商行政管理局</a>|
											
											<a href="www.zjwh.gov.cn/">浙江省商务厅 浙江省文化厅 </a> |
											<a href="gzw.zj.gov.cn/">浙江省国有资产监督管理委员会 </a> |
											<a href="www.rmfysszc.gov.cn">人民法院诉讼资产网 </a>|
											<a href="www.zjpmw.com">浙江拍卖在线 </a> |
											<a href="www.nbaic.gov.cn">宁波市工商行政管理局 </a> |
											<a href="www.nbgz.gov.cn">宁波市国资委  </a> |
											<a href="www.bidding.gov.cn">宁波市公共资源交易中心</a> |
											<a href="www.nblr.gov.cn"> 宁波市国土资源局 </a> |
											<a href="www.nb-trade.gov.cn">宁波市贸易局 </a> |
											<a href="www.nbcourt.org">宁波市中级人民法院</a> |
											<a href="www.nbjdfy.gov.cn">宁波市江东区人民法院 </a> |
											<a href="www.nbjbfy.gov.cn">宁波市江北区人民法院</a> |
											<a href="www.nbhsfy.gov.cn">宁波市海曙区人民法院 </a> |
											<a href="www.zhfy.gov.cn">宁波市镇海区人民法院</a> |
											<a href="www.nbblfy.gov.cn">宁波市北仑区人民法院 </a> |
											<a href="www.nbyzfy.gov.cn">宁波市鄞州区人民法院</a> |
											<a href="www.yyfy.gov.cn">余姚市人民法院 </a> |
											<a href="fayuan.cixi.gov.cn">慈溪市人民法院</a> |
											<a href="www.fhfy.gov.cn">奉化市人民法院 </a> |
											<a href="www.fhfy.gov.cn">宁海县人民法院</a> |
                                            <a href="#"> 浙江法院网 浙江省财政厅</a> 
                                    </p>
										 
									</li>
                            	</ul>

							</div>
						</div>
						<form action="" method="post">
							<div class="btn">

							</div>
						</form>
					</div>
				</div>



			</div>
			<!--end main-->

			<!--footer-->
			<jsp:include page="../main/footer.jsp" flush="true" />
		</div>



	</body>
</html>