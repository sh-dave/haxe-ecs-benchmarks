package system;

import component.*;
import exp.ecs.Engine;
import exp.ecs.node.*;
import exp.ecs.system.*;

using tink.CoreApi;

class RenderSystem<Event> extends System<Event> {
	
	@:nodes var nodes:Node<Position, Display>;
	
	var listeners:CallbackLink;
	
	#if openfl
	var container:openfl.display.DisplayObjectContainer;
	
	public function new(container) {
		super();
		this.container = container;
	}
	#end
	
	override function onAdded(engine:Engine<Event>) {
		super.onAdded(engine);
		for(node in nodes) addToDisplay(node);
		listeners = [
			nodes.nodeAdded.handle(addToDisplay),
			nodes.nodeRemoved.handle(removeFromDisplay),
		];
	}
	
	override function onRemoved(engine:Engine<Event>) {
		for(node in nodes) removeFromDisplay(node);
		super.onRemoved(engine);
		listeners.dissolve();
		listeners = null;
	}
	
	function addToDisplay(node:Node<Position, Display>) {
		#if openfl
		container.addChild(node.display.object);
		#elseif luxe
		node.display.object.visible = true;
		#end
	}
	
	function removeFromDisplay(node:Node<Position, Display>) {
		#if openfl
		container.removeChild(node.display.object);
		#elseif luxe
		node.display.object.destroy();
		#end
	}
	
	override function update(dt:Float) {
		for(node in nodes) {
			var display = node.display.object;
			var position = node.position;
			#if openfl display.x #elseif luxe display.pos.x #end = position.position.x;
			#if openfl display.y #elseif luxe display.pos.y #end = position.position.y;
			#if openfl display.rotation #elseif luxe display.rotation_z #end = position.rotation * 180 / Math.PI;
		}
	}
}