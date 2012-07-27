// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .



function drawCircleIn(divID, colour){

	var myDiv = $('#'+divID)[0];
	var _w = myDiv.width;
	var _h = myDiv.height;
	var ctx = myDiv.getContext("2d");
	
	var radius ;
	(_w > _h) ? radius = (_h-4)/2 : radius = (_w-4)/2;

	colour == null ? ctx.fillStyle = "#666" : ctx.fillStyle = colour;
	ctx.beginPath();
	//arc(x, y, radius, startAngle, endAngle, anticlockwise);
	ctx.arc(_w/2, _h/2, radius, 0, Math.PI*2, true); 
	ctx.closePath();
	ctx.fill();
	
}
