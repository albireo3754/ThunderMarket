module.exports = class Queue {
  constructor () {
    this.stack1 = [];
    this.stack2 = [];
    this.length = 0;
  }

  push(item) {
    this.stack1.push(item);
    this.length += 1;
  }

  pop() {
    this.length -= 1;
    if (this.stack2.length) {
      return this.stack2.pop();
    } else {
      while (this.stack1.length) {
        this.stack2.push(this.stack1.pop())
      }
      return this.stack2.pop()
    }
  }
}