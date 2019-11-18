let prj = new Project('ecs-bench');
const os = require('os');

prj.addTarget('ecx-debug-html5', 'debug-html5', ['debug-html5']);
prj.addTarget('ecs-debug-html5', 'debug-html5', ['debug-html5']);
prj.addTarget('ecx-flash', 'flash', ['flash']);

switch (os.platform()) {
	case 'win32':
		prj.addTarget('ecx-native', 'windows', ['windows']);
		prj.addTarget('ecs-native', 'windows', ['windows']);
		break;
	case 'linux':
		prj.addTarget('ecx-native', 'linux', ['linux']);
		prj.addTarget('ecs-native', 'linux', ['linux']);
		break;
	default:
		reject(`unmapped os platform=${os.platform()} `);
}

prj.addDefine('analyzer_optimize');
prj.addParameter('-dce full');

prj.localLibraryPath = 'libs';

// prj.addLibrary('iron');
	// prj.addDefine('arm_batch'); // instancing
// prj.addLibrary('iron-builder');
prj.addSources('src/common');

const variant =
	platform.indexOf('ecx') != -1
	? 'ecx'
	: platform.indexOf('ecs') != -1
		? 'ecs'
		: undefined;

switch (variant) {
	case 'ecx':
		prj.addLibrary('ecx');
		prj.addLibrary('ecx-common');
		prj.addSources('src/ecx');
		break;
	case 'ecs':
		prj.addLibrary('expx-ecs');
		prj.addSources('src/ecs');
		break;
}

if (platform.indexOf('flash') != -1) {
	prj.addDefine('fdb');
}

prj.addAssets('assets/**');
prj.addShaders('shaders/**');

resolve(prj);
