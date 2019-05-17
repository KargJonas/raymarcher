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
    pow(a.real, 2.0) +
    pow(a.imaginary, 2.0)
  );
}

vec3 scalToVec3(float s) {
  // s /= 10.0;

  return vec3(
    sin(s),
    sin(s + 0.8),
    sin(s + 1.5)
  );
}

complex zPrev = complex(0.0, 0.0);
complex z(complex c) {
  for (int i = 0; i < 10; i++) {
    complex zNew = cAdd(cMult(zPrev, zPrev), c);
    zPrev = zNew;
  }

  return zPrev;
}

// bool intersects(vec3 origin) {
//   if (length(origin) < 0.5) {
//     return true;
//   }

//   return false;
// }

void main(){
  // "cPos" is provided as varying.

  // if (intersects(cPos)) {
  //   gl_FragColor = vec4(1, 0, 0, 1);
  //   return;
  // }

  // gl_FragColor = vec4(0, 0, 0, 1);

  float zoom = 1.1;

  float val = cMag(z(complex(cPos.x * zoom, cPos.y * zoom)));
  gl_FragColor = vec4(scalToVec3(val), 1);
}