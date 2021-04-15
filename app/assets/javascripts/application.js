// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

function openNav() {
    document.getElementById("pc_nav").style.width = "348px";
    document.getElementById("main").style.marginLeft = "0";
    document.getElementById("open_nav_hamburger").style = "visibility:hidden;";
}

function closeNav() {
    document.getElementById("pc_nav").style.width = "0";
    document.getElementById("main").style.marginLeft = "-348px";
    document.getElementById("open_nav_hamburger").style = "visibility: visible; font-size:30px; cursor:pointer";
}

function mobileNav() {
    x = document.getElementById("myLinks");
    if (x.style.display === "block") {
        x.style.display = "none";
    } else {
        x.style.display = "block";
    }
}

var $buoop = {
    required: {e: -4, f: -3, o: -3, s: -1, c: -3}, insecure: true, api: 2021.04, no_permanent_hide: true, text_for_i: {
        'msg': 'Your browser ({brow_name}) is too old! Internet Explorer is not supported on this website.',
        'msgmore': 'Update your browser as soon as possible to use this site.'
    }
};

function $buo_f() {
    var e = document.createElement("script");
    e.src = "//browser-update.org/update.min.js";
    document.body.appendChild(e);
};
try {
    document.addEventListener("DOMContentLoaded", $buo_f, false)
} catch (e) {
    window.attachEvent("onload", $buo_f)
}
