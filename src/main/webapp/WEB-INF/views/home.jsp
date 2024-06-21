<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<style>
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
</style>

<%@include file="/WEB-INF/views/cmmn/header.jsp"%>



<!-- Carousel -->
<div id="theme-carousel" class="carousel slide" data-ride="carousel">
	<!-- Wrapper for slides -->
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

		<script>
			function fnBannerClick(bannerNo){
				// alert()

			}

		</script>

		<div class="item active">
			<img src="/resources/animal-adoption/images/carousel1.jpg" alt="carousel1" style="width: 100%" />
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
			<h2 class="text-center text-primary">비회원 문의</h2>
			<br />
			<div class="row">
				<div class="col-md-6">
					<div id="googlemap"></div>
				</div>
				<div class="col-md-6">
					<form method="POST" name="nonMembersInquiry" class="nonMemberForm" action="/nonMembers/inquiry">
						<div class="form-group">
							<label for="Name">이름</label><a style="margin-left: 84%">비밀글<input type="checkbox" class="pw_check"></a>
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
						<div>
							<input type="text" name="password" id="password" placeholder="비밀번호를 입력해주세요" style="display: none">
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

<div class="container-pets">
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
</div>

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

<div class="container-stories">
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


<div class="modal">
	<div class="modal_body">
		<h3>개인정보 보호를 위해 비밀번호를 변경 해주세요</h3>
		<button type="button" class="pwChangeOk btn btn-danger">비밀번호 변경</button>
		<button type="button" class="pwChangeNo btn btn-primary">나중에 변경</button>
	</div>
</div>
<script>
	$(document).ready(function (){
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

		$('.pw_check').on('change', function () {
			if ($(this).is(':checked')) {
				$('#password').css('display', 'flex'); /* 체크되면 암호창 보이기 */
			} else {
				$('#password').css('display', 'none'); /* 체크 해제 시 암호창 숨기기 */
			}
		})

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
				writer.val(email);
				console.log(writer);
				$('.nonMemberForm').submit();
			}else {
				alert("빈칸을 작성해주세요");
				return false;
			}
		});
	});
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>


