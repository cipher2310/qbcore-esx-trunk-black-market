$(document).ready(function() {
    hideall()
    window.addEventListener('message', function(event) {
        var data = event.data;

            if (data.hide == true) {
                hideall()
            }
            if (data.hide == false) {
                showclass1()
            }



    })

});

function openwindow() {
    showwindow()
}

document.onkeyup = function(evt) {
    evt = evt || window.event;
    var isEscape = false;
    if ("key" in evt) {
        isEscape = (evt.key === "Escape" || evt.key === "Esc");
    } else {
        isEscape = (evt.keyCode === 27);
    }
    if (isEscape) {
        hideall()
        $.post('http://ftz-darkwebdealer/exit', JSON.stringify({}));
    }
};

function start() {
    $.post('http://ftz-darkwebdealer/start', JSON.stringify({}));
}

function hideall() {
    $("#Image7").hide();
    $("#Image1").hide();
    $("#Image2").hide();
    $("#tortext").hide();

    // class 2
    $("#Image3").hide();
    $("#tablet_Text2").hide();
    $("#Image4").hide();
    $("#Image5").hide();
    $("#Image6").hide();
    $("#textwelcome").hide();
    $("#Button1").hide();
}

function showclass1() {
    $("#Image7").fadeIn();
    $("#Image1").fadeIn();
    $("#Image2").fadeIn();
    $("#tortext").fadeIn();
}

function showwindow() {
    $("#Image3").fadeIn();
    $("#tablet_Text2").fadeIn();
    $("#Image4").fadeIn();
    $("#Image5").fadeIn();
    $("#Image6").fadeIn();
    $("#textwelcome").fadeIn();
    $("#Button1").fadeIn();
}


function showall() {
    $("#Image7").fadeIn();
    $("#Image1").fadeIn();
    $("#Image2").fadeIn();
    $("#tortext").fadeIn();

    // class 2
    $("#Image3").fadeIn();
    $("#tablet_Text2").fadeIn();
    $("#Image4").fadeIn();
    $("#Image5").fadeIn();
    $("#Image6").fadeIn();
    $("#textwelcome").fadeIn();
    $("#Button1").fadeIn();
}