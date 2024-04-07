<%--
  Created by IntelliJ IDEA.
  User: tiaal
  Date: 2024-04-07
  Time: 오후 7:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer id="subfooter" class="clearfix">
  <div class="container">
    <div class="row text-justify">
      <div class="col-md-4">
        <h3>About Us</h3>
        <br />
        <p>Our mission is to find the homeless animals around the country and give them a better life.</p>
        <hr style="border-color:#bbb;">
        <p>54, North Road, PA 45086, USA</p>
        <p>+1 888 455 6677</p>
        <p><a href="mailto:mail@example.com" style="color:#4BAFD3;">mail@example.com</a></p>
      </div>
      <div class="col-md-4">
        <h3>Animals For Adoption</h3>
        <br />
        <div class="row text-justify">
          <div class="col-md-4">
            <img class="img-responsive" src="/resources/animal-adoption/images/gallery/gallery1.jpg" />
          </div>
          <div class="col-md-8">
            <p>What is Lorem Ipsum?</p>
          </div>
        </div>
        <br />
        <div class="row text-justify">
          <div class="col-md-4">
            <img class="img-responsive" src="/resources/animal-adoption/images/gallery/gallery2.jpg" />
          </div>
          <div class="col-md-8">
            <p>Where does it come from?</p>
          </div>
        </div>
        <br />
        <div class="row text-justify">
          <div class="col-md-4">
            <img class="img-responsive" src="/resources/animal-adoption/images/gallery/gallery3.jpg" />
          </div>
          <div class="col-md-8">
            <p>Why do we use it?</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <h3>Last Adopted</h3>
        <br />
        <div class="row text-justify">
          <div class="col-md-4">
            <img class="img-responsive" src="/resources/animal-adoption/images/image4.jpg" />
          </div>
          <div class="col-md-8">
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
          </div>
        </div>
        <br />
        <div class="row text-justify">
          <div class="col-md-4">
            <img class="img-responsive" src="/resources/animal-adoption/images/image2.jpg" />
          </div>
          <div class="col-md-8">
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</footer>

<footer id="footer" class="clearfix">
  <div class="container">
    <div class="row">
      <div class="col-md-8">
        <p>Created by <a href="https://www.shieldui.com" title="Shield UI" style="color: #4BAFD3;">Shield UI</a> and hosted by <a href="https://www.prepbootstrap.com" title="PrepBootstrap" style="color: #4BAFD3;">PrepBootstrap</a></p>
      </div>
      <div class="col-md-4">
        <p>
          <a class="fa fa-twitter footer-socialicon" target="_blank" href="https://twitter.com/"></a>
          <a class="fa fa-facebook footer-socialicon" target="_blank" href="https://www.facebook.com/"></a>
          <a class="fa fa-google-plus footer-socialicon" target="_blank" href="https://plus.google.com/"></a>
          <a class="fa fa-linkedin footer-socialicon" target="_blank" href="https://plus.google.com/"></a>
        </p>
      </div>

    </div>
  </div>
</footer>
</body>
</html>

<script src="/resources/animal-adoption/js/jquery.min.js"></script>
<script src="/resources/animal-adoption/bootstrap/js/bootstrap.min.js"></script>
<%--<script src="/resources/animal-adoption/js/googleMap.js"></script>--%>
<script src="https://maps.googleapis.com/maps/api/js"></script>
<script src="/resources/animal-adoption/js/theme.js"></script>


<script type="text/javascript" src="/resources/animal-adoption/js/shieldui-lite-all.min.js"></script>
<script type="text/javascript" src="/resources/animal-adoption/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/animal-adoption/js/shieldui-all.min.js"></script>


<script type="text/javascript">
  jQuery(function($) {
    // Google Maps setup
    var googlemap = new google.maps.Map(
            document.getElementById('googlemap'),
            {
              center: new google.maps.LatLng(44.5403, -78.5463),
              zoom: 8,
              mapTypeId: google.maps.MapTypeId.ROADMAP
            }
    );
    // Shield Chart
    $("#chart").shieldChart({
      theme: "bootstrap",
      primaryHeader: {
        text: "Adorable Pets"
      },
      exportOptions: {
        image: false,
        print: false
      },
      axisX: {
        categoricalValues: ["2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014"]
      },
      tooltipSettings: {
        chartBound: true,
        axisMarkers: {
          enabled: true,
          mode: 'x'
        }
      },
      dataSeries: [{
        seriesType: 'bar',
        collectionAlias: "Adorable Pets in Thousands",
        data: [100, 320, 453, 234, 553, 665, 345, 123, 432, 545, 654, 345, 332, 456, 234]
      }]
    });
  });


</script>
