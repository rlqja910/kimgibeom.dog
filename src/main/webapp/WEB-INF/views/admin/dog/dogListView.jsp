<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Dog Manage</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function dogDel() {
	$('#delete').click(() => {
		if($('input:checkbox').is(':checked')) {
		   swal({
		      title: '',
		      text: '유기견 정보를 정말 삭제하시겠습니까?',
		      type: 'warning',
		      showCancelButton: true,
		      cancelButtonText: '아니오',
		      confirmButtonText: '예',
		      closeOnConfirm: false,
		      closeOnCancel: true
		   },
		   function(isConfirm){
		      if(isConfirm) swal('','유기견 정보가 삭제되었습니다.','success');
		      else('취소','','error');
		   });	
		}
	});
}

function reportSearch(){
	$('#search').click(() => {
		if($('#searchContent').val().trim()) {
			
		}	
	});
}


let totalPageCnt=${totalPageCnt};
console.log(totalPageCnt);
let isOnePage=${isOnePage};
console.log(isOnePage);
let lastPageDataCnt=${lastPageDataCnt};
console.log(lastPageDataCnt);
let dogsData=null;
let dogsCnt=${dogsCnt};

	$(()=>{
		dogList();
		
		$('#beforeAdoptBtn').click(()=>{
			let dogTitle = $('#dogTitle').val();
			
			$.ajax({
				url:'beforeAdoptSearch',
				data:{
					'dogTitle':dogTitle,
				},
				success:(data)=>{
					$('.pagination').empty();
					$('#dogPost').empty();
					console.log('good');
					
					console.log(data);
					
					totalPageCnt=data.totalPageCnt;
					console.log(totalPageCnt);
					isOnePage=data.isOnePage;
					console.log(isOnePage);
					lastPageDataCnt=data.lastPageDataCnt;
					console.log(lastPageDataCnt);
					dogsData=null;
					dogsCnt=data.dogsCnt;
					
					$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
					for(let i=1; i<=totalPageCnt;i++){
						$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
						if(i==1){
							$('#'+i+'page').attr("style","font-weight:bold;");
						}
					}
					$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
					
					$('.reviewCont').empty();
					
					if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
						console.log('not onepage');
						dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
						console.log(dogsData);
						
						for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
							$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[i-1].attachName+'</li><li>'+dogsData[i-1].dogTitle+'</li><li>'+dogsData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
						}
						
					}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
						console.log('onepage');
						if(dogsCnt==0){ //아예 데이터가 없을때
							$('.pagination').empty();
							$('#dogPost').append('<ul><li>등록된 데이터가 없습니다.</li></ul>');
						}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
							let onlyOnePageData=data.onlyOnePageData;
							console.log(onlyOnePageData);
							
							for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
								$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+onlyOnePageData[i-1].attachName+'</li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+onlyOnePageData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
							}
						}
					}
					console.log("끝");
					
					$('#firstViewBtn').click(()=>{
						$('#1page').trigger('click');
						return false;
					});
					
					$('#lastViewBtn').click(()=>{
						$('#'+totalPageCnt+'page').trigger('click');
						return false;
					});
					
					for(let i=1; i<=totalPageCnt;i++){
						$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
							for(let j=1; j<=totalPageCnt; j++){
								$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
							}
							$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
							
							console.log(i);
							$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
							
							if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
								dogsData=data.onlyOnePageData;
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									console.log((i-1)*8+cnt+"------------");
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								console.log(dogsData);
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									console.log((i-1)*8+cnt+"------------");
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
								
							}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								console.log(dogsData);
								
								let cnt=0;
								for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
									console.log((i-1)*8+cnt+"------------");
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}
							
							return false;
						});
					}
				},
			});
		});
		
		$('#afterAdoptBtn').click(()=>{
			let dogTitle = $('#dogTitle').val();
			
			$.ajax({
				url:'afterAdoptSearch',
				data:{
					'dogTitle':dogTitle,
				},
				success:(data)=>{
					$('.pagination').empty();
					$('#dogPost').empty();
					console.log('good');
					
					console.log(data);
					
					totalPageCnt=data.totalPageCnt;
					console.log(totalPageCnt);
					isOnePage=data.isOnePage;
					console.log(isOnePage);
					lastPageDataCnt=data.lastPageDataCnt;
					console.log(lastPageDataCnt);
					dogsData=null;
					dogsCnt=data.dogsCnt;
					
					$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
					for(let i=1; i<=totalPageCnt;i++){
						$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
						if(i==1){
							$('#'+i+'page').attr("style","font-weight:bold;");
						}
					}
					$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
					
					$('.reviewCont').empty();
					
					if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
						console.log('not onepage');
						dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
						console.log(dogsData);
						
						for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
							$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[i-1].attachName+'</li><li>'+dogsData[i-1].dogTitle+'</li><li>'+dogsData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
						}
						
					}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
						console.log('onepage');
						if(dogsCnt==0){ //아예 데이터가 없을때
							$('.pagination').empty();
							$('#dogPost').append('<ul><li>등록된 데이터가 없습니다.</li></ul>');
						}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
							let onlyOnePageData=data.onlyOnePageData;
							console.log(onlyOnePageData);
							
							for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
								$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+onlyOnePageData[i-1].attachName+'</li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+onlyOnePageData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
							}
						}
					}
					console.log("끝");
					
					$('#firstViewBtn').click(()=>{
						$('#1page').trigger('click');
						return false;
					});
					
					$('#lastViewBtn').click(()=>{
						$('#'+totalPageCnt+'page').trigger('click');
						return false;
					});
					
					for(let i=1; i<=totalPageCnt;i++){
						$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
							for(let j=1; j<=totalPageCnt; j++){
								$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
							}
							$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
							
							console.log(i);
							$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
							
							if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
								dogsData=data.onlyOnePageData;
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									console.log((i-1)*8+cnt+"------------");
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								console.log(dogsData);
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									console.log((i-1)*8+cnt+"------------");
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
								
							}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								console.log(dogsData);
								
								let cnt=0;
								for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
									console.log((i-1)*8+cnt+"------------");
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}
							
							return false;
						});
					}
				}
			});
		});
		
		$('#searchDogBtn').click(()=>{
				let dogTitle = $('#dogTitle').val();
				console.log(dogTitle);
				
				if(dogTitle===''){ //아무것도 입력안하면 리스트 전체 출력
					$('.pagination').empty();
					$('#dogPost').empty();
					totalPageCnt=${totalPageCnt};
					isOnePage=${isOnePage};
					lastPageDataCnt=${lastPageDataCnt};
					dogsData=null;
					dogsCnt=${dogsCnt};
					dogList();
				}else{
					$.ajax({
						url:'dogSearch',
						data:{
							'dogTitle':dogTitle,
						},
						success:(data)=>{  
							$('.pagination').empty();
							$('#dogPost').empty();
							console.log('good');
							
							console.log(data);
							
							totalPageCnt=data.totalPageCnt;
							console.log(totalPageCnt);
							isOnePage=data.isOnePage;
							console.log(isOnePage);
							lastPageDataCnt=data.lastPageDataCnt;
							console.log(lastPageDataCnt);
							dogsData=null;
							dogsCnt=data.dogsCnt;
							
							$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
							for(let i=1; i<=totalPageCnt;i++){
								$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
								if(i==1){
									$('#'+i+'page').attr("style","font-weight:bold;");
								}
							}
							$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
							
							$('.reviewCont').empty();
							
							if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
								console.log('not onepage');
								dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
								console.log(dogsData);
								
								for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
									$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[i-1].attachName+'</li><li>'+dogsData[i-1].dogTitle+'</li><li>'+dogsData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
								}
								
							}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
								console.log('onepage');
								if(dogsCnt==0){ //아예 데이터가 없을때
									$('.pagination').empty();
									$('#dogPost').append('<ul><li>등록된 데이터가 없습니다.</li></ul>');
								}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
									let onlyOnePageData=data.onlyOnePageData;
									console.log(onlyOnePageData);
									
									for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
										$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+onlyOnePageData[i-1].attachName+'</li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+onlyOnePageData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
									}
								}
							}
							console.log("끝");
							
							$('#firstViewBtn').click(()=>{
								$('#1page').trigger('click');
								return false;
							});
							
							$('#lastViewBtn').click(()=>{
								$('#'+totalPageCnt+'page').trigger('click');
								return false;
							});
							
							for(let i=1; i<=totalPageCnt;i++){
								$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
									for(let j=1; j<=totalPageCnt; j++){
										$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
									}
									$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
									
									console.log(i);
									$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
									
									if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
										dogsData=data.onlyOnePageData;
										 
										let cnt=0;
										for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
											console.log((i-1)*8+cnt+"------------");
											$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
									}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
										dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
										console.log(dogsData);
										
										let cnt=0;
										for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
											console.log((i-1)*8+cnt+"------------");
											$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
										
									}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
										dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
										console.log(dogsData);
										
										let cnt=0;
										for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
											console.log((i-1)*8+cnt+"------------");
											$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
									}
									
									return false;
								});
							}
							
						},error: function (xhr, ajaxOptions, thrownError) {
							console.log(xhr);
							console.log(ajaxOptions);
							console.log(thrownError);
		                }
					});
				}
		});
	});
	 
	function dogList(){
		$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
		for(let i=1; i<=totalPageCnt;i++){
			$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
			if(i==1){
				$('#'+i+'page').attr("style","font-weight:bold;");
			}
		}
		$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
		
		$('.reviewCont').empty();
		
		if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
			console.log('not onepage');
			dogsData=JSON.parse('${pageData}'); //controller에서 뽑은 데이터들을 준비한다.
			console.log(dogsData);
			
			for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
				$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[i-1].attachName+'</li><li>'+dogsData[i-1].dogTitle+'</li><li>'+dogsData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
			}
			
		}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
			console.log('onepage');
			if(dogsCnt==0){ //아예 데이터가 없을때
				$('.pagination').empty();
				$('#dogPost').append('<ul><li>등록된 데이터가 없습니다.</li></ul>');
			}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
				let onlyOnePageData=JSON.parse('${onlyOnePageData}');
				console.log(onlyOnePageData);
				
				for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
					$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+onlyOnePageData[i-1].attachName+'</li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+onlyOnePageData[i-1].dogContent+'</li><li>+더보기</li></ul></a>');
				}
			}
		}
		console.log("끝");
		
		$('#firstViewBtn').click(()=>{
			$('#1page').trigger('click');
			return false;
		});
		
		$('#lastViewBtn').click(()=>{
			$('#'+totalPageCnt+'page').trigger('click');
			return false;
		});
		
		for(let i=1; i<=totalPageCnt;i++){
			$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
				for(let j=1; j<=totalPageCnt; j++){
					$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
				}
				$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
				
				console.log(i);
				$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
				
				if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
					dogsData=JSON.parse('${onlyOnePageData}');
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						console.log((i-1)*8+cnt+"------------");
						$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
					dogsData=JSON.parse('${pageData}'); //그리고 Controller에서 불러온 데이터를 준비한다.
					console.log(dogsData);
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						console.log((i-1)*8+cnt+"------------");
						$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
					
				}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
					dogsData=JSON.parse('${pageData}'); //그리고 Controller에서 불러온 데이터를 준비한다.
					console.log(dogsData);
					
					let cnt=0;
					for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
						console.log((i-1)*8+cnt+"------------");
						$('#dogPost').append('<a href="../adopt/01.html"><ul><li>'+dogsData[(i-1)*8+cnt].attachName+'</li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+dogsData[(i-1)*8+cnt].dogContent+'</li><li>+더보기</li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}
				
				return false;
			});
		}
	}
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

