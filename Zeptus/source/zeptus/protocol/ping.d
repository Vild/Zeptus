module zeptus.protocol.ping;

import zeptus.protocol.iping;

class Ping : IPing {
	override string getPing(string ping) {
		return "Pong: " ~ ping;
	}
}

