package impl;

class Object3D extends Component {
	public var object: InstancedMeshObject;
	// public var object: iron.object.MeshObject;

	public function new( object ) {
		this.object = object;
	}
}
