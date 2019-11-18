package expx.ecs.system;

import expx.ecs.*;
import expx.ecs.node.*;
using tink.CoreApi;

interface SystemBase<Event> {
	function update(dt:Float):Void;
	function onAdded(engine:Engine<Event>):Void;
	function onRemoved(engine:Engine<Event>):Void;
}