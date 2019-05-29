precision mediump float;
uniform vec2 resolution;
uniform float time;

uniform vec3 camPos;
uniform vec3 camRot;

#define MAX_STEPS 64
#define TOLERANCE 0.5
#define EPSILON 0.5

// A basic fractal
float map(vec3 pos) {
  vec3 offset = fract(pos) * 2.0 - 1.0;
  return length(offset) - 0.40;
}

// // Just a sphere
// float map(vec3 p) {
  //   return length(p) - 1.0;
// }

// Find distance to map
float trace(vec3 origin, vec3 direction) {
  float depth = 0.0;

  for(int i = 0; i < MAX_STEPS; i ++ ) {
    float minDist = map(origin + direction * depth);
    depth += minDist * TOLERANCE;
  }

  return depth;
}

float brightness(vec3 origin, vec3 direction) {
  float dist = trace(camPos, direction);

  // This needs so
  vec3 normal = normalize(vec3(
    trace(vec3(origin.x + EPSILON, origin.y, origin.z), direction) + trace(vec3(origin.x - EPSILON, origin.y, origin.z), direction),
    trace(vec3(origin.x, origin.y + EPSILON, origin.z), direction) - trace(vec3(origin.x, origin.y + EPSILON, origin.z), direction),
    trace(vec3(origin.x, origin.y, origin.z + EPSILON), direction) - trace(vec3(origin.x, origin.y, origin.z + EPSILON), direction)
  ));

  float fog = (1.0 / (1.0 + dist + dist * 0.1));
  return fog;
}

void main() {
  // Position (origin) of ray on screen
  vec2 pos = gl_FragCoord.xy / resolution;
  pos = pos * 2.0 - 1.0;

  // Direction of ray
  vec3 direction = normalize(vec3(pos, 1.0));

  // Rotation matrix
  direction.yz *= mat2(cos(camRot.x), sin(camRot.x), -sin(camRot.x), cos(camRot.x));  // X
  direction.xz *= mat2(cos(camRot.y), - sin(camRot.y), sin(camRot.y), cos(camRot.y)); // Y
  direction.xy *= mat2(cos(camRot.z), sin(camRot.z), -sin(camRot.z), cos(camRot.z));  // Z

  float b = brightness(camPos, direction);
  vec3 color = vec3(b);

  gl_FragColor = vec4(color, 1.0);
}