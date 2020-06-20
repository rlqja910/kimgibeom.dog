<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css'>
<link rel='stylesheet' href='http://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css'/>
<script src='https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js'></script>
<script src="//cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
<script src="${path}/ckeditor/ckeditor.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background: #f3f5f9;
}

#leftNav {
	display: flex;
	position: relative;
}

#leftNav #sidebar {
	position: fixed;
	width: 200px;
	height: 100%;
	background: #4b4276;
	padding: 20px 0;
}

#leftNav #sidebar h2 {
	color: #fff;
	text-align: center;
	margin-bottom: 30px;
}

#leftNav #sidebar ul li {
	padding: 15px;
	list-style: none;
	border-bottom: 1px solid rgba(0,0,0,0.05);
	border-top: 1px solid rgba(225,225,225,0.05);
}

#leftNav #sidebar ul li a {
	color: #bdb8d7;
	display: black;
}

#leftNav #sidebar ul li a span {
	width: 25px;
}

#leftNav #sidebar ul li:hover {
	background: #594f8d;
}

#leftNav #sidebar ul li:hover a {
	color: #fff;
	text-decoration: none;
}

#leftNav .main_content {
	width: 100%;
	margin-left: 200px;
}

#leftNav .main_content .header {
	padding: 11px;
	background: #fff;
	color: #717171;
	border-bottom: 1px solid #e0e4e8;
}

#leftNav .main_content .header .border{
	font-size: 19px;
}

#leftNav .main_content .header #topButton {
	text-decoration: none;
	margin-top: 4px;
	margin-right: 20px;
	float: right;
}

#leftNav .main_content .header #topButton a{
	text-decoration: none;
}

#leftNav .main_content .info {
	margin: 60px;
	color: #717171;
}

#content {
	float: left;
	margin-left: 10px;
	width: 400px;
	display: inline;
}

th{
	background-color:#EFEFEF;
	text-align: center;
	width: 150px;
}

textarea{
	width: 1500px;
	height: 1000px;
	resize: none;
	padding: 20px;
}

</style>
</head>
<body>
<div class='wrapper' id='leftNav'>
	<div class='sidebar' id='sidebar'>
		<%@ include file="../common/nav.jsp" %>
	</div>
	<div class='main_content'>
		<div class='header'>
			<strong>&nbsp;&nbsp;ADMINSTRATOR</strong>
			<div id='topButton'>
				<a href='../logo/logoRegist'>로고관리</a>&nbsp;|&nbsp;
				<a href='../banner/bannerRegist'>배너관리</a>&nbsp;|&nbsp; 
				<a href='../../'>홈페이지 돌아가기</a>&nbsp;|&nbsp; 
				<a href='../../user/logout'>로그아웃</a>
			</div>
		</div>
		<div class='info'>
			<div class='content'>
				<h3>
					<span class='glyphicon glyphicon-list'></span>
					<strong> 후기관리 > 등록</strong>
				</h3>
				<hr style='border: 1px solid #a0a0a0;'>
			
				<form>
					<table class='table'>
						<tr>
							<th>제목</th>
							<td><input type='text' style='width:500px;'/></td>
						</tr>
						<tr>
							<th>이미지</th>
							<td><input type='file'/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea id="description"> 
								</textarea>
								<script>
									CKEDITOR.replace("description", {
										removePlugins: 'image'
									});
								</script>
							</td>
						</tr>
					</table>
					
					<div class='button' style='text-align:right;'>
						<button type='button' class='btn btn-primary' onClick="location.href='01.html'">등록</button>&nbsp;
						<button type='button' class='btn btn-default' onClick="location.href='01.html'">취소</button>
					</div>
				</form>	
			</div>	
		</div>
	</div>
</div>
</body>
</html>