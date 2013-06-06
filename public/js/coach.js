function sessionConnectedHandler(event) {
	 subscribeToStreams(event.streams);
	 session.publish();
}
