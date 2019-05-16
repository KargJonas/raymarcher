const cnv = document.querySelector("canvas")
const gl = cnv.getContext("webgl")

if (!gl) throw new Error("No webgl support")

const vertices = [
  -1, -1, 0,
  1, -1, 0,
  1, 1, 0,
  -1, 1, 0,
];

