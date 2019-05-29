class Camera {
  constructor(
    pos = new Vector(0, 0, 0),
    rot = new Vector(0, 0, 0)
  ) {
    this.pos = pos;
    this.rot = rot;
  }

  rotate(rot) {
    this.rot.add(rot);
  }

  move(offset) {
    this.pos.add(offset);
  }
}