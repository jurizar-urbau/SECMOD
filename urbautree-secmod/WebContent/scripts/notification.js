(function () {
	'use strict';
	
	angular
		.module("formsApp")
		.factory('notifications', notifications);
	
	function notifications() {
		function setNotification(titleMsg,textMsg){
			$.gritter.add({
				// (string | mandatory) the heading of the notification
				title: titleMsg,
				// (string | mandatory) the text inside the notification
				text: textMsg,
				// (string | optional) the image to display on the left
				// (bool | optional) if you want it to fade out on its own or just sit there
				sticky: false,
				// (int | optional) the time you want it to be alive for before fading out
				time: 1000
			});
		}
		return {
			setNotification : setNotification
		}
	}
})();
