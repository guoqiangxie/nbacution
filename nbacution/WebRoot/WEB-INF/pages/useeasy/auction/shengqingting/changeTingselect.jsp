<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript" src="DataPicker4.0/My97DatePicker/WdatePicker.js" language="javascript"></script>

<script type="text/javascript"   language="javascript">
  function timeduan(id){
     
    $.post("pmtingAction_timeduan?id="+id,null,function(date){
       document.getElementById("timeduan").innerHTML=date; 
    
    })
  }
   function updateTing(){
    
      $.post("pmtsqAction_updateTing?id="+$("#sqtidnum").attr('value')+"&useDay="+$("#useDay").attr('value')+"&time="+$("#time").attr('value')+"&ting="+ $("#ting").attr('value'),null,function(date){
         if(date == "0"){
            alert("被占用");
         }
         if(date == "1"){
            alert("更换成功");
             $("#changeTing").hide();
             location.href="pmtsqAction_teshusq";
         }
          if(date == "2"){
            alert("同时具备，天，厅号，时间段，才可以更新");
             
         }
     
     });
    
     
     
     }
</script>

<s:action name="pmtingAction_changeTingselect" executeResult="true"></s:action>
<table>
 <tr>
     <td>日期</td><td><input type="text"  id="useDay" name="useDay" readonly="readonly"
 class="Wdate" size="20" maxlength="20" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d '})"/></td>
 </tr> 
    
    <tr>
      <td>
         拍卖厅
      </td>
      <td>
         <s:select id="ting" name="ting" theme="simple" list="#request.pmtlist" listKey="id" listValue="pmtName" onchange="timeduan(this.value)" emptyOption="true"></s:select>
         
      </td>
      </tr>
      <tr>
       <td>
        时间段
      </td>
      <td>
         <span id="timeduan"></span>
         
      </td>
      </tr>
    
     <tr>
        <td colspan=2 align="center">
          <input type="button" value="确认" onclick="updateTing()"/>
        </td>
     
     </tr>  
   

    
</table>
<p style="color:red">在先确认你要改至的厅及时间段未被使用</p>