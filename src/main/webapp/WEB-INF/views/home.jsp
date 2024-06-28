<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=AjZmS5FC4Sn4r9ZDKaeZ"></script>

<style>

	.modal-header{
		text-align: center;
		height: 70px;
	}

	.image-container {
		position: relative;
		text-align: center;
	}

	.image-container img {
		display: block;
		width: 550px;
		height: 500px;
		margin: auto;
	}

	.overlay-text {
		position: absolute;
		top: -10px; /* 조정 필요 */
		left: 50px; /* 조정 필요 */
		right: 50px; /* 조정 필요 */
		background-color: rgba(0, 0, 0, 0.0);
		color: black;
		padding: 20px;
		text-align: center;
		font-size: 18px; /* 텍스트의 크기를 원하는 크기로 조정합니다 */
		line-height: 1.5; /* 텍스트 줄 간격을 조정할 수도 있습니다 */
	}

	/*.close-btn  {*/
	/*	position: absolute;*/
	/*	top: 10px;*/
	/*	right: 10px;*/
	/*	font-size: 20px;*/
	/*	cursor: pointer;*/
	/*	color: #aaa;*/
	/*}*/
	/*.stopWatching {*/
	/*	position: absolute;*/
	/*	bottom: 10px;*/
	/*	right: 10px;*/
	/*	font-size: 15px;*/
	/*	cursor: pointer;*/
	/*	color: #aaa;*/
	/*}*/
	.modal{
		position:absolute;
		display:none;

		justify-content: center;
		top:0;
		left:0;

		width:100%;
		height:100%;

		background-color: rgba(0,0,0,0.4);
	}

	.modal_body{
		position:absolute;
		top:50%;

		width:460px;
		height:200px;
		padding:40px;

		text-align: center;

		background-color: rgb(255,255,255);
		border-radius:10px;
		box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);

		transform:translateY(-50%);
	}

	.nonMember {
		text-align: center;
		padding-left: 550px;
	}


</style>

<%@include file="/WEB-INF/views/cmmn/header.jsp"%>



<!-- Carousel -->
<div id="theme-carousel" class="carousel slide" data-ride="carousel">

	<div class="carousel-inner" role="listbox">

		<%--<c:forEach var="result" items="${bannerList}" varStatus="st">

			<div class="item <c:if test="${result.index eq 0 }">active</c:if>">
			<img src="/resources/animal-adoption/images/carousel1.jpg" alt="carousel1" style="width: 100%" />
			<div class="carousel-caption">
				<div class="row">
					<div class="col-md-7">
					</div>
					<div class="col-md-5">
						<h2>SAVE LIFE ADOPT A PET</h2>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
						<br />
						<button type="button" onclick="fnBannerClick(${result.bannerNo});" class="button-more-primary btn btn-lg" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>

		</c:forEach>--%>



		<div class="item active">
			<img src="/resources/animal-adoption/images/carousel1.jpg" alt="carousel1" style="width: 100%"/>
			<div class="carousel-caption">
				<div class="row">
					<div class="col-md-7">
					</div>
					<div class="col-md-5">
						<h2>SAVE LIFE ADOPT A PET</h2>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
						<br />
						<button class="button-more-primary btn btn-lg" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>


		<div class="item">
			<img src="/resources/animal-adoption/images/carousel2.jpg" alt="carousel2" style="width: 100%" />
			<div class="carousel-caption">
				<div class="row">
					<div class="col-md-5">
						<h2>HELP WITH CARE AND LOVE</h2>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
						<br />
						<button class="button-more-primary btn btn-lg" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="/resources/animal-adoption/images/carousel3.jpg" alt="carousel3" style="width: 100%">
			<div class="carousel-caption">
				<div class="row">
					<div class="col-md-7">
					</div>
					<div class="col-md-5">
						<h2>ANIMALS NEED THE SUPPORT</h2>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
						<br />
						<button class="button-more-primary btn btn-lg" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Controls -->
	<a class="left carousel-control" href="#theme-carousel" role="button" data-slide="prev">
		<div class="carousel-control-arrow">&#8249;</div>
	</a>
	<a class="right carousel-control" href="#theme-carousel" role="button" data-slide="next">
		<div class="carousel-control-arrow">&#8250;</div>
	</a>
