precision mediump float;
uniform vec2 resolution;
uniform float time;

uniform vec3 camPos;
uniform vec3 camRot;

#define MAX_STEPS 32
#define EPSILON 0.5

float map(vec3 p) {
  vec3 q = fract(p) * 2.0 - 1.0;
  return length(q) - 0.25;
}

// float map(vec3 p) {
  //   return length(p) - 1.0;
// }

// Find distance to map
float trace(vec3 o, vec3 r) {
  float depth = 0.0;

  for(int i = 0; i < MAX_STEPS; i ++ ) {
    float d = map(o + r * depth);
    depth += d * EPSILON;
  }

  return depth;
}

void main() {
  // Position (origin) of ray on screen
  vec2 pos = gl_FragCoord.xy / resolution;
  pos = pos * 2.0 - 1.0;

  // Direction of ray
  vec3 direction = normalize(vec3(pos, 1.0));

  // Rotation matrix
  // direction.xz *= mat2(cos(time / 4.0), - sin(time / 4.0), sin(time / 4.0), cos(time / 4.0));
  direction.yz *= mat2(cos(camRot.x), sin(camRot.x), -sin(camRot.x), cos(camRot.x));  // X
  direction.xz *= mat2(cos(camRot.y), - sin(camRot.y), sin(camRot.y), cos(camRot.y)); // Y
  direction.xy *= mat2(cos(camRot.z), sin(camRot.z), -sin(camRot.z), cos(camRot.z));  // Z

  float dist = trace(camPos, direction);
  float fog = 1.0 / (1.0 + dist + dist * 0.1);
  vec3 color = vec3(fog);

  gl_FragColor = vec4(color, 1.0);
}