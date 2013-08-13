jQuery(document).ready(function($) {

	close = function(){
    $(".close").click(function(){
      $(this).parent().remove();
    });
  }

  modalload = function(modalContent) {
    var modaldiv = $("#modal");
    modaldiv.html('');
    modaldiv.html(modalContent);

    modht = $(window).height() - 40;
    modaldiv.css('height', modht);

    modaldiv.css({'marginRight' : '-3000'});

    modaldiv.parent().css('display', 'block');
    modaldiv.parent().animate({'opacity': '1'}, 500, function(){
      modaldiv.animate({'marginRight' : '0'}, 200);
    });
     // hide loader after modal is loaded
    $("#loaderwrap").empty();
    $("#loaderwrap").hide();
  }

  $(".closemodal").click(function() {
    var modaldiv = $("#modal");
    // alert(modaldiv);

    modaldiv.animate({'marginRight' : '-3000'}, 200, function(){
      modaldiv.parent().animate({'opacity': '0'}, 500, function(){
        modaldiv.html('');
        modaldiv.parent().css('display', 'none');
      });
    });

  });

});