</div>
<div class="container-contact">
	<div class="container">
		<div class="page-header" id="contact">
			<h2 class="nonMember">NonMember Inquiry</h2>
			<br/>
			<div class="row">
				<div class="col-md-6">
					<div id="map" style="width:100%;height:400px;"></div>
				</div>
				<div class="col-md-6">
					<form method="POST" name="nonMembersInquiry" class="nonMemberForm" action="/nonMembers/inquiry">
						<div class="form-group">
							<label for="Name">이름</label>
							<input type="text" class="form-control" id="Name" name="name" placeholder="Name" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="Email">이메일</label>
							<input type="email" class="form-control" id="Email" name="Email" placeholder="Email Address" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="poneNumber">전화번호</label>
							<input type="text" class="form-control" id="poneNumber" name="poneNumber" placeholder="poneNumber" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="title">제목</label>
							<input class="form-control" id="title" name="title" placeholder="title" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="content">문의 내용</label>
							<textarea class="form-control" id="content" name="content" placeholder="content" autocomplete="off"></textarea>
						</div>
						<div class="form-group">
							<label for="password">암호</label>
							<input class="form-control" name="password" id="password" placeholder="비밀번호를 입력해주세요">
						</div>
						<div>
							<button class="button-more-primary btn btn-lg" id="nonMembers" type="button" style="margin:10px;">Register Now</button>
						</div>
						<input type="hidden" name="writer" id="writer" value="">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<%--div class="container-pets">
	<div class="container">
		<div class="page-header" id="pets">
			<h1 class="text-primary text-center">OUR PETS</h1>
		</div>
		<div class="row">
			<div class="col-md-6">
				<img class="img-responsive" src="/resources/animal-adoption/images/pets1.jpg" />
				<div>
					<div class="col-md-9" style="background-color: #43CA84; color:#fff;">
						<h3>REX</h3>
					</div>
					<div class="col-md-3 text-center">
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<img class="img-responsive" src="/resources/animal-adoption/images/pets2.jpg" />
				<div>
					<div class="col-md-9" style="background-color: #43CA84; color:#fff;">
						<h3>LUCKY</h3>
					</div>
					<div class="col-md-3 text-center">
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>
		<br />
		<br />
		<div class="row">
			<div class="col-md-6">
				<img class="img-responsive" src="/resources/animal-adoption/images/pets4.jpg" />
				<div>
					<div class="col-md-9" style="background-color: #43CA84; color:#fff;">
						<h3>TIGER</h3>
					</div>
					<div class="col-md-3 text-center">
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<img class="img-responsive" src="/resources/animal-adoption/images/pets3.jpg" />
				<div>
					<div class="col-md-9" style="background-color: #43CA84; color:#fff;">
						<h3>BENJY</h3>
					</div>
					<div class="col-md-3 text-center">
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>--%>

<div class="clearfix hidden-xs" style="width:100%; height:60px;"></div>

<%--<div class="container-phone">
	<div class="container">
		<div class="text-center">
			<h1>More Than 1695 Adorable Pets</h1>
			<br />
			<h3><i class="fa fa-phone" aria-hidden="true"></i>&nbsp;&nbsp; +1 888 455 6677</h3>
			<br />
			<br />
			<div id="chart"></div>
		</div>
	</div>
</div>--%>

<%--<div class="container-stories">
	<div class="container">
		<div class="page-header" id="stories">
			<h1 class="text-primary text-center">PETS STORIES</h1>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-6">
						<img class="img-responsive" src="/resources/animal-adoption/images/image2.jpg" />
					</div>
					<div class="col-md-6">
						<h3>Isabella</h3>
						<p>and Rex</p>
						<br />
						<p class="text-justify">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>
						<br />
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
						<br />
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-6">
						<img class="img-responsive" src="/resources/animal-adoption/images/image3.jpg" />
					</div>
					<div class="col-md-6">
						<h3>Zoe, Oliver</h3>
						<p>Molly and Max</p>
						<br />
						<p class="text-justify">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>
						<br />
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
						<br />
					</div>
				</div>
			</div>
		</div>
		<br />
		<br />
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-6">
						<img class="img-responsive" src="/resources/animal-adoption/images/image4.jpg" />
					</div>
					<div class="col-md-6">
						<h3>Mia</h3>
						<p>and Charlie</p>
						<br />
						<p class="text-justify">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>
						<br />
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-6">
						<img class="img-responsive" src="/resources/animal-adoption/images/image5.jpg" />
					</div>
					<div class="col-md-6">
						<h3>James</h3>
						<p>and Toby</p>
						<br />
						<p class="text-justify">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>
						<br />
						<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>--%>



