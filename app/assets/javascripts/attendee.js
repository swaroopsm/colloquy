// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

    $(function() {
        // $( "#sortable" ).sortable({
        //     placeholder: "ui-sortable-placeholder",
        //     update: function( event, ui ) {
        //       sortedIDs = $( "#sortable" ).sortable( "toArray" );
        //       console.log(sortedIDs);
        //     }
        // });

        // $( "#sortable2" ).sortable({
        //     placeholder: "ui-sortable-placeholder"
        // });
        // $( "#sortable3" ).sortable({
        //     placeholder: "ui-sortable-placeholder"
        // });

    $('a.register').click(function() {
      registeredfor = $('this').attr("title");
      console.log(registeredfor);
    });



    });