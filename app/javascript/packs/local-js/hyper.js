$(document).ready(function() {
    "use strict";
    $("#progressbarwizard").bootstrapWizard({
        onTabShow: function(t, r, a) {
            var o = (a + 1) / r.find("li").length * 100;
            $("#progressbarwizard").find(".bar").css({
                width: o + "%"
            })
        }
    })
});

$(document).on('click', '.button-menu-mobile', function(e) {
    $body = $('body')
    e.preventDefault();
    $body.toggleClass('sidebar-enable');
});

$(document).on('click', 'body', function (e) {
    if ($(e.target).closest('.right-bar-toggle, .right-bar').length > 0) {
        return;
    }

    if (
        $(e.target).closest('.left-side-menu, .side-nav').length > 0 ||
        $(e.target).hasClass('button-menu-mobile') ||
        $(e.target).closest('.button-menu-mobile').length > 0
    ) {
        return;
    }
    $('body').removeClass('right-bar-enabled');
    $('body').removeClass('sidebar-enable');
    return;
});
