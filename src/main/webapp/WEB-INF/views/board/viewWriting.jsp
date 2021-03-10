<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/resources/ckeditor5/sample/styles.css">
</head>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

.bottom-nav {
	height: 50px;
	margin: auto;
	text-align: center;
}

.main {
	width: 1200px;
	height: 720px;
	margin: 0 auto;
}

.heading {
	border-bottom: 1px solid #fcab0e;
	padding-bottom: 9px;
	position: relative;
}

.heading span {
	background: #9e6600 none repeat scroll 0 0;
	bottom: -2px;
	height: 3px;
	left: 0;
	position: absolute;
	width: 75px;
}



/* =============================================
[ckeditor 넓이와 높이 style] */


 
.ck-editor__top {
    width: 100%;
 }

.ck-editor__editable_inline {
    min-height: 50px !important;
}

/* =============================================
 */
.a{
text-decoration:none;
color:red;
}
.pl100{
padding-left:100px;

}

.updateDel-btn{
text-decoration:none;
color:black;
font-weight:600;
}
 
.updateComment-content{
border:1px solid;
width:820px;
height:100px;
display:none;
} 

.updateComment-content:focus {
outline:1px solid black;}

.checkComment-btn{
display:none;
}
.cancelComment-btn{
display:none;
}


</style>