/*------- 검색창 테두리-------- */
#inputBackground {
	height: 50px;
	padding: 7px;
	margin-bottom: 30px;
}

/*------- 이미지 체크박스-------- */
#chk {
	border: 2px solid black;
	width: 25px;
	height: 25px;
	position: relative;
	top: -45px;
	left: -165px;
}

.button {
	text-align: right;
	margin-right: 20px;
}

#content {
	float: left;
	margin-left: 10px;
	width: 400px;
	display: inline;
}

#searchDogBtn {
	background: #4b4276;
}

#spanSearch {
	color: #fff;
}

#pagination {
	display: block;
	text-align: center;
}

.report {
	width: 1800;
	font-size: 14px;
	margin-top: 10px;
	margin-bottom: 40px;
}

.report .reviewCont {
	width: 80%;
	overflow: hidden;
}

.report .reviewCont ul {
	width: 23.5%;
	float: left;
	margin: 1% 0 0 1%;
	border: 1px solid #ccc;
	height: 400px;
}

.report .reviewCont li {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.report .reviewCont ul li:nth-child(1) {
	padding: 40% 0;
	border-bottom: 1px solid #ccc;
	text-align: center;
}

.report .reviewCont ul li:nth-child(2) {
	font-weight: bold;
	margin: 5% 3% 3% 3%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.report .reviewCont ul li:nth-child(3) {
	margin: 0 3% 0 3%;
	color: #666;
	font-size: 12px;
}

.report .reviewCont ul li:nth-child(4) {
	text-align: right;
	margin: 6% 3% 5% 3%;
}

.report .reviewCont ul img {
	width: 100%;
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
					<a href='<c:url value='/admin/logo/logoRegist'/>'>로고관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='/admin/banner/bannerRegist'/>'>배너관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='/'/>'>홈페이지 돌아가기</a>&nbsp;|&nbsp; <a
						href='<c:url value='/user/logout'/>'>로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-heart'></span><strong>
							유기견 관리</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form>
						<div>
							<button class='form-control'
								style='width: 100px; height: 35px; float: left;'>제목</button>
							<div class='form-group' id='content'>
								<input type='text' id='dogTitle' class='form-control'
									placeholder='검색어를 입력해주세요.' />
							</div>
							<div class='form-group'>
								<button type='button' class='btn btn-default' id='searchDogBtn'>
									<span id='spanSearch'>검색</span>
								</button>
							</div>
						</div>
						<br>
						<button type='button' class='btn btn-default' id='beforeAdoptBtn'>입양
							전</button>
						&nbsp;
						<button type='button' class='btn btn-default' id='afterAdoptBtn'>입양
							후</button>

						<br> <br>
						<div class='report'>
							<div class='reviewCont' id='dogPost'></div>
							<br> <br>
							<div class='button'>
								<button type='button' class='btn btn-primary'
									onClick="location.href='dogRegist'">등록</button>
								<button type='button' class='btn btn-warning' id='delete'>삭제</button>
							</div>
						</div>
					</form>
					<br>

					<div id="pagination">
						<ul class="pagination">
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>