/*
 * Reference: http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/
 */

precision mediump float;
uniform vec2 resolution;

#define MAX_STEPS 20
#define EPSILON 0.1

float map(vec3 point) {
  return length(point) - 1.0;
}

// Min distance to scene
float dist(vec3 origin, vec3 direction) {
  float depth = 0.0;

  for(int i = 0; i < MAX_STEPS; i ++ ) {
    float dist = map(origin + direction * depth);
    if (dist < EPSILON) return depth; // Return if inside the surface (performance)
    depth += dist;
  }
  return depth;
}

void main() {
  vec2 position = gl_FragCoord.xy / (resolution / 2.0);
  vec3 direction = normalize(vec3(position, 1.0));

  vec3 camera = vec3(0.0, 0.0, -10.0);
  float t = dist(camera, direction);
  float fog = 1.0 / (1.0 + t * t * 0.1);
  vec3 color = vec3(fog);

  gl_FragColor = vec4(color, 1.0);
}