<body>
		<div class="container main">
				
				<div class="row">
					<jsp:include page="/WEB-INF/views/commonPage/header.jsp" />
				</div>
				
				<div class="row">
					<jsp:include page="/WEB-INF/views/commonPage/nav.jsp" />
				</div>
					
				<c:forEach var="i" items="${list}">
					<div class="row">
						<div class="col-6">
						</div>
					</div>
					<script>
						var writing_id=${i.writing_id}
						var board_code=${i.board_code}
						
					</script>
					<div class="row bg-light border-top border-bottom mb-1 pt-2 pb-2 pl-3">
						<div class="col text-dark pl-3">
							<h6>
								<strong>${i.writing_title}</strong>
							</h6>
						</div>
						<div class="col-6 text-end">
							<span>${i.writing_date}</span>
						</div>
					</div>
					<div class="row border-top border-bottom mt-1 mb-1 pt-2 pb-2 pl-4">
						<div class="col-6 text-dark">
							<span>${i.writing_writer}</span>
						</div>
						<div class="col-6 text-end">
							<span><strong>조회수</strong> ${i.writing_viewCount}</span> <span></span>
							<span><strong>댓글</strong></span>
							<span id="commentCount">${commentCountByWriting}</span>
						</div>
						
					</div>


					<div class="row mt-1 mb-1 pt-5 pb-2 pl-4">
						<div class="col-12">${i.writing_content}</div>
					</div>
				</c:forEach>
				<div class="row">
					<div class="col-12">
						<br>
					</div>
					<c:forEach var="j" items="${preNext}">
					<div class="col-4 text-danger text-center ">
						<strong>
						<a class="a preview" href="/board/viewWriting.board?writing_id=${j.pre_id}&board_code=${board_code}">
							 < Prev
						</a> 
						<a class="preview" style="text-decoration:none; color:black;" href="/board/viewWriting.board?writing_id=${j.pre_id}&board_code=${board_code}">
							  ${j.pre_title}
						</a>
						</strong>
					</div>
					<div class="col-4 text-center"></div>
					<div class="col-4 text-danger text-center">
						<strong>
							<a class="nextview" style="text-decoration:none; color:black;" href="/board/viewWriting.board?writing_id=${j.next_id}&board_code=${board_code}">
								${j.next_title}</a> 
							<a class="a nextview" href="/board/viewWriting.board?writing_id=${j.next_id}&board_code=${board_code}"> 
								  Next></a>
							</strong>
					</div>
					</c:forEach>
				</div>
				
				<div class="row">

					<div class="col-12 mt-1 mb-4 pt-2 pb-2 text-center">
						<span>
							<button id="board_hate" style="display:none;"><i class="bi bi-heart-fill" style="color:red; font-size: 2rem;"></i> 
							<span class="likeCount">${likeCount}</span>
							</button>
						</span>
						<span>
							<button id="board_like"><i class="bi bi-heart" style="font-size: 2rem;"></i>
							<span class="likeCount">${likeCount}</span>
							</button>
						</span>
					</div>
				</div>
				<div class="row">
					<div class="col-12 text-end">
						<p></p>
						<c:if test="${id==list[0].writing_writer}">
						<span><a class="updateDel-btn" href="/board/writingProc.board?proc=update&board_code=${board_code}">수정</a></span>
						<span><a class="updateDel-btn" id="deleteWriting-btn" href="#">삭제</a></span>
						</c:if>
						<p></p>
					</div>
				</div>
				
				<div class="row" style="height:20px;"></div>
				
				<!-- 댓글 container-->
				<div class="row border pt-3 pl-3 pb-4">
					<div class="col-12 mb-4 pl-5">
						<strong><i class="bi bi-chat-dots" style="color:lightblue; font-size:2rem;"></i> 댓글쓰기</strong>
					</div>
					<div class="col-12">
						<!-- 댓글 쓰기 -->
						<div class="row" id="writeComment-box">
							<div class="col-sm-2 d-none col-md-2 d-lg-block">
								<!-- ========================= 댓글 쓰기 thumbnailUser용 script from myPage.myInfo -->
								<img src="/resources/popupSignin/images/profile.jpg" id=signinUser-thumbnail style="border: 1px; text-align: center; width: 100px; height: 100px; transform: translate(60px, 0px);" />
								
							</div>
							<div class="col-sm-10 col-md-9 ">
								<textarea id="content"></textarea>
							</div>
							<div class="col-sm-2 text-center col-md-1">
								<button style="position:relative; top:30px;"type="button" class="btn btn-outline-secondary" id="comment-submit-btn">등록</button>
							</div>
							<div style="height:50px;"></div>
						</div>
						
						
						<!-- 댓글 list -->
						<c:forEach var="i" items="${commentsList}">	
						<div class='row commentList' id="${i.comment_id}">
							<div class="col-12">
								<div class="row  mt-1 mb-4 pt-2 pb-2">
									<div class="col-md-2 d-none d-lg-block">
										<script>
											var lastNum="${i.comment_id}";
											var lastNum_comment=$('#${i.comment_id}');
										</script> 
										<img src="${i.thumbnail_url}" class="commnetUser_thumbnail" style="border: 1px; text-align: center; width: 100px; height: 100px; transform: translate(60px, 0px);" />
									</div>
									
									<div class="col-sm-8 col-md-10 col-lg-8">
										<div class="nested-col-sm-5"><span><strong>${i.comment_writer}</strong></span> <span style="color:gray">   ${i.comment_date}</span></div>
										<div class="nested-col-sm-1"><p></p></div>
										<div class="nested-col-sm-6">
											<span class="comment_content-Box">${i.comment_content}</span>
										 	<span><textarea id="comment-editor" class="form-control updateComment-content"></textarea></span>
										 </div>
									</div>
									<c:if test="${id==i.comment_writer}">
									<div class="col-sm-2 col-md-2 col-lg-2">
										<span><a class="updateDel-btn updateComment-btn" href="#">수정</a></span>
										<span><a class="updateDel-btn deleteComment-btn" href="#">삭제</a></span>
										<span><a class="updateDel-btn checkComment-btn" href="#">확인</a></span>
										<span><a class="updateDel-btn cancelComment-btn" href="#">취소</a></span>
									</div>
									</c:if>
								</div>
							</div>
						</div>
						</c:forEach>
						
					</div>
				</div>

				<div class="row bottom-nav">
					<div class="col-12"></div>
				</div>
				<div class="row footer">
					<jsp:include page="/WEB-INF/views/commonPage/footer.jsp" />
				</div>
		</div>



<!--  글 삭제 로직-->
<script>
$('#deleteWriting-btn').on('click', function(){
	let result=confirm("정말 삭제하시겠습니까?");
		if(result){
			$.ajax({
			url: "/board/deleteWriting.board",
			type: 'get',
			data:{writing_id:writing_id}
		}).done(function(res){
			location.href="/board/boardList.board?cPage=1&board_code=${board_code}";
		})
	}
})
</script>


<!-- //=============================================================== 
[ 댓글 쓰기 비동기 구현 ]-->

