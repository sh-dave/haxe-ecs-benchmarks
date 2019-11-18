package;

import kha.graphics4.*;
import kha.Shaders;

class Material {
	public final pipeline: PipelineState;

	public function new( structures ) {
		pipeline = new PipelineState();
		pipeline.fragmentShader = Shaders.balls_example_frag;
		pipeline.vertexShader = Shaders.balls_example_vert;
		pipeline.inputLayout = structures;
		pipeline.depthWrite = true;
		pipeline.depthMode = CompareMode.Less;
		pipeline.cullMode = CullMode.Clockwise;//CounterClockwise;
		pipeline.compile();
	}
}
