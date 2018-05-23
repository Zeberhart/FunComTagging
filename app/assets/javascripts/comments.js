
var MAX_WORDS = 8;

function getSelected() {
  if(window.getSelection) { return window.getSelection(); }
  else if(document.getSelection) { return document.getSelection(); }
  else {
    var selection = document.selection && document.selection.createRange();
    if(selection.text) { return selection.text; }
    return false;
  }
  return false;
}

function expand(range) {
    if (range.collapsed) {
        return;
    }

    while (range.toString()[0].match(/[^\s]/) && range.startOffset > 0) {
        range.setStart(range.startContainer, range.startOffset - 1);   
    }
    range.setStart(range.startContainer, range.startOffset + 1);

    while (range.toString()[range.toString().length - 1].match(/[^\s]/)) {
        range.setEnd(range.endContainer, range.endOffset + 1);
    }
    range.setEnd(range.endContainer, range.endOffset - 1);
}

function mouseUp() {
	var selection = getSelected()
    if(selection && selection.toString().length>0){
        selectionRange = selection.getRangeAt(0);
        var start = selectionRange.startOffset; 
        var text = "";
        var anchor;
        var focus;
        var acceptable;
        if (window.getSelection) {
            anchor = window.getSelection().anchorNode;
            focus = window.getSelection().focusNode;
            acceptable = anchor.nodeValue && anchor.nodeValue.indexOf("\u200B")>=0;
            if(anchor == focus && acceptable){
                expand(selectionRange);
                text = window.getSelection().toString();
                text.replace("\n", "")
                // if(text.split(" ").length > MAX_WORDS){
                //     window.getSelection().removeAllRanges();
                //     return false;
                // }
                while (text.split(" ").length > MAX_WORDS) {
                    selectionRange.setEnd(selectionRange.endContainer, selectionRange.endOffset - 1);
                    text = window.getSelection().toString();
                }
            	document.getElementById("confirmation").innerHTML = text;
                document.getElementById("tag").value = text;
            }
        }
    }else{
        document.getElementById("confirmation").innerHTML = "";
        document.getElementById("tag").value = "";
    }
}

function test(){
  alert("AHHHHH");
}

$(document).on('turbolinks:load', function() {
    $("#comment").on("mouseup", function(){
        mouseUp();
    });
    document.onkeydown=function(){
        if(window.event.keyCode=='13'){
            document.getElementById("submit").click();
        }
    }
});