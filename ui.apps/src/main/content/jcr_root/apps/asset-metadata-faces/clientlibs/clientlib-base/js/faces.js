(function(document, $) {
    "use strict";

    $(document).on("foundation-contentloaded", function() {
		    var canvas = document.getElementById("facesCanvas");
			var img = new Image;
    		img.src = canvas.getAttribute("data-image");

            img.onload = function() {    
                var ctx = canvas.getContext("2d");
                ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, canvas.width, canvas.height)

                //calculate scale of the canvas as it's rescaled to the box
                var ratio = Math.min((canvas.width / canvas.clientWidth), (canvas.height / canvas.clientHeight))
                var faces = JSON.parse(canvas.getAttribute("data-faces"));

                faces.forEach(function(face) {
					ctx.beginPath();
                    ctx.rect(face.x, face.y, face.width, face.height);
                	ctx.strokeStyle = 'red';
                	ctx.lineWidth = 3 * ratio;
                	ctx.stroke();
                	ctx.closePath();
                });
            }
    });

})(document, Granite.$);
