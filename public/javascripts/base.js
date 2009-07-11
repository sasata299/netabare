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
      window.location.reload();
    },
    centerOnScroll: true
  });

  $("a.faviconize").faviconize({
    position: "before",
    defaultImage: "external.gif",
    linkable: true,
    className: "faviconize"
  });
});
