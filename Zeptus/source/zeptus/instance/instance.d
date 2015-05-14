module zeptus.instance.instance;

import zeptus.event.event;
import zeptus.script.script;

class Instance {
public:

	this() {

	}
	
	void Start() {
		
	}

	
	void Stop() {
		
	}

	void ProcessEvent(Event event) {
		foreach (i, ref Script script; scripts)
			script.ProcessEvent(event);
	}

private:
	Script[string] scripts;
}
