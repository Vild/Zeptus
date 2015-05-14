module zeptus.backend.exceptions;

import std.exception;

class BackendException : Exception {
	this(string file = __FILE__, ulong line = cast(ulong)__LINE__) { // Adds a default constructor
		super("", file, line);
	}
}

class BackendAlreadyRunningException : BackendException {}

class BackendNotRunningException : BackendException {}

class BackendInstanceAlreadyExistException : BackendException {}

class BackendInstanceDoesNotExistException : BackendException {}


