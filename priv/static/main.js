(function(){
  var RTCPeerConn;
  var RTCSessionDescription;
  var localVideo = null;
  var hangupBtn = null;

  function startup(){
    hangupBtn = document.getElementById("hangup-btn");
    var RTCPeerConn = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
    var RTCSessionDescription = window.RTCSessionDescription || mozRTCSessionDescription || webkitRTCSessionDescription;
    localVideo = document.getElementById("local-video");
    navigator.getUserMedia = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia;
    navigator.getUserMedia(
      {video: true, audio: true},
      function(stream){
        if (navigator.mozGetUserMedia){
          localVideo.mozSrcObject = stream;
        } else {
          var vendorURL = window.URL || window.webkitURL;
          localVideo.src = vendorURL.createObjectURL(stream);
        }
        localVideo.play();
      },
      function(err){
        console.log("Error accessing video/audio device: " + err);
      }
      );
    hangupBtn.addEventListener("click", function(ev){
      console.log("hanguped");
      ev.preventDefault();
    }, false);
  }
  window.addEventListener('load', startup, false);
})();
