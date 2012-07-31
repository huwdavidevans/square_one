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



function drawCircleIn(divID, colour) {
	var myDiv = $('#'+divID)[0];
	var _w = myDiv.width;
	var _h = myDiv.height;
	var ctx = myDiv.getContext("2d");

	var radius; (_w > _h) ? radius = (_h - 4) / 2 : radius = (_w - 4) / 2; 
	colour == null ? ctx.fillStyle = "#444" : ctx.fillStyle = colour;
	ctx.beginPath();
	//arc(x, y, radius, startAngle, endAngle, anticlockwise);
	ctx.arc(_w / 2, _h / 2, radius, 0, Math.PI * 2, true);
	ctx.closePath();
	ctx.fill();
}



function drawPieIn(divID, slicePercent, colour) {
	var colArray = ["#00df00", "#5fdf00", "#9fdf00", "#dfdf00", "#ffdf00", "#ffbf00", "#ff9f00", "#ff7f00", "#ff3f00", "#ff0000"]
	
	drawCircleIn(divID, "#aeaeae");
	
	if(slicePercent > 0) {

		var myDiv = $('#'+divID)[0];
		var _w = myDiv.width;
		var _h = myDiv.height;
		var ctx = myDiv.getContext("2d");

		var radius; (_w > _h) ? radius = (_h - 8) / 2 : radius = (_w - 8) / 2;

		var startAngle = (Math.PI / -2);
		var endAngle = (Math.PI * 2) * Number(slicePercent) ; 
		
		colour == null ? ctx.fillStyle = colArray[parseInt(slicePercent * 9 ,10)] : ctx.fillStyle = colour;
		console.log(ctx.fillStyle)
		
		ctx.beginPath();
		//arc(x, y, radius, startAngle, endAngle, anticlockwise);
		ctx.arc(_w / 2, _h / 2, radius, startAngle, startAngle+endAngle, false);
		ctx.lineTo(_w / 2, _h / 2);
		ctx.closePath();
		ctx.fill();
	}
	
	
		if(slicePercent > 1) {

		var myDiv = $('#'+divID)[0];
		var _w = myDiv.width;
		var _h = myDiv.height;
		var ctx = myDiv.getContext("2d");
		var radius; (_w > _h) ? radius = (_h - 8) / 2 : radius = (_w - 8) / 2;
		var startAngle = 0;
		var endAngle = (Math.PI * 2) ; 
		ctx.fillStyle = colArray[colArray.length-1]
		ctx.beginPath();
		//arc(x, y, radius, startAngle, endAngle, anticlockwise);
		ctx.arc(_w / 2, _h / 2, radius, startAngle, endAngle, false);
		ctx.lineTo(_w / 2, _h / 2);
		ctx.closePath();
		ctx.fill();
	}
}