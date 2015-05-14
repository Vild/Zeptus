module zeptus.event.event;

abstract class Event {
public:

	
	@property string Name() { return name; }

private:
	string name;
}
