<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
	String eno = (String)session.getAttribute("eno");
	String level = (String)session.getAttribute("level");

	if(eno == null || eno.equals("")) {
		out.println("<script type='text/javascript'>");
		out.println("alert('로그인이 필요합니다.')");
		out.println("location.href='./login.do'");
		out.println("</script>");
	} /* else if(level == "3") {
		out.println("<script type='text/javascript'>");
		out.println("alert('권한이 필요합니다.')");
		out.println("location.href='./login.do'");
		out.println("</script>");
	} */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<title>Insert title here</title>
<style type="text/css">
a {
  color: #4f4f4f;
}

.button {
  width: 50%;
  height: 100%;
  margin: auto;
  display: block;
  border: 1px solid #4f4f4f;
  border-radius: 4px;
  transition: all 0.2s ease-in;
  position: relative;
  overflow: hidden;
}
.button:before {
  content: "";
  position: absolute;
  left: 50%;
  transform: translateX(-50%) scaleY(1) scaleX(1.25);
  top: 100%;
  width: 140%;
  height: 180%;
  background-color: rgba(0, 0, 0, 0.05);
  border-radius: 50%;
  display: block;
  transition: all 0.5s 0.1s cubic-bezier(0.55, 0, 0.1, 1);
  z-index: -1;
}
.button:after {
  content: "";
  position: absolute;
  left: 55%;
  transform: translateX(-50%) scaleY(1) scaleX(1.45);
  top: 180%;
  width: 160%;
  height: 190%;
  background-color: #39bda7;
  border-radius: 50%;
  display: block;
  transition: all 0.5s 0.1s cubic-bezier(0.55, 0, 0.1, 1);
  z-index: -1;
}
.button:hover {
  color: #ffffff;
  border: 1px solid #39bda7;
}
.button:hover:before {
  top: -35%;
  background-color: #39bda7;
  transform: translateX(-50%) scaleY(1.3) scaleX(0.8);
}
.button:hover:after {
  top: -45%;
  background-color: #39bda7;
  transform: translateX(-50%) scaleY(1.3) scaleX(0.8);
}
.swal-button--confirm {
    background: #39bda7;
}
</style>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
function ad_Modify(eno){
	var leveltarget = document.getElementById("level" + eno);
	var level = leveltarget.options[leveltarget.selectedIndex].value;
	
	var jobtarget = document.getElementById("job" + eno);
    var job = jobtarget.options[jobtarget.selectedIndex].value;
	swal({
		  title: "수정하시겠습니까?",
		  icon: "warning",
		  dangerMode: true,
		  buttons: [true, "수정"],
		})
		.then(function(willDelete) {
			if (willDelete) {
			    swal("수정완료!", {
			      icon: "success",
			      button: false
			    });
				setTimeout(function () {
					location.href='./addressModifyLevel_ok.do?eno=' + eno + '&level=' + level + '&job=' + encodeURI(job);
				}, 1000);
			} else {
				close: true;
			}
	});
};
</script>
</head>
<body>
<div id="wrapper">
<%@include file="../Menu/topmenu.jsp" %>
<div id="container" >
	<div class="row">
		<div class="col-sm-3">
		<!-- 왼쪽 메뉴바 상단 메뉴 클릭시 jQuery를 이용해 메뉴바를 다르게 적용 -->
			<%@include file="./addrmenu.jsp" %>
		</div>
		<div class="col-sm-8">
		<!-- 메뉴 페이지의 내용이 들어갈 부분 -->
		<table class="table table-striped table-bordered table-hover" style="text-align: center;">
			<colgroup>
				<col width='5%' />
				<col width='5%' />
				<col width='10%' />
				<col width='5%' />
				<col width='10%' />
				<col width='10%' />
				<col width='5%' />
				<col width='10%' />
			</colgroup>
			<thead>
				<tr>
					<th>사진</th>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>아이디</th>
					<th>직급</th>
					<th>권한</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="addressList" items="${addressList}" varStatus="status">	
					<tr style="line-height: 50px;">
						<td><img style="width: 50px; height: 50px;" src="./resources/photo/<c:out value="${addressList.ephoto}"/>"></td>
						<td><c:out value="${addressList.eno}"/></td>
						<td><c:out value="${addressList.ename}"/></td>
						<c:forEach var="dname" items="${deptList}" varStatus="status">
							<c:if test="${addressList.deptno == status.count}"><td>${dname}</td></c:if>
						</c:forEach>
						<td><c:out value="${addressList.eid}"/></td>
						<td>
						<select id="job${addressList.eno}" name="job${addressList.eno}" class="form-control">
							<c:forTokens var="item" items="사장,부사장,과장,팀장,사원" delims=",">
					       		<option value="${item}" <c:if test='${item==addressList.job}'>selected</c:if>>${item}</option>
						 	</c:forTokens>
						</select>
						</td>
						<td>
						<select id="level${addressList.eno}" name="level${addressList.eno}" class="form-control">
							<c:forTokens var="item" items="1,2,3,4,5" delims=",">
					       		<option value="${item}" <c:if test='${item==addressList.level}'>selected</c:if>>${item}</option>
						 	</c:forTokens>
						</select>
						</td>
						<td><a onclick="ad_Modify(${addressList.eno})" class="button" style="text-decoration:none">변경</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
</div>
</div>
</body>
</html>