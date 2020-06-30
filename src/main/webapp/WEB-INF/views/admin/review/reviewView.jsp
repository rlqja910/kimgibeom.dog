<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet'
	href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css'>
<link rel='stylesheet'
	href='http://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css' />
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js'></script>
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src='http://code.jquery.com/jquery-3.4.1.min.js'></script>
<script src="../res/adminNavSub.js"></script>
<script>
function delReply() {
	$(".delete").click(() => {
		swal({
			title: '',
			text: '댓글을 삭제하시겠습니까?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonText: '확인',
			cancelButtonText: '취소',
			closeOnConfirm: false
		})
	});
};

function modifyReview(){
	$("#modifyReview").click(() => {
		let url = "reviewModify";
		url = url + "?reviewNum=" + ${reviewView.reviewNum};
		
		location.href = url;
	});
}

function cencel(){
	$("#cencel").click(() => {
		location.href = "reviewListView";
	});
}

$(() => {
	delReply();
	modifyReview();
	cencel();
});
</script>
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
	border-bottom: 1px solid rgba(0, 0, 0, 0.05);
	border-top: 1px solid rgba(225, 225, 225, 0.05);
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

#leftNav .main_content .header .border {
	font-size: 19px;
}

#leftNav .main_content .header #topButton {
	text-decoration: none;
	margin-top: 4px;
	margin-right: 20px;
	float: right;
}

#leftNav .main_content .header #topButton a {
	text-decoration: none;
}

#leftNav .main_content .info {
	margin: 50px;
	color: #717171;
}

.item {
	width: 640px;
	height: 300px;
	margin: 0 120px 50px 30px;;
	float: left;
}

table {
	border: 1px solid silver;
}

th {
	background-color: #EFEFEF;
	text-align: center;
	width: 100px;
}

textarea {
	width: 1000px;
	height: 300px;
	resize: none;
	border: white;
	padding: 15px;
}

img {
	width: 355px;
	height: 240px;
	padding-bottom: 0;
}

.replyBox {
	padding: 6px 10px 5px 10px;
}

.replyContent {
	margin-top: 3px;
}

.delete {
	float: right;
	margin-top: 3px;
}

.marker{
	background-color: yellow;
}
</style>
</head>
<body>
	<div class='wrapper' id='leftNav'>
		<div class='sidebar' id='sidebar'>
			<%@ include file="../common/nav.jsp"%>
		</div>
		<div class='main_content'>
			<div class='header'>
				<strong>&nbsp;&nbsp;ADMINSTRATOR</strong>
				<div id='topButton'>
					<a href="<c:url value='/admin/logo/logoRegist'/>">로고관리</a>&nbsp;|&nbsp;
					<a href="<c:url value='/admin/banner/bannerRegist'/>">배너관리</a>&nbsp;|&nbsp; 
					<a href="<c:url value='/'/>">홈페이지 돌아가기</a>&nbsp;|&nbsp; 
					<a href="<c:url value='/user/logout'/>">로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-list'></span> <strong>
							후기관리 > 상세</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form>
						<table class='table'>
							<tr>
								<th>제목</th>
								<td>${reviewView.title}</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<div class='img'>
										<img src='<c:url value="/attach/review/${reviewView.attachName}"/>'/>
									</div><br>
									<div>${reviewView.content}</div>
								</td>
							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<button type='button' class='btn btn-primary' id="modifyReview">수정</button>
							&nbsp;
							<button type='button' class='btn btn-default' id="cencel">취소</button>
						</div>
					</form>
				</div>

				<h4>
					<strong>댓글</strong>
				</h4>
				<br>
				<div style='background-color: #eeeeee;'>
					<div class='replyBox'>
						<span><strong>miso93</strong>&nbsp;&nbsp;2020-06-10</span>
						<button type='button' class='btn btn-danger delete'>삭제</button>
						<div class='replyContent'>아이가 얼른 주인분 만났으면 좋겠네요.</div>
					</div>

				</div>
				<br>
				<div style='background-color: #eeeeee;'>
					<div class='replyBox'>
						<span><strong>smile1</strong>&nbsp;&nbsp;2020-06-10</span>
						<button type='button' class='btn btn-danger delete'>삭제</button>
						<div class='replyContent'>
							안타깝네요. <br>안타깝네요. <br>안타깝네요. <br>안타깝네요. <br>안타깝네요.
							<br>안타깝네요. <br>안타깝네요.
						</div>
					</div>
				</div>
				<br>
			</div>
		</div>
	</div>
</body>
</html>