<script>
 $('#comment-submit-btn').on('click',function(){
	
	 if('${id}'==''){
			alert("로그인 후에 이용할 수 있습니다.");
			return false;
		}
	 	
	 $.ajax({
	 		url:"/comment/writeComment.cm",
			type:"get",
			//dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data:{
				comment_writer:'${id}',
				comment_content:editor.getData(),
				writing_id:writing_id
				
			}
	 	}).done(function(res){
	 		//== 1. 비동기 댓글 쓰기에 관한 로직
	 			
	 			let obj=JSON.parse(res);
	 			let comment=JSON.parse(obj.comment)

				$('#writeComment-box').after(

						"<div class='row commentList' id='"+comment[0].comment_id+"'>"+
						"<div class='col-12'>"+
							"<div class='row  mt-1 mb-4 pt-2 pb-2'>"+
								"<div class='col-md-2 d-none d-lg-block'>"+
								"<img src='"+comment[0].thumbnail_url+"' class='commnetUser_thumbnail' style='border: 1px; text-align: center; width: 100px; height: 100px; transform: translate(60px, 0px);' />"+
								"</div>"+
								
								"<div class='col-sm-8 col-md-10 col-lg-8'>"+
									"<div class='nested-col-sm-5'><span><strong>"+comment[0].comment_writer+"</strong></span> <span style='color:gray'> "+obj.comment_date+"</span></div>"+
									"<div class='nested-col-sm-1'><p></p></div>"+
									"<div class='nested-col-sm-6'>"+
										"<span class='comment_content-Box'> "+comment[0].comment_content+" </span>"+
									 	"<span><textarea id='content' class='updateComment-content form-control '></textarea></span>"+
									 "</div>"+
								"</div>"+
								"<div class='col-sm-2 col-md-2 col-lg-2 addedComment-btnBox'>"+
									"<span><a class='updateDel-btn updateComment-btn' href='#'>수정</a></span>"+
									"<span style='margin-left:5px;'><a class='updateDel-btn deleteComment-btn' href='#'>삭제</a></span>"+
									"<span><a class='updateDel-btn checkComment-btn' href='#'>확인</a></span>"+
									"<span style='margin-left:5px;'><a class='updateDel-btn cancelComment-btn' href='#'>취소</a></span>"+
								"</div>"+
							"</div>"+
						"</div>"+
					"</div>"
							);
				
			  	 if('${id}'==comment[0].comment_writer){
					$('.addedComment-btnBox').show();
					//일치할 경우
					$('.updateComment-content').hide();
					$('.checkComment-btn').hide();
					$('.cancelComment-btn').hide();

				}else{
			  		$('.addedComment-btnBox').hide();
			  		$('#updateComment-contentBox').hide();
			  		
				}
			  	 
			  	scrollTop();
			  	$('#commentCount').html(obj.commentCount);
			  	
		}) 		  
		
})
 
</script>


<script>
									
//==========================================================================
//[동기화된 댓글 삭제(비동기)]

/* 동적 생성된 댓글 및 동기화된 댓글 삭제 로직 */
$(document).on('click', '.deleteComment-btn', function(){
	var comment=$(this).closest('div.commentList');
	var result=confirm("정말로 삭제하시겠습니까?");
	
	if(result){
		$.ajax({
			url:"/comment/deleteComment.cm",
			type:"get",
			data:{comment_id:comment.attr("id")},
			success:function(res){
				var obj=JSON.parse(res);
				comment.remove();
				$('#commentCount').html(obj.commentCount);
				scrollTop();
				
			},
			fail:function(res){
				console.log(res);
			}
		})
		}else{
			scrollTop();
		}  
	
})

/*==========================================================================
[댓글 수정 이벤트]	*/
$('.updateComment-content').hide();
$('.checkComment-btn').hide();
$('.cancelComment-btn').hide();

