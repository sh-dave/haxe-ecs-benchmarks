# ecs-bench

- benchmarking some haxe ecs implementations
- based on the balls example in the [mozilla ecsy library](https://github.com/MozillaReality/ecsy)

# libraries

- ecx
- exp-ecs (using a renamed version (expx), as it won't even compile with hxcpp -.-)

# benchmarks

## javascript 0x10000 objects

### ecx

- instant startup time
- 60 fps? (looks smooth)
- 763.2k kha.js

```
impl/UpdateService.hx:23: tick: 0.006999999983236194
impl/UpdateService.hx:23: tick: 0.006999999983236194
impl/UpdateService.hx:23: tick: 0.007400000002235174
impl/UpdateService.hx:23: tick: 0.007299999997485429
impl/UpdateService.hx:23: tick: 0.007500000006984919
impl/UpdateService.hx:23: tick: 0.006699999998090789
impl/UpdateService.hx:23: tick: 0.006800000002840534
impl/UpdateService.hx:23: tick: 0.006800000002840534
impl/UpdateService.hx:23: tick: 0.007000000012340024
impl/UpdateService.hx:23: tick: 0.007000000012340024
impl/UpdateService.hx:23: tick: 0.007100000017089769
impl/UpdateService.hx:23: tick: 0.008199999982025474
impl/UpdateService.hx:23: tick: 0.007199999992735684
```

### ecs

- ~10s startup time
- 1 or 2 fps
- 845.7k kha.js

```
impl/EcsBallsExample.hx:89: tick: 0.024399999994784594
impl/EcsBallsExample.hx:89: tick: 0.024199999985285103
impl/EcsBallsExample.hx:89: tick: 0.024099999980535358
impl/EcsBallsExample.hx:89: tick: 0.024799999984679744
impl/EcsBallsExample.hx:89: tick: 0.02429999999003485
impl/EcsBallsExample.hx:89: tick: 0.02470000000903383
impl/EcsBallsExample.hx:89: tick: 0.02449999999953434
impl/EcsBallsExample.hx:89: tick: 0.02449999999953434
impl/EcsBallsExample.hx:89: tick: 0.02410000000963919
impl/EcsBallsExample.hx:89: tick: 0.02449999999953434
impl/EcsBallsExample.hx:89: tick: 0.02530000000842847
impl/EcsBallsExample.hx:89: tick: 0.024400000023888424
impl/EcsBallsExample.hx:89: tick: 0.024200000014388934
```
