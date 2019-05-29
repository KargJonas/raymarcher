const cnv = document.querySelector("canvas");
const gl = cnv.getContext("webgl") || cnv.getContext("experimental-webgl");
const shaderProgram = gl.createProgram();
const start = Date.now();
const vertexShaderText = `
attribute vec2 position;
void main(void) {
  gl_Position = vec4(position, 0, 1);
}`;

const screen = new Vector(400, 200);

const mouse = new Mouse();
const cam = new Camera();
const keyboard = new Keyboard();

// kb.listen((keys) => {
//   if (keys[87]) {
//     cam.pos.z += 0.1;
//   }
// });

function update() {
  requestAnimationFrame(update);
  const time = (Date.now() - start) / 1000;

  cam.pos.z += 0.01;
  cam.rot.y += 0.005;

  // if (keyboard.pressedKeys[87]) {
  //   cam.pos.z += 0.1;
  // }

  // cam.rot.y = mouse.pos.x / screen.x;
  // cam.rot.x = mouse.pos.y / screen.y;

  gl.uniform1f(gl.getUniformLocation(shaderProgram, "time"), time);
  gl.uniform3f(gl.getUniformLocation(shaderProgram, "camPos"), cam.pos.x, cam.pos.y, cam.pos.z);
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
  gl.uniform2f(gl.getUniformLocation(shaderProgram, "resolution"), screen.x, screen.y);

  cnv.width = screen.x;
  cnv.height = screen.y;
  gl.viewport(0, 0, screen.x, screen.y);

  update();
}

run();