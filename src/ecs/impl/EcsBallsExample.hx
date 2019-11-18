package impl;

// import iron.object.Object;
// import iron.Scene;

class EcsBallsExample {
	public static function run() {
		kha.System.start({}, function( _ ) {
			new EcsBallsExample(/*scene*/);
		});

		// BallsExampleScene.create(function( scene ) {
			// new EcsBallsExample(/*scene*/);
		// });
	}

	function new( /*scene: Object*/ ) {
		final scene = new Scene();
		final engine = new Engine<BallsEvent>();
		engine.systems.add(new RotatingSystem());
		engine.systems.add(new PulsatingColorSystem());
		engine.systems.add(new PulsatingScaleSystem());
		engine.systems.add(new TimeoutSystem());
		engine.systems.add(new ColliderSystem());
		engine.systems.add(new MovingSystem());

// sphere entity
		{
		// final objMoving = BABYLON.MeshBuilder.CreateIcoSphere('sphere',{subdivisions: 1}, scene);
		// var material = new BABYLON.StandardMaterial();
		// material.diffuseColor.set(1,1,0);
		// objMoving.material = material;
			// final objMoving = iron.object.builder.IcoSphere.build('sphere', { subdivisions: 10 }/*, scene*/);
			// scene.addChild(objMoving);
			// final sphere = new Entity('sphere');
			// sphere.add(new Collider());
			// sphere.add(new Object3D(objMoving));
			// sphere.add(new Rotating(0.5));
			// engine.entities.add(sphere);
		// var radius = 10;
		// objMoving.setPivotMatrix(BABYLON.Matrix.Translation(0, 0, radius), false);
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

				final entity = new Entity('box-$i');
				entity.add(new Object3D(inst));
				entity.add(new PulsatingColor(i));
				entity.add(new PulsatingScale(i));

				if (Math.random() > 0.5) {
					entity.add(new Moving(i));
				}

				entity.add(new Collisionable());
				engine.entities.add(entity);

				// inst.position.setFrom(randomSpherePoint(5));
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
