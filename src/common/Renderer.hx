package;

import kha.Canvas;
import kha.Color;
import kha.graphics4.*;
import kha.math.*;
import kha.Scheduler;

class Renderer {
	final view = FastMatrix4.identity();
	final projection = FastMatrix4.perspectiveProjection(45, 4 / 3, 0.1, 100);
	final vp = FastMatrix4.identity();
	final mvp = FastMatrix4.identity();
	final lookAt = new FastVector3(0, 0, 0);
	final up = new FastVector3(0, 1, 0);
	// final cameraStart = new FastVector4(0, 5, 7.5);
	final cameraStart = new FastVector4(0, 5 * 5, 7.5 * 5);
	// final clearColor = Color.fromFloats(1, 0.75, 0);
	final clearColor = Color.fromBytes(0, 0x80, 0x80);

	public function new() {
	}

	public function begin( canvas: Canvas ) {
		final g = canvas.g4;
		final cameraPos4 = cameraStart;//FastMatrix4.rotationY(Scheduler.time() / 4).multvec(cameraStart);
		final cameraPos3 = new FastVector3(cameraPos4.x, cameraPos4.y, cameraPos4.z);
		view.setFrom(FastMatrix4.lookAt(cameraPos3, lookAt, up));
		vp.setFrom(projection.multmat(view));

		g.begin();
		g.clear(clearColor, 1.0);
	}

	public function render( canvas: Canvas, o: MeshObject ) {
		o.render(canvas.g4, vp);
	}

	public function end( canvas: Canvas ) {
		final g = canvas.g4;
		g.end();
	}
}
