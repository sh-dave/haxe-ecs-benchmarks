package;

import kha.math.FastMatrix4;
import kha.graphics4.*;

class MeshObject {
	public final vertexBuffers: Array<VertexBuffer>;
	public final indexBuffer: IndexBuffer;
	public final structures: Array<VertexStructure>;
	public var material(default, default): Material;

	public final instances: Array<InstancedMeshObject> = [];

	public function new( vertices: Array<Float>, indices: Array<Int> ) {
		structures = [
			createStructure('pos', Float3),
			createStructure('col', Float3, true),
			createStructure('m', Float4x4, true),
		];

		vertexBuffers = [];
		vertexBuffers[0] = new VertexBuffer(Std.int(vertices.length / 3), structures[0], StaticUsage);
		final vbd = vertexBuffers[0].lock();
			for (i in 0...vertices.length) {
				vbd.set(i, vertices[i]);
			}
		vertexBuffers[0].unlock();

		indexBuffer = new IndexBuffer(indices.length, StaticUsage);
		final ibd = indexBuffer.lock();
			for (i in 0...indices.length) {
				ibd.set(i, indices[i]);
			}
		indexBuffer.unlock();
	}

	public function createInstance() : InstancedMeshObject {
		final instance = new InstancedMeshObject(this);
		instances.push(instance);
		return instance;
	}

	public function finishInstantiation() {
		vertexBuffers[1] = new VertexBuffer(instances.length, structures[1], StaticUsage, 1);
		vertexBuffers[2] = new VertexBuffer(instances.length, structures[2], StaticUsage, 1);
	}

	final _mvp = FastMatrix4.identity();

	public function render( g: Graphics, vp: FastMatrix4 ) {
		g.setPipeline(material.pipeline);

		final col = vertexBuffers[1].lock();
			for (i in 0...instances.length) {
				final c = instances[i].color;
				// col.set(i * 3 + 0, c.R);
				// col.set(i * 3 + 1, c.G);
				// col.set(i * 3 + 2, c.B);
				col.set(i * 3 + 0, c.r);
				col.set(i * 3 + 1, c.g);
				col.set(i * 3 + 2, c.b);
			}
		vertexBuffers[1].unlock();

		final transform = vertexBuffers[2].lock();
			for (i in 0...instances.length) {
				_mvp.setFrom(vp.multmat(instances[i].m));
				transform.set(i * 16 + 0, _mvp._00);
				transform.set(i * 16 + 1, _mvp._01);
				transform.set(i * 16 + 2, _mvp._02);
				transform.set(i * 16 + 3, _mvp._03);

				transform.set(i * 16 + 4, _mvp._10);
				transform.set(i * 16 + 5, _mvp._11);
				transform.set(i * 16 + 6, _mvp._12);
				transform.set(i * 16 + 7, _mvp._13);

				transform.set(i * 16 + 8, _mvp._20);
				transform.set(i * 16 + 9, _mvp._21);
				transform.set(i * 16 + 10, _mvp._22);
				transform.set(i * 16 + 11, _mvp._23);

				transform.set(i * 16 + 12, _mvp._30);
				transform.set(i * 16 + 13, _mvp._31);
				transform.set(i * 16 + 14, _mvp._32);
				transform.set(i * 16 + 15, _mvp._33);
			}
		vertexBuffers[2].unlock();

		if (g.instancedRenderingAvailable()) {
			g.setVertexBuffers(vertexBuffers);
			g.setIndexBuffer(indexBuffer);
			g.drawIndexedVerticesInstanced(instances.length);
		} else {
		}
	}

	function createStructure( name, data, ?instanced ) {
		final vs = new VertexStructure();
		vs.add(name, data);

		if (instanced) {
			vs.instanced = true;
		}

		return vs;
	}
}
