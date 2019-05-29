class Vector {
  constructor(x, y, z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  mult(factor) {
    return new Vector(
      this.x * factor,
      this.y * factor,
      this.z * factor
    );
  }

  div(factor) {
    return new Vector(
      this.x / factor,
      this.y / factor,
      this.z / factor
    );
  }

  add(other) {
    return new Vector(
      this.x + other.x,
      this.y + other.y,
      this.z + other.z
    );
  }

  sub(other) {
    return new Vector(
      this.x - other.x,
      this.y - other.y,
      this.z - other.z
    )
  }

  cross(other) {
    return new Vector(
      this.y * other.z - this.z * other.y,
      this.x * other.z - this.z * other.x,
      this.x * other.y - this.y * other.x
    );
  }

  mag() {
    return Math.sqrt(
      Math.pow(this.x, 2) +
      Math.pow(this.y, 2) +
      Math.pow(this.z, 2)
    );
  }

  normalize() {
    return this.div(this.mag());
  }

  save() {
    return new Vector(
      this.x || 0,
      this.y || 0,
      this.z || 0
    );
  }
}
