<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@include file="/WEB-INF/views/cmmn/header.jsp"%>



<!-- Navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a href="#" title="Animal Adoption Bootstrap Theme">
				<img class="logo" src="/resources/animal-adoption/images/logo.png" alt="Animal Adoption Bootstrap Theme" style="margin-top:5px;" />
			</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="/member/do" class="smooth-scroll">ABOUT</a></li>
				<li><a href="/naver/login" class="smooth-scroll">OUR PETS</a></li>
				<li><a href="#stories" class="smooth-scroll">STORIES</a></li>
				<li><a href="#gallery" class="smooth-scroll">ADOPT A PET</a></li>
				<li><a href="/board/list" class="smooth-scroll">CONTACT</a></li>
				<li><a href="/naver/login" class="smooth-scroll">LOGIN</a></li>
			</ul>
		</div><!-- /.navbar-collapse -->
	</div><!-- /.container-fluid -->
</nav>

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
				alert()

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

			<c:if test="${cnt == 1}"> <div class="row"> </c:if>
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

<div class="container-contact">
	<div class="container">
		<div class="page-header" id="contact">
			<h2 class="text-center text-primary">Contact us using the form below</h2>
			<br />
			<div class="row">
				<div class="col-md-6">
					<div id="googlemap"></div>
				</div>
				<div class="col-md-6">
					<form>
						<div class="form-group">
							<label for="form-name">Name</label>
							<input type="email" class="form-control" id="form-name" placeholder="Name">
						</div>
						<div class="form-group">
							<label for="form-email">Email Address</label>
							<input type="email" class="form-control" id="form-email" placeholder="Email Address">
						</div>
						<div class="form-group">
							<label for="form-subject">Telephone</label>
							<input type="text" class="form-control" id="form-subject" placeholder="Subject">
						</div>
						<div class="form-group">
							<label for="form-message">Email your Message</label>
							<textarea class="form-control" id="form-message" placeholder="Message"></textarea>
						</div>
						<button class="button-more-primary btn btn-lg" type="ubmit" style="margin:10px;">Register Now</button>
						<br /><br />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>


