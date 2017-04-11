jQuery(function() {

    jQuery('#side-menu').metisMenu();

});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
jQuery(function() {
    jQuery(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            jQuery('div.navbar-collapse').addClass('collapse')
            topOffset = 100; // 2-row-menu
        } else {
            jQuery('div.navbar-collapse').removeClass('collapse')
        }

        height = (this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            jQuery("#page-wrapper").css("min-height", (height) + "px");
        }
    })
});

String.prototype.capitalizeFirstLetter = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

var curPage = "home";
var siteName = "Kinder Surprise";

pwl = function pageWrapperLoader() {
  jQuery('#page-wrapper').load('/pages/'+ curPage +'.html','#page-wrapper');
  document.title = document.title.replace("{%Page}", curPage.capitalizeFirstLetter() );
  jQuery("#page-title").html(curPage.capitalizeFirstLetter());
  return false;
}

function ready() {
    console.log("Ready!");

    if( !(document.location.hash === undefined || document.location.hash === "")) {
    	curPage = document.location.hash.substr(1);
    } else {
        document.location.hash = curPage = "home";
    }

    console.log(curPage);
    document.title = document.title.replace("{%Site}", curPage.capitalizeFirstLetter() );
    jQuery("#site-title").html(siteName);
    pwl();
}

document.addEventListener("DOMContentLoaded", ready);

jQuery("#side-menu>li>a").click(function(evt) {
    jQuery("#side-menu>li>a").removeClass("active");
    jQuery(this).addClass("active");
    console.log(this.hash);
    curPage = document.location.hash = (this.hash).substr(1);
    pwl();
});
