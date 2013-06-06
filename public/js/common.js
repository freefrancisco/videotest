TB.addEventListener("exception", exceptionHandler);

var session = TB.initSession(sessionID); // Replace with your own session ID. See https://dashboard.tokbox.com/projects
session.addEventListener("streamCreated", streamCreatedHandler);
session.connect(apiKey, tokenID);

function streamCreatedHandler(event) {
	subscribeToStreams(event.streams);
}

function subscribeToStreams(streams) {
	for (var i = 0; i < streams.length; i++) {
		var stream = streams[i];
		if (stream.connection.connectionId != session.connection.connectionId) {
			session.subscribe(stream);
		}
	}
}

function exceptionHandler(event) {
	alert(event.message);
}

