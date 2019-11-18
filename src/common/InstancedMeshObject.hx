package;

// import kha.Color;
import kha.math.*;

@:structInit class Color {
	public var r: Float;
	public var g: Float;
	public var b: Float;
}

class InstancedMeshObject {
	public final root: MeshObject;

	public final position = new FastVector3(0, 0, 0);
	public final scaling = new FastVector3(1, 1, 1);
	public final rotation = new FastVector3(0, 0, 0);
	public var color(default, default): Color = { r: 1, g: 1, b: 0 }//, Color.White;

	public var m(get, never): FastMatrix4; // TODO (DK) make this an abstract into the vertex buffer?

	public function new( root: MeshObject ) {
		this.root = root;
	}

	inline function get_m() return FastMatrix4//.identity()
		/*.multmat(FastMatrix4*/.rotation(rotation.x, rotation.y, rotation.z)/*)*/
		.multmat(FastMatrix4.translation(position.x, position.y, position.z))
		.multmat(FastMatrix4.scale(scaling.x, scaling.y, scaling.z))
		;
}
