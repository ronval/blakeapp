$(function() {
  "use strict";

  if ($('.home-page').length > 0) {

      /* ==========================================================================
    Feature image absolute position height fix
    ========================================================================== */

    $(".features div[class='row'] .col-md-7").each(function() {
      var newHeight = 0,
          $this = $(this);
      $.each($this.children(), function() {
          newHeight += $(this).height();
      });
      $this.height(newHeight);
    });

    /* ==========================================================================
    sticky nav
   ========================================================================== */

    // var sticky = new Waypoint({
    //   element: $('.navbar-default')[0],
    //   handler: function(direction) {
    //     alert('You have scrolled to a thing')
    //   }
    // });

    // $('.navbar-default').waypoint('sticky', {
    //   offset: 30
    // });

    var sticky = new Waypoint.Sticky({
      element: $('.navbar-default')[0]
    })

    /* ==========================================================================
    Collapse nav bar
    ========================================================================== */

    $(".navbar-nav li a").on('click', function() {
      $(".navbar-collapse").collapse('hide');
    });

    $(".navbar-toggle").on('click', function(event) {
      if ($(".navbar-collapse").hasClass('show')) {
        $(".navbar-collapse").collapse('hide');
        event.stopPropagation();
      }
    });

  }

});
