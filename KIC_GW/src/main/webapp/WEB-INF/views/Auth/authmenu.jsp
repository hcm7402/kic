<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
  <link rel="stylesheet" href="./resources/menu.css">
   <script type="text/javascript">
   
   	$(document).ready( function() {
   		$('#menu li.active').addClass('open').children('ul').show();
   		$('#menu li.has-sub>a').on('click', function(){
   			$(this).removeAttr('href');
   			var element = $(this).parent('li');
   			if (element.hasClass('open')) {
   				element.removeClass('open');
   				element.find('li').removeClass('open');
   				element.find('ul').slideUp(200);
   			}
   			else {
   				element.addClass('open');
   				element.children('ul').slideDown(200);
   				element.siblings('li').children('ul').slideUp(200);
   				element.siblings('li').removeClass('open');
   				element.siblings('li').find('li').removeClass('open');
   				element.siblings('li').find('ul').slideUp(200);
   			}
   		});
   	});
   </script>
<div id='menu'>
<ul>
    <li class='active has-sub'><a href='#'>결재</a>
   <ul>
   	<li><a href='./authlist.do'>결재 목록</a>
   </ul>
   </li>
   <li class='active has-sub'><a href='#'>신청서</a>
   <ul>
   	<li><a href='./vacation.do'>휴가 신청서</a>
   	<li><a href='./busitrip.do'>출장 신청서</a>
   	<li><a href='./transportation.do'>교통비 신청서</a>
   </ul>
   </li>
    		
</ul>
</div>
