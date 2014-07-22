<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
<title>工商监管</title>
<sx:head />

</head>
<body>

 <%String str="123456";
   request.setAttribute("str",str);
  %>
<!-- tabbedpanel标签 -->
<!-- 最简单的选项卡，两个选项卡加载都是本页面 -->
  <hr color="blue">
  <b>最简单的选项卡：</b>
  <br>
        <sx:tabbedpanel id="tab1" selectedTab="Tab 2" >
     <sx:div label="Tab 1"  labelSeparator="true" >
         Local Tab 1
         
        <s:property value='#request.str' escape="true"/>
     </sx:div>  
     <sx:div label="Tab 2"  id="Tab 2">
         Local Tab 2
     </sx:div>  
        </sx:tabbedpanel>


<!-- 加载其他页面的选项卡 -->
  <hr color="blue">
  <b>加载其他页面的选项卡：</b>
  <br>
  <sx:tabbedpanel id="tab2">
  <sx:div label="Remote Tab 1" href="upload.jsp">
             Remote Tab 1
        </sx:div>
     <sx:div label="Remote Tab 2" href="multipleUpload.jsp" >
             Remote Tab 1
        </sx:div>
  </sx:tabbedpanel>


<!-- 设置选项卡底下的内容懒加载，即等需要的时候再加载，使用属性preload="false"-->
  <hr color="blue">
  <b>设置选项卡底下的内容懒加载，即等需要的时候再加载，使用属性preload="false"：</b>
  <br>
        <sx:tabbedpanel id="tab3">
     <sx:div label="Remote Tab 1" href="upload.jsp">
         Remote Tab 1
     </sx:div> 
     <sx:div label="Remote Tab 2" href="multipleUpload.jsp" preload="false">
         Remote Tab 1
     </sx:div>     
        </sx:tabbedpanel>


<!-- 固定大小的选项卡 -->
  <hr color="blue">
  <b>固定大小的选项卡,使用属性cssStyle和doLayout：</b>
  <br>
        <sx:tabbedpanel cssStyle="width: 200px; height: 100px;" doLayout="true" id="tab4">
     <sx:div label="Tab 1" >
         Local Tab 1
     </sx:div>  
     <sx:div label="Tab 2" >
         Local Tab 2
     </sx:div>  
        </sx:tabbedpanel>


<!-- 每次点击选项卡时都重新刷新内容 -->
  <hr color="blue">
  <b>每次点击选项卡时都重新刷新内容，使用属性refreshOnShow：</b>
  <br>
  <sx:tabbedpanel id="tab5">
     <sx:div label="Remote Tab 1" href="upload.jsp" refreshOnShow="true">
         Remote Tab 1
     </sx:div> 
     <sx:div label="Remote Tab 2" href="multipleUpload.jsp" refreshOnShow="true">
         Remote Tab 2
     </sx:div>     
  </sx:tabbedpanel>

 

<!-- 使得其中一个选项卡失效 -->
  <hr color="blue">
  <b>使得其中一个选项卡失效：</b>
  <br>
         <sx:tabbedpanel id="tab6">
    <sx:div label="Tab 1" >
        Local Tab 1
    </sx:div>  
    <sx:div label="Tab 2" disabled="true">
        Local Tab 2
    </sx:div>  
        </sx:tabbedpanel>


<!-- 设置选项卡在底部显示 (可以是: top, right, bottom, left) -->
  <hr color="blue">
  <b>设置选项卡在底部显示 (可以是: top, right, bottom, left)：</b>
  <br>
  <sx:tabbedpanel id="tab7" labelposition="bottom" cssStyle="width:200px;height:100px;" doLayout="true">
     <sx:div label="Tab 1" >
         Local Tab 1
     </sx:div>  
     <sx:div label="Tab 2" >
         Local Tab 2
     </sx:div>  
  </sx:tabbedpanel>

<!-- 设置选项卡允许关闭，使用属性closeable -->
  <hr color="blue">
  <b>设置选项卡允许关闭，使用属性closeable：</b>
  <br>       
  <sx:tabbedpanel id="tab8">
     <sx:div label="Tab 1" >
         Local Tab 1
     </sx:div>  
     <sx:div label="Tab 2"  closable="true">
         Local Tab 2
     </sx:div>  
  </sx:tabbedpanel>

  
  

</body>
</html>
