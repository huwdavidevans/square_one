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


function convertAngle(amt, degrees){
	degrees = typeof degrees !== 'undefined' ? degrees : true;
	var output = 0;	
	if (degrees){
		//output radians
		output = amt * (Math.PI / 180);
	} else{
		//output degrees
		output = amt * (180 / Math.PI);
	}	
	return output;
}


function angleObject(angle){
	var angleType = String(angle).charAt(angle.length-1);
	angle = Number(angle.split(angleType)[0]);
	switch (angleType){		
		case '%' :
			this.percent = angle;
			this.degrees = 360 * angle;
			this.radians = convertAngle(this.degrees);
		break;
		case 'd' :
			this.degrees = angle;
			this.percent = this.degrees / 360;
			this.radians = convertAngle(this.degrees);
		break;		
		case 'r' :
			this.radians = angle;
			this.degrees = convertAngle(this.degrees, false);
			this.percent = this.degrees / 360;
		break;
	}	
}


function drawPi(myDiv, start, amount, radiusPadding, colour){	
	colour = typeof colour !== 'undefined' ? colour : "#444";
	var ctx = myDiv.getContext("2d");
	var _s = new angleObject(start);
	var _e = new angleObject(amount);
	var ninetyDeg = convertAngle(90);
	var _w = myDiv.width;
	var _h = myDiv.height;
	var radius; (_w > _h) ? radius = (_h - radiusPadding) / 2 : radius = (_w - radiusPadding) / 2;
	ctx.fillStyle = colour;	
	ctx.beginPath();
	ctx.arc(_w / 2, _h / 2, radius, _s.radians-ninetyDeg, _s.radians+_e.radians-ninetyDeg, false);	
	
	if (_e.percent < 1){
		ctx.strokeStyle = '#888'
		ctx.lineWidth  = 0.5;
		ctx.lineTo(_w / 2, _h / 2);
		ctx.closePath();
		ctx.stroke();
	} else{
		ctx.closePath();
	}
	
	ctx.fill();
	
	return ctx;
}

function drawTaskPie(divID, slicePercent) {	
	var colArray = ["#00df00", "#5fdf00", "#9fdf00", "#dfdf00", "#ffdf00", "#ffbf00", "#ff9f00", "#ff7f00", "#ff3f00", "#ff0000"]
	var colour = colArray[parseInt(slicePercent * 9, 10)];	
	var myDiv = $('#'+divID)[0];	
	var ctx = myDiv.getContext("2d");
	var clockFace = new Image();
	
	clockFace.onload = function() {
			//draw background circle
			drawPi(myDiv, '0%', '1%', 4, "#aeaeae");
			ctx.save();			
			//draw time pie		
			if(slicePercent > 0) {
				drawPi(myDiv, '0d', slicePercent+'%', 5, colour);
				console.log(colour)
			} else if(slicePercent > 1) {
				drawPi(myDiv, '0%', '1%', 5, colArray[colArray.length-1]);
			}
	       ctx.drawImage(clockFace, 0, 0);
	  }
	clockFace.src = "/assets/clock_overlay.png";
}






