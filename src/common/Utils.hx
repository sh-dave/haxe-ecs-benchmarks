package;

class Utils {
	public static function randomSpherePoint(radius) {
		var u = Math.random();
		var v = Math.random();
		var theta = 2 * Math.PI * u;
		var phi = Math.acos(2 * v - 1);
		var x = radius * Math.sin(phi) * Math.cos(theta);
		var y = radius * Math.sin(phi) * Math.sin(theta);
		var z = radius * Math.cos(phi);
		return {x:x,y:y,z:z};
	}
}