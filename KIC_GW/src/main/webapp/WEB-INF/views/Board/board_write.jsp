<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
	String ename = (String)session.getAttribute("ename");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<style type="text/css">
	.submit-wrapper {
        display: inline-block;
        margin: 5px 5px;
        padding: 10px;
    }
    .submit {
        background: #D5D5D5;
        border: none;
        padding: 2px;
        cursor: pointer;
        display: block;
        position: relative;
        overflow: hidden;
        transition: all .35s ease-in-out .35s;
        margin: 0 auto;
        width: 80px;
        text-align: center;
    }
    .submit span {
        display: block;
        padding: 10px 20px;
        background: #D5D5D5;
        z-index: 100;
        position: relative;
        transition: all .35s ease-in-out .35s;
    }
    .submit:hover span {
        background: #56bafc;
        color: #fff;
        transition: all .35s ease-in-out .35s;
    }
    .submit:after {
        bottom: -100%;
        right: -100%;
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        background: #56bafc;
        transition: all .35s ease-in-out .5s;
    }
    .submit:hover:after {
        right: 0;
        bottom: 0;
        transition: all ease-in-out .35s;
    }
    .submit:before {
        top: -100%;
        left: -100%;
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        background: #56bafc;
        transition: all .35s ease-in-out .5s;
    }
    .submit:hover:before {
        left: 0;
        top: 0;
        transition: all ease-in-out .35s;
    }

</style>
<script type="text/javascript" src="./SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

var oEditors = [];
var sLang = "ko_KR";
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "./SE2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : false,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : false,       
			  I18N_LOCALE : sLang,
              fOnBeforeUnload : function(){                 
              }
          }, 

          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["ir1"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });
     /*  //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });     */

});
	window.onload = function() {
		document.getElementById( 'submit1' ).onclick = function() {
			if( document.frm.subject.value.trim() == '' ) {
				alert( '제목을 입력하셔야 합니다.' );
				return false;
			}
			document.frm.submit();
		};
		
		function boardlist(eno) {
			$.ajax({
				url : './boardlist.do',
				type : 'get',
				data: {
					eno: eno,
					cpage: '1'
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		function buttonwriteok() {
			$.ajax({
				url : './button_write_ok.do',
				type : 'get',
				data: {
					eno: <%=eno%>,
					ename: <%=ename%>
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}

		
		$(document).on('click','.button_list', function() {
			boardlist( <%=eno%>);
		});
		$(document).on('click','.buttonwriteok', function() {
			buttonwriteok();
		});
	};
</script>
</head>

<body>
<!-- 상단 디자인 -->
<div class="con_title">
	<h3>게시판</h3>
	<p>게시판 &gt; <strong>사내게시판</strong></p>
</div>
<div class="con_txt">
	<form action="./board_write_ok.do" method="post" name="frm">
		<div class="contents_sub">	
			<!--게시판-->
			<div class="board_write">
				<table style="width: 700px;">
				<tr>
					<th class="top">글쓴이</th>
					<td class="top" colspan="3"><%=ename %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="subject" value="" class="board_view_input" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea id="ir1" rows="10" cols="30" style="width:150%; height:200px; "></textarea></td>
				</tr>
				</table>
				
			</div>
			

	
				<div style="float:right; margin-right:100px;" class="light-button submit-wrapper buttonwriteok">
					<div class="submit">
						<span>
							등록
						</span>
					</div>  
				</div>

			
			
			<!--//게시판-->
		</div>
	</form>

				<div class="light-button submit-wrapper buttonlist">
					<div class="submit">
						<span>
							목록
						</span>
					</div>  
				</div>

<!-- 하단 디자인 -->

</body>

</html>