$(document).on('click',".updateComment-btn",function(){
	
	var comment=$(this).closest('div.commentList');
	comment.find('.comment_content-Box').hide();
	comment.find('.updateComment-content').show();
	comment.find('.updateComment-btn').hide();
	comment.find('.deleteComment-btn').hide();

	//=== 전체 버튼 용
	comment.find('.checkComment-btn').show();
	comment.find('.cancelComment-btn').show();
	
	scrollTop();
	
	var content="";
	comment.find('.checkComment-btn').on('click', function(){
		
		content=comment.find('.updateComment-content').val();
		
		$.ajax({
			url:"/comment/updateComment.cm",
			type:"post",
			data:{
				comment_id:comment.attr('id'),
				comment_content:content
			}
			}).done(function(res){
				comment.find('.checkComment-btn').hide();
				comment.find('.cancelComment-btn').hide();
				comment.find('.updateComment-content').hide();
				comment.find('.updateComment-btn').show();
				comment.find('.deleteComment-btn').show();
				comment.find('.comment_content-Box').show();
				comment.find('.comment_content-Box').html(content);
		})	
	})
	
	comment.find('.cancelComment-btn').on('click', function(){
		comment.find('.updateComment-btn').show();
		comment.find('.deleteComment-btn').show();
		comment.find('.checkComment-btn').hide();
		comment.find('.cancelComment-btn').hide();
		
		comment.find('.updateComment-content').hide();
		comment.find('.comment_content-Box').show();
	})
	
	
})

</script>


<!-- //==========================================================
[댓글쓰기 본인용 썸네일 이미지] -->
<script>
if('${userInfo[0].thumbnail_url}'!=''&&'${userInfo[0].sns_code}'=="02"){// direct signup
		$('#signinUser-thumbnail').attr("src", '${userInfo[0].thumbnail_url}');
	//direct는 server단의 files에 업로드가 되어있기에 경로를 files/아래로두고 저장된 file명을 검색해서 load.
								         	
	// kakao signup
	}else if('${userInfo[0].thumbnail_url}'!=''&&'${userInfo[0].sns_code}'=="01"){
		$('#signinUser-thumbnail').attr('src', "${userInfo[0].thumbnail_url}");
			//카톡은 server단의 files에 저장이 아니라, 직접 kakao server단에서 url을 가져오는 방식.
	} 
</script>
								
<!-- =========================================================================
[스크롤 제자리 위치 function]========================================================-->
<script>
function scrollTop(){
	$(window).scroll(function () {
		var scrollValue = $(document).scrollTop(); 
		//console.log(scrollValue); 
		$(document).scrollTop(scrollValue);
	});
}

</script>
<!-- =========================================================================
[좋아요 기능 script]========================================================-->
<script>
if('${likeUser[0].like_id}'!=''){
	$('#board_like').hide();
	$('#board_hate').show();
}

/* 
 *기존 user의 likeUser의 좋아요 ID를 셋팅.
    그후 좋아요 USER가 싫어요를 누른 후에, 아래의 LIKE 이벤트를 타고,
    새 LIKE_ID가 갱신됨.
*/
var like_id='${likeUser[0].like_id}';
var likeCount='${likeCount}';
$('#board_like').on('click',function(){
	
	if('${id}'==''){
		alert("로그인 후에 이용할 수 있습니다.");
	}else if('${id}'!=''){
		
		$.ajax({
			url:"/board/board_like",
			type:"get",
			data:{writing_id:writing_id,
				  user_id:'${id}'
				},
			success:function(res){
				//*list는 한차례 parse 후에 배열에 접근해야 한다.
				
				var obj=JSON.parse(res);
				like_id=JSON.parse(obj.likeUser)[0].like_id;
				likeCount=obj.likeCount;
				
				$('.likeCount').html(likeCount);
				$('#board_like').hide();
				$('#board_hate').show();
			}	
		})
		
	}
})


//<!-- =========================================================================
//[싫어요 기능 script]========================================================-->
$('#board_hate').on('click',function(){

	if(like_id!=''){
		
		$.ajax({
			url:"/board/board_hate",
			type:"get",
			data:{like_id:like_id},
			success:function(res){
				$('.likeCount').html(JSON.parse(res));
				$('#board_like').show();
				$('#board_hate').hide();
			}	
		})
		
	} 
})

</script>

<!-- =========================================================================
[prev 이전 글 script]========================================================-->
<script>

if('${preNext[0].pre_title}.'=='이전 글이 없습니다.'){
	jQuery('.preview').click(function(){
		return false;
	})
}

if('${preNext[0].next_title}.'=='다음 글이 없습니다.'){
	jQuery('.nextview').click(function(){
		return false;
	})
}

</script>

<!-- ========================= 현재 시간을 local time으로 parse 함수 ========================== -->

<script type="text/javascript">

function getTimeStamp() {
  var d = new Date();
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}

</script>

<script src="/resources/ckeditor5/build/ckeditor.js?version=12"></script>


</body>
</html>