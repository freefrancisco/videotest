var OPENTOK_API_KEY = "23245152";
var OPENTOK_API_SECRET = "40076ed626d1bcc90391c8c1e40ef1ea71fdbd70";

var opentok = Npm.require("opentok");
Fiber  = Npm.require("fibers");
OpenTok = new opentok.OpenTokSDK(OPENTOK_API_KEY, OPENTOK_API_SECRET);
