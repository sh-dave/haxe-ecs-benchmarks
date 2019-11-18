package impl;

class EcsBallsExample {
	public static function run() {
		kha.System.start({}, function( _ ) {
			new EcsBallsExample();
		});
	}

	function new() {
		final scene = new Scene();
		final engine = new Engine<BallsEvent>();
		engine.systems.add(new RotatingSystem());
		engine.systems.add(new PulsatingColorSystem());
		engine.systems.add(new PulsatingScaleSystem());
		engine.systems.add(new TimeoutSystem());
		engine.systems.add(new MovingSystem());
		engine.systems.add(new ColliderSystem());

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

				final entity = new Entity('ball-$i');
				entity.add(new Object3D(inst));
				entity.add(new Rotating(0.5));

					entity.add(new Moving(i));

				entity.add(new Collider());
				engine.entities.add(entity);
			}

			cube.finishInstantiation();
		}

// box entities
		{
			final cubeData = Cube.build({ size: 0.15 });
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

				final entity = new Entity('box-$i');
				entity.add(new Object3D(inst));
				entity.add(new PulsatingColor(i));
				entity.add(new PulsatingScale(i));

				if (Math.random() > 0.5) {
					entity.add(new Moving(i));
				}

				entity.add(new Collisionable());
				engine.entities.add(entity);
			}

			cube.finishInstantiation();
		}

		var lastTime = kha.Scheduler.time();

		kha.Scheduler.addTimeTask(function() {
			final now = kha.Scheduler.time();
			final delta = now - lastTime;
			lastTime = now;

			final updateStartTime = kha.Scheduler.realTime();
			engine.update(delta);
			final updateEndTime = kha.Scheduler.realTime();
			final tickDuration = updateEndTime - updateStartTime;
			trace('tick: $tickDuration');
		}, 0, 1 / 60);

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
