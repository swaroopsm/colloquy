 close = function(){
    $(".close").click(function(){
      $(this).parent().remove();
    });
  }

  message = function(messagetype, message) {
    var messagediv = $('#messages');
    messagediv.html('');
    // console.log(messagediv);
    if (messagetype=='error') {
      messagediv.append('<div class="error"><i class="icon-warning messageleft" style="color: #f1c40f;"></i>'+message+'<div class="close">&times;</div></div>');
    } else if (messagetype=='success') {
      messagediv.append('<div class="success"><i class="icon-ok messageleft" style="color: #fff;"></i>'+message+'<div class="close">&times;</div></div>').delay(800, function(){
        // setting window reload for the success
      }, 3000);
      // setting timeout for removal of message
      setTimeout(function(){
        messagediv.children().remove();
        location.reload();
      },3000);
    } else if (messagetype=='loading') {
      messagediv.append('<div class="loading"><i class="icon-spin animate-spin" style="color: #fff;"></i>'+message+'<div class="close">&times;</div></div>');
    } else {
      console.log(messagetype+" not recognised. Use 'error' or 'success' for better results");
    };
    close();
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

  closemodal = function() {
    var modaldiv = $("#modal");
    // alert(modaldiv);

    modaldiv.animate({'marginRight' : '-3000'}, 200, function(){
      modaldiv.parent().animate({'opacity': '0'}, 500, function(){
        modaldiv.html('');
        modaldiv.parent().css('display', 'none');
      });
    });
  }

    showloader = function() {
    var loader = $(".loaderoverlay");
    loader.css({'display': 'block'});
    loader.animate({'opacity': '1'}, 1000, function() {
      /* stuff to do after animation is complete */
    });
  }

  closeloader = function() {
    var loader = $('.loaderoverlay');
    loader.animate({'opacity': '0'}, 1000, function() {
      loader.css('display', 'none');
    });
  }

jQuery(document).ready(function($) {

  $(".closemodal").click(function() {
    closemodal();
    closeloader();

  });

});
