module zeptus.backend.backend;

import std.parallelism;
import std.concurrency;

import core.sync.mutex;
import core.thread;
import core.time;

import zeptus.instance.instance;
import zeptus.backend.exceptions;

abstract class Backend {
public:
	this() {
		isRunning = false;
		thread = new Thread(&loopThread);
	}
	
	void Start() {
		if (isRunning)
			throw new BackendAlreadyRunningException();
		synchronized (instancesMutex) {
			foreach (i, ref Instance instance; instances)
				instance.Start();
		}
		thread.start();
	}
	
	void Stop() {
		if (!isRunning)
			throw new BackendNotRunningException();
		quitThread = true;
		synchronized (instancesMutex) {
			foreach (i, ref Instance instance; instances)
				instance.Stop();
		}
	}	

	void Add(string name, Instance instance) {
		synchronized (instancesMutex) {
			if (auto tmp = name in instances)
				throw new BackendInstanceAlreadyExistException();
			instance.Start();
			instances[name] = instance;
		}
	}

	void Remove(string name) {
		synchronized (instancesMutex) {
			if (auto instance = name in instances) {
				instances.remove(name);
				instance.Stop();
				destroy(instance);
			} else
				throw new BackendInstanceDoesNotExistException();
		}
	}

	@property Instance[string] Instances() { return instances; }
	@property bool IsRunning() { return isRunning; }
protected:
	Instance[string] instances;
	Mutex instancesMutex;

	abstract void loop();
private:
	Thread thread;
	bool isRunning;
	bool quitThread;
	
	void loopThread() {
		isRunning = true;
		quitThread = false;
		while (!quitThread) {
			loop();
		}
		isRunning = false;
	}
}