<div class="container-gallery">
	<div class="container">
		<div class="page-header" id="gallery">
			<h1 class="text-center text-primary">ADOPT A PET</h1>
		</div>


		<c:set var="cnt" value="1" />

		<c:forEach var="result" items="${bannerList}" varStatus="st">

			<c:if test="${cnt == 1}">
				<div class="row">
			</c:if>
				<div class="col-md-4">
					<div class="well">
						<img class="img-responsive" src="/resources/animal-adoption/images/gallery/${result}" />
					</div>
				</div>

			<c:set var="cnt" value="${cnt + 1}" />

			<c:if test="${cnt == 4}">
				</div>
				<c:set var="cnt" value="1" />
			</c:if>
		</c:forEach>

		<%--
		<div class="row">
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive" src="/resources/animal-adoption/images/gallery/gallery1.jpg" />
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive"  src="/resources/animal-adoption/images/gallery/gallery2.jpg" />
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive"  src="/resources/animal-adoption/images/gallery/gallery3.jpg" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive"  src="/resources/animal-adoption/images/gallery/gallery4.jpg" />
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive"  src="/resources/animal-adoption/images/gallery/gallery5.jpg" />
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive" src="/resources/animal-adoption/images/gallery/gallery6.jpg" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive"  src="/resources/animal-adoption/images/gallery/gallery7.jpg" />
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive" src="/resources/animal-adoption/images/gallery/gallery8.jpg" />
				</div>
			</div>
			<div class="col-md-4">
				<div class="well">
					<img class="img-responsive"  src="/resources/animal-adoption/images/gallery/gallery9.jpg" />
				</div>
			</div>
		</div>--%>
	</div>
</div>
<div class="container-about">
	<div class="container">
		<div class="page-header" id="home">
			<h1 class="text-primary  text-center">ABOUT US</h1>
		</div>
		<div class="row">
			<div class="col-md-6">
				<img class="img-responsive" src="/resources/animal-adoption/images/image1.jpg"/>
			</div>
			<div class="col-md-6">
				<div>
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#mission" aria-controls="mission" role="tab" data-toggle="tab" style="font-size:20px;">Mission</a></li>
						<li role="presentation"><a href="#goal" aria-controls="goal" role="tab" data-toggle="tab" style="font-size:20px;">Goal</a></li>
						<li role="presentation"><a href="#vision" aria-controls="vision" role="tab" data-toggle="tab" style="font-size:20px;">Vision</a></li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content">
						<br />
						<div role="tabpanel" class="tab-pane active text-justify" id="mission">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
							<br />
							<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
						</div>
						<div role="tabpanel" class="tab-pane text-justify" id="goal">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
							<br />
							<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
						</div>
						<div role="tabpanel" class="tab-pane text-justify" id="vision">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia.
							<br />
							<button class="button-more-success btn" type="button" style="margin:10px;">READ MORE</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container-phone2">
	<div class="container">
		<div class="text-center">
			<h1>At our pet store, you can find any animal you can imagine to keep at home</h1>
			<br />
			<h3><i class="fa fa-phone" aria-hidden="true"></i>&nbsp;&nbsp; +1 888 455 6677</h3>
		</div>
	</div>
</div>


<div class="modal">
	<div class="modal_body">
		<h3>개인정보 보호를 위해 비밀번호를 변경 해주세요</h3>
		<button type="button" class="pwChangeOk btn btn-danger">비밀번호 변경</button>
		<button type="button" class="pwChangeNo btn btn-primary">나중에 변경</button>
	</div>
