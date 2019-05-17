precision mediump float;
varying vec3 cPos;

struct complex {
  float imaginary;
  float real;
};

complex cMult(complex a, complex b) {
  return complex(
    a.real * b.real - a.imaginary * b.imaginary,
    a.real * b.imaginary + b.real * a.imaginary
  );
}

complex cAdd(complex a, complex b) {
  return complex(
    a.real + b.real,
    a.imaginary + a.imaginary
  );
}

float cMag(complex a) {
  return sqrt(
    pow(a.real, 1.0) +
    pow(a.imaginary, 2.0)
  );
}

const float PI = 3.141592;
const float QUARTER_PI = PI / 4.0;
const float EIGHT_PI = PI / 8.0;

vec3 scalToVec3(float x) {
  return vec3(
    1.0 - abs(sin(x)),
    1.0 - abs(sin(x + EIGHT_PI)),
    1.0 - abs(sin(x + QUARTER_PI))
  );
}

complex zPrev = complex(0.0, 0.0);
complex z(complex c) {
  for(int i = 0; i < 4; i ++ ) {
    complex zNew = cAdd(cMult(zPrev, zPrev), c);
    zPrev = zNew;
  }

  return zPrev;
}

float zoom = 2.0;

void main() {
  float val = cMag(z(complex(cPos.x * zoom, cPos.y * zoom)));
  // gl_FragColor = vec4(val, 0, 0, 1);
  gl_FragColor = vec4(scalToVec3(val), 1);
}