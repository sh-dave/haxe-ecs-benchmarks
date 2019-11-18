package expx.ecs.system;

import expx.ecs.event.*;
using tink.CoreApi;

/**
 * A System that monitors and handles events from the engine event bus.
 */
class EventHandlerSystem<Event, Data> extends System<Event> {

	var binding:CallbackLink;

	/**
	 * Override this function to filter and extract data from an event in the event bus.
	 * If you are not interested in a event, simply return `None`.
	 * Otherwise if `Some(data)` is returned from this function, the `handle` function will be invoked accordingly.
	 * @param event
	 * @return Option<Data>
	 */
	function select(event:Event):Option<Data>
		return None;

	/**
	 * Override this function to handle event data selected by the `select` function.
	 * You can produce the desired effect right in this function.
	 * Or you can also store up the data and handle them later, e.g. in the `update` function
	 * @param data
	 */
	function handle(data:Data) {}

	override function onAdded(engine) {
		super.onAdded(engine);
		binding = engine.events.select(select).handle(handle);
	}

	override function onRemoved(engine) {
		super.onRemoved(engine);
		binding.dissolve();
	}

	public static inline function simple(selector, handler)
		return new SimpleEventHandlerSystem(selector, handler);
}

class SimpleEventHandlerSystem<Event, Data> extends EventHandlerSystem<Event, Data> {

	var selector:EventSelector<Event, Data>;
	var handler:Callback<Data>;

	public function new(selector, handler) {
		super();
		this.selector = selector;
		this.handler = handler;
	}

	override function select(event:Event):Option<Data>
		return selector(event);

	override function handle(data:Data) {
		handler.invoke(data);
	}
}
