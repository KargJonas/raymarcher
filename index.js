const cnv = document.querySelector("canvas");
const gl = cnv.getContext("webgl") || cnv.getContext("experimental-webgl");
const shaderProgram = gl.createProgram();
const start = Date.now();
const vertexShaderText = `
attribute vec2 position;
void main(void) {
  gl_Position = vec4(position, 0, 1);
}`;

const WIDTH = 1704;
const HEIGHT = 960;

const mouse = {
  x: 0,
  y: 0
}

// class Vector {
//   constructor(x, y, z) {
//     this.x = x;
//     this.y = y;
//     this.z = z;
//   }
// }

// class Camera {
//   constructor(pos, rot) {
//     this.pos = pos;
//     this.rot = rot;
//   }
// }

const cam = {
  pos: {
    x: 0,
    y: 0,
    z: -3
  },

  rot: {
    x: 0,
    y: 0,
    z: 0
  }
};

function resize() {
  cnv.width = WIDTH;
  cnv.height = HEIGHT;
  gl.viewport(0, 0, WIDTH, HEIGHT);
}

window.addEventListener("resize", resize);
window.addEventListener("mousemove", (e) => {
  mouse.x = e.clientX;
  mouse.y = e.clientY;
});

function update() {
  requestAnimationFrame(update);
  const time = (Date.now() - start) / 1000;

  gl.uniform1f(gl.getUniformLocation(shaderProgram, "time"), time);
  gl.uniform3f(gl.getUniformLocation(shaderProgram, "camPos"), cam.pos.x, cam.pos.y, cam.pos.y);
  gl.uniform3f(gl.getUniformLocation(shaderProgram, "camRot"), cam.rot.x, cam.rot.y, cam.rot.z);
  gl.drawArrays(5, 0, 4);
}

function generateShader(type, shaderText) {
  const shader = gl.createShader(type);

  gl.shaderSource(shader, shaderText);
  gl.compileShader(shader);

  if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
    console.error(gl.getShaderInfoLog(shader));
  }

  gl.attachShader(shaderProgram, shader);
}

async function run() {
  const fragmentShaderText = await fetch("shader.glsl")
    .then((response) => (response.text()));

  generateShader(gl.VERTEX_SHADER, vertexShaderText);
  generateShader(gl.FRAGMENT_SHADER, fragmentShaderText);

  gl.linkProgram(shaderProgram);
  gl.useProgram(shaderProgram);

  const vertices = [
    -1, -1,
    -1, +1,
    +1, -1,
    +1, +1
  ];

  gl.bindBuffer(gl.ARRAY_BUFFER, gl.createBuffer());
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
  gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 0, 0);
  gl.enableVertexAttribArray(0);
  gl.uniform2f(gl.getUniformLocation(shaderProgram, "resolution"), WIDTH, HEIGHT);

  resize();
  update();
}

run();