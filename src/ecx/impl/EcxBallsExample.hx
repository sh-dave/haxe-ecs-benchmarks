package impl;

// import iron.object.Object;
// import iron.Scene;

class EcxBallsExample extends System {
	public static function run() {
		kha.System.start({}, function( _ ) {
			new EcxBallsExample(/*scene*/);
		});

		// BallsExampleScene.create(function( scene ) {
		// 	new EcxBallsExample(/*scene*/);
		// });
	}

	function new( /*scene*/ ) {
		final wc = new ecx.WorldConfig();
		wc.add(new Collider());
		wc.add(new Colliding());
		wc.add(new Collisionable());
		wc.add(new Moving());
		wc.add(new Object3D());
		wc.add(new PulsatingColor());
		wc.add(new PulsatingScale());
		wc.add(new Recovering());
		wc.add(new Rotating());
		wc.add(new Timeout());

		wc.add(new ecx.common.systems.SystemRunner());
		wc.add(new UpdateService());
		wc.add(new TimeSystem());
		wc.add(this);

		wc.add(new RotatingSystem());
		wc.add(new PulsatingColorSystem());
		wc.add(new PulsatingScaleSystem());
		wc.add(new TimeoutSystem());
		wc.add(new ColliderSystem());
		wc.add(new MovingSystem());

		ecx.Engine.createWorld(wc);
	}

	var _o3d: Wire<Object3D>;
	var _pcolor: Wire<PulsatingColor>;
	var _pscale: Wire<PulsatingScale>;
	var _moving: Wire<Moving>;
	var _collisionable: Wire<Collisionable>;
	var _collider: Wire<Collider>;
	var _rotating: Wire<Rotating>;

	override function initialize() {
		final scene = new Scene();

// ball entity
		{
			final cubeData = Cube.build();
			final cube = new MeshObject(cubeData.vertices, cubeData.indices);
			scene.meshObjects.push(cube);
			cube.material = new Material(cube.structures);
			// material.diffuseColor = Color.fromFloats(1, 1, 1);

			for (i in 0...1) {
				final inst = cube.createInstance();
				final pos = Utils.randomSpherePoint(C.SPHERE_RADIUS);
				inst.position.x = pos.x;
				inst.position.y = pos.y;
				inst.position.z = pos.z;
				inst.color.r = 0;
				inst.color.g = 1;
				inst.color.b = 0;

				final e = world.create();
				_o3d.create(e).object = inst;
				_rotating.create(e);
				// _pcolor.create(e).offset = i;
				// _pscale.create(e).offset = i;

				// if (Math.random() > 0.5) {
					// _moving.create(e).offset = i;
				// }

				// _collisionable.create(e);
				_collider.create(e);
				world.commit(e);
			}

			cube.finishInstantiation();
		}

// box entities
		{
			final cubeData = Cube.build();
			final cube = new MeshObject(cubeData.vertices, cubeData.indices);
			scene.meshObjects.push(cube);
			cube.material = new Material(cube.structures);
			// material.diffuseColor = Color.fromFloats(1, 1, 1);

			for (i in 0...C.NUM_OBJECTS) {
				final inst = cube.createInstance();
				final pos = Utils.randomSpherePoint(C.SPHERE_RADIUS);
				inst.position.x = pos.x;
				inst.position.y = pos.y;
				inst.position.z = pos.z;

				final e = world.create();
				_o3d.create(e).object = inst;
				_pcolor.create(e).offset = i;
				_pscale.create(e).offset = i;

				if (Math.random() > 0.5) {
					_moving.create(e).offset = i;
				}

				_collisionable.create(e);
				world.commit(e);
			}

			cube.finishInstantiation();
		}

		var r = new Renderer();

		kha.System.notifyOnFrames(function( fbs ) {
			final canvas = fbs[0];

			r.begin(canvas);
				for (object in scene.meshObjects) {
					r.render(canvas, object);
				}
			r.end(canvas);
		});
	}
}
