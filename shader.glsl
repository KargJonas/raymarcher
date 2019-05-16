precision mediump float;
varying vec3 cPos;

float scale=20.;
vec3 center=vec3(0,0,0);

struct geometry{
  int type; // 1: Skybox
  vec3 pos;
};

geometry skybox=geometry(1, vec3(0,0,2));

vec3 intersectSkybox(vec3 origin, vec3 direction){
  return vec3(0, 1, 0.5);
}

vec3 intersect(geometry geo,vec3 origin,vec3 direction){
  if(geo.type==1){
    return intersectSkybox(origin, direction);
    // return vec3(0,0,0);
  } else {
    return vec3(0, 0, 0);
  }
}

// vec3 circleIntersect(vec3 origin) {
  //   if (distance(origin, center) < 0.5) {
    //     return vec3(1, 0, 0);
  //   }

  //   return vec3(0, 0, 0);
// }

void main(){
  // "cPos" is provided as varying.

  gl_FragColor=vec4(intersect(skybox,cPos,cPos),1);
  // gl_FragColor = vec4(1, 0, 0, 1);
  // gl_FragColor = vec4(circleIntersect(cPos), 1);
}

// void main() {
  //   // "cPos" is provided as varying
  //   float x = cPos.x * scale;
  //   float y = cPos.y * scale;

  //   float val = sin(x) * cos(y);

  //   if(val > 0.0) {
    //     val = 1.0;
  //   }

  //   gl_FragColor = vec4(val, 0, 0, 1);
// }