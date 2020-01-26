precision mediump float;
uniform vec2 resolution;
uniform float time;

vec3 light = vec3(1, 1, -1);
// vec3 light = vec3(1, 1, 1);
vec3 direction;

uniform vec3 camPos;
uniform vec3 camRot;

#define MAX_STEPS 64
#define TOLERANCE 0.5
#define EPSILON 0.00005

// A basic fractal
float map(vec3 pos) {
  vec3 offset = fract(vec3(pos.x * pos.y / 2.0, pos.y, pos.z)) * 2.0 - 1.0;
  return length(offset) - 0.4;
}

// // Just a sphere
// float map(vec3 p) {
  //   return length(p) - 1.0;
// }

// Find distance to map
float trace(vec3 origin) {
  float depth = 0.0;

  for(int i = 0; i < MAX_STEPS; i ++ ) {
    float minDist = map(origin + direction * depth);
    depth += minDist * TOLERANCE;
  }

  return depth;
}

vec3 getNormal(vec3 o) {
  return normalize(vec3(
    trace(vec3(o.x + EPSILON, o.y, o.z)) - trace(vec3(o.x - EPSILON, o.y, o.z)),
    trace(vec3(o.x, o.y + EPSILON, o.z)) - trace(vec3(o.x, o.y - EPSILON, o.z)),
    trace(vec3(o.x, o.y, o.z + EPSILON)) - trace(vec3(o.x, o.y, o.z - EPSILON))
  ));
}

float brightness(vec3 o) {
  float dist = trace(camPos);
  vec3 normal = getNormal(o);

  float normalLight = max(0.0, dot(normal, light));

  float fog = (1.0 / (1.0 + dist * dist * 0.1)) * (normalLight);
  // float fog =  normalLight / dist;
  return fog;
}

void main() {
  // Position (origin) of ray on screen
  vec2 pos = gl_FragCoord.xy / resolution;
  // pos.x /= resolution.y;
  pos = pos * 2.0 - 1.0;

  // Direction of ray
  direction = normalize(vec3(pos, 1.0));

  float b = brightness(camPos);
  vec3 color = vec3(b);

  gl_FragColor = vec4(color, 1.0);
}
