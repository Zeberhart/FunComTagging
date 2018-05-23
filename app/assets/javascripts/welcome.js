var MAX_WORDS = 12;

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
    	try{
        	range.setEnd(range.endContainer, range.endOffset + 1);
        }catch(err){
        	break;
        }
    }
    range.setEnd(range.endContainer, range.endOffset - 1);
}

function mouseUpW() {
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
                while (text.split(" ").length > MAX_WORDS) {
                    selectionRange.setEnd(selectionRange.endContainer, selectionRange.endOffset - 1);
                    text = window.getSelection().toString();
                }
            	document.getElementById("confirmationW").innerHTML = text;
            }
        }
    }else{
        document.getElementById("confirmationW").innerHTML = "";
    }
}

function otherMouseUp() {
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
                while (text.split(" ").length > MAX_WORDS) {
                    selectionRange.setEnd(selectionRange.endContainer, selectionRange.endOffset - 1);
                    text = window.getSelection().toString();
                }
            }
        }
    }
}

$(document).on('turbolinks:load', function() {
    $("#commentW").on("mouseup", function(){
        mouseUpW();
    });
    $(".comment").on("mouseup", function(){
        otherMouseUp();
    });
});