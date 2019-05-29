class Mouse {
  constructor() {
    this.pos = new Vector(0, 0, 0);
    this.listeners = [];
    window.addEventListener("mousemove", (e) => this.mouseMove(e));
  }

  mouseMove(e) {
    this.pos.x = e.clientX;
    this.pos.y = e.clientY;
    this.callListeners();
  }

  callListeners() {
    this.listeners.map((listener) => {
      listener(this.pos);
    })
  }

  listen(callback) {
    this.listeners.push(callback);
    return this.listeners.length - 1;
  }

  stopListen(index) {
    this.listeners[index] = false;
  }
}