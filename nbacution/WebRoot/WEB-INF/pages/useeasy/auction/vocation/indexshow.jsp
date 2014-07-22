<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.useeasy.auction.bean.AuctionInfoIndexDto"%>
<%@page import="com.useeasy.auction.bean.AuctionInfo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.titless{ width:221px; white-space:nowrap; word-break:keep-all; overflow:hidden; text-overflow:ellipsis;}
.titless1{ width:180px; white-space:nowrap; word-break:keep-all; overflow:hidden; text-overflow:ellipsis;}
.titless2{ width:130px; white-space:nowrap; word-break:keep-all; overflow:hidden; text-overflow:ellipsis;}
.indexPage{ width:220px; white-space:nowrap; word-break:keep-all; overflow:hidden; text-overflow:ellipsis;}
.titless3{display:block; padding:6px 8px; font:bold 12px "宋体"; color:#CC0000; }

.titless4{ width:80px; white-space:nowrap; word-break:keep-all; overflow:hidden; text-overflow:ellipsis;}
</style>

<link href="./../css/master.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./../js/index_0810.js"></script>
<script type="text/javascript" src="./../js/jquery.js"></script>
 <script type="text/javascript">
        $(document).ready(function () {
            var len = $("#flash_num>li").length;
            var index = 1;
            var int;
            function showSys(num)  //图片切换函数
            {
                $("#flash_num>li").removeClass().addClass("click_out").eq(num).toggleClass("click_out").addClass("click_over");
                $("#flash_pic>div").fadeOut().eq(num).fadeIn();
            }
            function ziDong()  //自动切换
            {
                if (index == len) {
                    index = 0;
                }
                showSys(index);
                index = index + 1;
            }
            int = setInterval(ziDong, 2000);
            $("#flash_num>li").click(function()
            {
            var index_num=$("#flash_num>li").index(this);
            showSys(index_num);
            index=index_num+1;  //改变全局变量的值，以便鼠标移开的时候能够衔接上
            });
            $("#flash_outer").mouseover(function ()  //移动到上面时停止自动切换
            {
                clearInterval(int);
            });
            $("#flash_outer").mouseout(function ()  //移开时继续自动切换
            {
            int = setInterval(ziDong, 2000);
            });
        })
    </script>

<style type="text/css">
        *
        {
            font-size: 12px;
            font-family: Verdana;
            margin: 0;
            padding: 0;
        }
        ul
        {
            list-style: none;
            margin: 0px;
            padding: 0px;
        }
        .click_out
        {
            margin-left: 5px;
            float: left;
            text-align: center;
            height: 16px;
            line-height: 16px;
            width: 16px;
            background: #333;
            color: #FFF;
            font-weight: bold;
            font-size: 12px;
            cursor: pointer;
            _display: inline-block;
        }
        
        .click_over
        {
            margin-left: 5px;
            float: left;
            text-align: center;
            height: 16px;
            line-height: 16px;
            width: 16px;
            background: #820000;
            color: #FFF;
            font-weight: bold;
            font-size: 12px;
            cursor: pointer;
            _display: inline-block;
        }
    </style>
             
       <div style="height: 200px; width: 230px; background: #EBEBEB; position: relative"
        id="flash_outer">
        <div style="position: absolute; left: 0px; top: 0px; width: 230px; height: 200px;
            overflow: hidden" id="flash_pic">
            <s:iterator value="#request.list_indexvocation" var="list">
            <div>
                <img    width="230px" height="200px"  src="<s:property value="#list.vnewsimagepath"/>" alt="<s:property  value="#list.vnewstitle"/>" class="imgLittle" />
            </div>
  
            </s:iterator>
        </div>
        <ul style="position: absolute; right: 0px; bottom: 0px; height: 16px" id="flash_num">
            <li class="click_over">1</li>
            <li class="click_out">2</li>
            <li class="click_out">3</li>
            <li class="click_out">4</li>
            <li class="click_out">5</li>
        </ul>
    </div>
   
	<table width="100%"> 
     <s:iterator value="#request.list_indexvocation" var="list">
     <tr><td>
     <input type="hidden" name="id" value="#list.vnewsid"/>
    <a href="auctionIndexVocationnews_indexsilgevocation?id=<s:property value="#list.vnewsid"/> " title="<s:property  value="#list.vnewstitle"/>"> 
      <s:if test="#list.vnewstitle.length()>20"> <s:property  value="#list.vnewstitle.substring(0,20)"/>...</s:if>
      <s:else>
        <s:property  value="#list.vnewstitle"/>
      </s:else>
       
    
    </a></td> 
     </tr>
     </s:iterator>
		</table>	
	     





