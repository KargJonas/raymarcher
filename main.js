const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const geometry = new THREE.BoxGeometry(1, 1, 1);
// const material = new THREE.MeshNormalMaterial();
const material = new THREE.MeshNormalMaterial({color: "#ff0000"});
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 5;

let mouseX = 0;
let mouseY = 0;

window.addEventListener("mousemove", (e) => {
  mouseX = e.clientX;
  mouseY = e.clientY;
})

function animate() {
  requestAnimationFrame(animate);
  // cube.rotateY(0.01);
  // cube.rotateX(0.01);
  cube.rotation.y = (mouseX / window.innerWidth) * 3;
  cube.rotation.x = (mouseY / window.innerHeight) * 3;
  renderer.render(scene, camera);
}

animate();