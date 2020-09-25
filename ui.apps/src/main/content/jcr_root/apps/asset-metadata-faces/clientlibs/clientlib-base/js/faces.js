(function(document, $) {
    "use strict";

    $(document).on("foundation-contentloaded", function() {
		    var canvas = document.getElementById("facesCanvas");
			var img = new Image;
    		img.src = canvas.getAttribute("data-image");

            img.onload = function() {    
                var ctx = canvas.getContext("2d");
                ctx.drawImage(img, 0, 0);

                var faces = JSON.parse(canvas.getAttribute("data-faces"));

                faces.forEach(function(face) {
					ctx.beginPath();
                    ctx.rect(face.x, face.y, face.width, face.height);
                	ctx.strokeStyle = 'red';
                	ctx.lineWidth = 3;
                	ctx.stroke();
                	ctx.closePath();
                });
            }
    });

})(document, Granite.$);
