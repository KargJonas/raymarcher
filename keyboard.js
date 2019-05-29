class Keyboard {
  constructor() {
    this.pressedKeys = [];
    this.listeners = [];
    window.addEventListener("keydown", (e) => this.keyDown(e));
    window.addEventListener("keyup", (e) => this.keyUp(e));
  }

  keyDown(e) {
    this.pressedKeys[e.keyCode] = true;
    this.callListeners();
  }

  keyUp(e) {
    this.pressedKeys[e.keyCode] = false;
    this.callListeners();
  }

  callListeners() {
    this.listeners.map((listener) => {
      if (!listener) return;
      listener(this.pressedKeys);
    });
  }

  listen(callback) {
    this.listeners.push(callback);
    return this.listeners.length - 1;
  }

  stopListen(index) {
    this.listeners[index] = false;
  }
}