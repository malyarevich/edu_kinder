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
  document.title = siteName + " - " + curPage.capitalizeFirstLetter();
  jQuery("#page-title").html(curPage.capitalizeFirstLetter());
  mf();
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

//----------------------------------------------------------------------------------------------------------------
mf = function medicalFunc() {
    jQuery('#page-wrapper').load('/pages/' + curPage + '.html', '#page-wrapper', function() {
        jQuery("#med_parent").hide();
        jQuery('#height_input').hide();
        jQuery('#weight_input').hide();
        jQuery('#cancel_vac').hide();

        chw();
        sdii();
        gd();
    });
}

chw = function chooseHeightWeight() {
    jQuery('#span_height').click(function() {
        jQuery('#span_height').hide();
        jQuery('#height_input').show();
        sethw();
    });
    jQuery('#span_weight').click(function() {
        jQuery('#span_weight').hide();
        jQuery('#weight_input').show();
        sethw();
    });
}

sethw = function setHeightWeight() {
    $(document).ready(function() {
        jQuery('#height_input').keydown(function(e) {
            if (e.keyCode === 13) {
                jQuery('#height_input').hide();
                jQuery('#span_height').show();
            }
        });
    });

    $(document).ready(function() {
        jQuery('#weight_input').keydown(function(e) {
            if (e.keyCode === 13) {
                jQuery('#weight_input').hide();
                jQuery('#span_weight').show();
            }
        });
    });
}

sdii = function setDataInInputs() {
    jQuery('#table_med tr').click(function() {
        jQuery('#cancel_vac').show();
        $(this).find('td').each(function() {
            var value = jQuery(this).html();
            var type = jQuery(this).attr('type');

            jQuery('.inputs #' + type).val(value);
            jQuery("#select_type_vaccination :contains(" + value + ")").prop("selected", true);
            jQuery("#select_reason_vaccination :contains(" + value + ")").prop("selected", true);
        });
    });
}

gd = function getDataFromImputs() {
    $("#submit_vaccination_info").click(function() {
        var type = jQuery("#select_type_vaccination :selected").val(); //val
        var reason = jQuery("#select_reason_vaccination :selected").text();
        var date = jQuery("#date_vac").val();
        var term = jQuery("#term_vac").val();
        jQuery('#cancel_vac').hide();
        clear();
        return false;
    });
    $("#cancel_vac").click(function() {
        jQuery('#cancel_vac').hide();
        clear();
    });
}

clear = function clearVacInputs() {
    $("#select_type_vaccination :first").prop("selected", true);
    $("#select_reason_vaccination :first").prop("selected", true);
    jQuery("#date_vac").val('');
    jQuery("#term_vac").val('');
}