</div>
<c:forEach var="imgFile" items="${list}">
	<c:if test="${imgFile.valid_time == 'Y'}">
		<c:if test="${imgFile.status == 'ACTIVE'}">
		<div class="modal" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" id="close">&times;</span>
						</button>
						<h2 class="modal-title">이벤트 안내</h2>
					</div>
					<div class="modal-body">
						<div class="image-container">
							<img src="/common/img?fName=${imgFile.stored_file_name}&folder=${imgFile.folder_nm}">
							<div class="overlay-text">
								${imgFile.content}
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="modal-today-close">오늘하루 안 보기</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		</c:if>
	</c:if>
</c:forEach>

<script>
	$(document).ready(function (){

		function setCookie(name, value, expiredays){
			var today = new Date();
			today.setDate(today.getDate() + expiredays);
			document.cookie = name + '=' + escape(value) + '; expires=' + today.toGMTString();
		}

		function getCookie(name) {
			var cookie = document.cookie;
			if (document.cookie != "") {
				var cookie_array = cookie.split("; ");
				for ( var index in cookie_array) {
					var cookie_name = cookie_array[index].split("=");
					if (cookie_name[0] == "mycookie") {
						return cookie_name[1];
					}
				}
			}
			return;
		}
		$("#modal-today-close").click(function() {
			$("#myModal").css('display', 'none');
			setCookie("mycookie", 'popupEnd', 1);
		});

		$(".btn-secondary").click(function() {
			$("#myModal").css('display', 'none');
		});

		$(".close").click(function() {
			$("#myModal").css('display', 'none');
		});

		var checkCookie = getCookie("mycookie");

		if(checkCookie == 'popupEnd') {
			$("#myModal").css('display', 'none');
		} else {
			$('#myModal').css('display', 'flex');
		}

		let pwChangeTime = "${sessionScope.loginId.change_at}";
		<c:if test="${not empty success}">
		alert("${success}");
		</c:if>
		if (pwChangeTime === "Y") {
			const modal = $('.modal');
			modal.css('display', 'flex');
		}

		$('.pwChangeOk').on('click', function (){
			location.href = '/animal/pwChange';
		});

		$('.pwChangeNo').on('click', function (){
			const modal = $('.modal');
			modal.hide(500);
			let owner_Id = "${sessionScope.loginId.owner_Id}";
			$.ajax({
				url : '/animal/pwChangeNo',
				method : 'get',
				data : {owner_Id : owner_Id},
				success : function (success) {
					console.log(success);
				}, error: function (request, status, error) {

					console.log("code:" + request.status + "\n"
							+ "message:" + request.responseText + "\n" + "error:" + error);

				}
			});
		});

		$('#nonMembers').on('click', function () {
			let name = $('#Name').val();
			let email = $('#Email').val();
			let pone = $('#poneNumber').val();
			let title = $('#title').val();
			let content = $('#content').val();
			let writer = $('#writer');

			let isMemberCheckChecked = $('.pw_check').is(':checked');
			let passwordField = $('#password').val().trim();
			if (isMemberCheckChecked && (passwordField === '' || passwordField === null)){
				alert("비밀번호를 입력해주세여");
				return false;
			}

			if (name != "" && email != "" && pone != "" && title != "" && content != "") {
				writer.val(name);
				console.log(writer);
				$('.nonMemberForm').submit();
			}else {
				alert("빈칸을 작성해주세요");
				return false;
			}
		});

		var mapOptions = {
			center: new naver.maps.LatLng(37.3595704, 127.105399),
			zoom: 10
		}

		var map = new naver.maps.Map('map', {
			center: new naver.maps.LatLng(37.3595704, 127.105399),
			zoom: 10
		});

	});



	// function closePopup() {
	// 	const popupStop = $('.stopWatchingCheck').is(':checked');
	// 	if (popupStop){
	// 		$.ajax({
	// 			url : '/popup/stop',
	// 			data : {popupStop : popupStop},
	// 			type : 'GET',
	// 			success : function (data) {
	// 				console.log('성공');
	// 			},
	// 			error : function(request, status, error) {
	// 				alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
	// 			}
	// 		});
	// 	} else {
	// 		console.log("체크 안됨")
	// 	}
	// 	$('.modal2').css('display', 'none');
	// }

</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>