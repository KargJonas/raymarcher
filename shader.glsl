precision mediump float;
varying vec3 cPos;

void main() {
  float x = cPos.x;
  float y = cPos.y;

  gl_FragColor = vec4(sin(x * 10.0), y, 0, 1);
}