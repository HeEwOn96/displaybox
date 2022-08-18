const myAudio = new Audio();
myAudio.src = "mp3file/errormp3.mp3";


const magnetic = function () {
		$.ajax({
			url: "/api/sensor",
			type: "GET",
			dataType: "json",
			success: function(res) {
				console.log("res : " + res);
			 let result = res.filter(msg => msg.sensor_status);
			 console.log(result[0].sensor_status);
			 if($.trim(result[0].sensor_status) == 3){
			 myAudio.play();
			 console.log("음악실행");
			 }else if($.trim(result[0].sensor_status) == 2){
			 myAudio.pause();
			 console.log("음악종료");
			 }
			},
			error: function(error) {
				console.log("error : " + error)
			}

		})
	}
	

	
setInterval(magnetic, 1000);

