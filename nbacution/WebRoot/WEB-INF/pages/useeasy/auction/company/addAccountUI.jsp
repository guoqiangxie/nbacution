 
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
 
	  			
	  								
 <center>
 <form method="post" action="">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
      <tr>
          <td bgcolor="#f5f6e5">帐号类型</td>
           <td bgcolor="#FFFFFF">
              <s:select theme="simple"  name="account_Type" list="#{2:'会员公司',4:'非会员公司',5:'工商监管'}" listKey="key" listValue="value" value="1"  />
           </td>
       </tr>
       
       <tr>
          <td bgcolor="#f5f6e5">选择公司</td>
           <td bgcolor="#FFFFFF">
                <s:select id="cid" theme="simple"  name="cid" list="#request.companyList" listKey="id" listValue="companyName" value="1" emptyOption="true"/>
           </td>
       </tr>
        <tr>
          <td bgcolor="#f5f6e5"> 帐号</td>
          <td bgcolor="#FFFFFF"><input type="text" name="account" id="account" maxlength="50" onblur="isNotExistAccountName(this)"/><span id="account1" ></span></td>
        </tr>
        <tr>
           <td bgcolor="#f5f6e5">密码</td>
           <td bgcolor="#FFFFFF"><input type="password" name="password" id="password" maxlength="50"/></td>
        </tr>
        <tr>
           <td bgcolor="#f5f6e5">确认密码</td> 
           <td bgcolor="#FFFFFF"><input type="password" name="repassword" id="repassword"/></td>
        </tr>
       
    </table>
    <input type="button" value="新加" onclick="formSubmit()"/>
    
    </form>
    </center>
    
    
    <script type="text/javascript">
      function isNotExistAccountName(obj){
       
        $.post("adminManage_isNotExistAccountName?accountName="+obj.value,null ,function(data){
               if(data ==1){
                 $("#account1").html("已被注册");
               }else if(data ==0){
                  $("#account1").html("可用");
               }
        });
      
      }
       function formSubmit(){
        var account= document.getElementById("account"); 
        if(($("#cid").val().length) ==0 ){
           alert("请选择公司");
           return;
         }
        if(account.value.length==0){
          alert("帐号必填");
          return;
        }
         
        var pass= document.getElementById("password"); 
        var repass=document.getElementById("repassword");
        if(pass.value.length==0){
            alert("密码必填");
          return;
        }
        if(pass.value!=repass.value){
          
		    alert("两次密码不一至");
		    return ; 
        } 
         document.forms[0].action='adminManage_addAccount';
          $.post("adminManage_isNotExistAccountName?accountName="+account.value,null ,function(data){
               if(data ==0){
                   document.forms[0].submit();
                   
                }  else{
                     $("#account1").html("<font color='red'>已被注册</font>");
                }
        });
		
		 
       }
    </script>
 