$(document).ready(function() { 
   new WOW().init();

    // initialise flexslider
    $('.site-hero').flexslider({
      animation: "fade",
      directionNav: false,
      controlNav: false, 
      keyboardNav: true,
      slideToStart: 0,
      animationLoop: true,
      pauseOnHover: false,
      slideshowSpeed: 4000, 
    });


    // initialize isotope
    var $container = $('.portfolio_container');
    $container.isotope({
      filter: '*',
    });
   
    $('.portfolio_filter a').click(function(){
      $('.portfolio_filter .active').removeClass('active');
      $(this).addClass('active');
   
      var selector = $(this).attr('data-filter');
      $container.isotope({
        filter: selector,
        animationOptions: {
          duration: 500,
          animationEngine : "jquery"
        }
      });
      return false;
    }); 
});     