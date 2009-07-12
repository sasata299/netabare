$(function() {
  $("a[href^='http://']")
    .attr("target", "_blank");

  $("a.fancybox").fancybox({
    overlayShow: true,
    overlayOpacity: '0.9',
    frameWidth: 700,
    frameHeight: 600,
    hideOnContentClick: false,
    centerOnScroll: true
  });

  $("a.movie").fancybox({
    padding: false,
    overlayShow: true,
    overlayOpacity: '0.9',
    hideOnContentClick: false,
    callbackOnClose: function(){ 
      location.href = '/'; // If-Modified-Sinceリクエストを発行しないため
    },
    centerOnScroll: true
  });
});
