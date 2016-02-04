// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require chat
//= require users
//= require private_pub
//= require turbolinks
//= require_tree .
//= require js-routes

// function to set the height on fly
function autoHeight() {
    $('.row-main-custom').css('min-height', 0);
    $('.row-main-custom').css('min-height', (
        $(document).height()
        - $('.footer-container').height() - 70
    ));
}

// onDocumentReady function bind
$(document).ready(function() {
    autoHeight();
});

// onResize bind of the function
$(window).load(function() {
    autoHeight();
});


$(document).ajaxComplete(function() {
    autoHeight();
});
// onResize bind of the function
$(window).resize(function() {
    autoHeight();
});
