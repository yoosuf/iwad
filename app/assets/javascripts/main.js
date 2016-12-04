$(document).ready(function() {
	//$('.sidebar-menu li a').find('i').hide('fa');
	$count = 1;
	$('a.back-to-top').hide();
	var icon = "<i class='glyphicon glyphicon-remove' style='margin-right:2px'>  ";
	
	/* Left sidebar operations */
	$('.sidebar-toggle').click(function() {
		if($('.sidebar-menu li a').find('i').is(':hidden')) {
			$('.sidebar-menu li a').find('i').show('fa');
			$('.sidebar-menu li a').find("span").css("background-color", "#29282a !important");
		}
		
		else {
			$('.sidebar-menu li a').find('i').hide('fa');
			$('.sidebar-menu li a').find("span").css("background-color", "");
		}
	});
	
	/* Back-to-top */
	$('.content-wrapper').scroll(function() {
		if($('.content-wrapper').scrollTop() > 200) {
			$('a.back-to-top').fadeIn("slow").show();
		}
		
		else {
			$('a.back-to-top').fadeOut("slow");
		}
	});
	
	$('a.back-to-top').click(function() {
		$('.content-wrapper').animate({
			scrollTop: 0
		}, 1000)
		
		return false;
	});
	
	$('#deliok').click(function() {
		var clientName = $(".deliverycname").val();
		var deliveryFrom = $(".deliveryfrom").val();
		var deliveryTo = $(".deliveryto").val();
		
		if(clientName == "" || deliveryFrom == "" || deliveryTo == "") {
			swal({
			  title: "Warning!",
			  text: "Please fill out this field.",
			  type: "warning"
			});
		}
	});
	
	$('#offrok').click(function() {
		var offerName = $(".offername").val();
		var offerDesc = $(".offerdesc").val();
		
		if(offerName == "" || offerDesc == "") {
			swal({
			  title: "Warning!",
			  text: "Please fill out this field.",
			  type: "warning"
			});
		}
	});
	
	$('.modified').prepend(icon);
});

/* Phone number validation */
function onlyNumsAllowed(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode;

	if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 43  && charCode != 45) {
		swal({
			  title: "Warning!",
			  text: "Invalid characters.",
			  type: "warning"
			});
		return false;
	}
	
	else {
		return true;
	}
}