const fs = require("fs");
const Queue = require("./Queue");
const buffer = fs.readFileSync(__dirname + "/location.csv");
let text = buffer.toString();
let rows = text.split("\r");
let indexs = rows.splice(0, 1)
// 범위 구하기
let range = {
  longitudeMax: 0,
  longitudeMin: 10000,
  latitudeMax: 0,
  latitudeMin: 10000,
  update: function (name, longitude, latitude) {
    this.longitudeMax = Math.max(longitude, this.longitudeMax)
    this.longitudeMin = Math.min(longitude, this.longitudeMin) 
    this.latitudeMax = Math.max(latitude, this.latitudeMax)
    this.latitudeMin = Math.min(latitude, this.latitudeMin)
  }
}
let [_, longitude, latitude] = rows[0].split(",")
let grid = Array.from(Array(106), () => Array.from(Array(144), () => Array.from(Array(), () => {})));

let Position = {
  x: 3850,
  y: 12470,
  correct: function(longitude, latitude) {
    x = Math.floor((this.x - longitude * 100) / 5)
    y = Math.floor((latitude * 100 - this.y) / 5)
    return { x, y }
  }
}


for (let i = 0; i < rows.length; i ++) {
  let [name, latitude, longitude] = rows[i].split(",");
  range.update(name, Number(longitude), Number(latitude))
  let { x, y } = Position.correct(longitude, latitude);
  // console.log(x, y);
  grid[x][y].push(name);
}

function bfs() {
  const q = new Queue();
  // console.log(visited[500][500])
  
  const visited = Array.from(Array(144), () => Array.from(Array(106), () => false));
  q.push([gridCenter, gridCenter]);
  {
    while (q.length) {
      let [i, j] = q.pop();
      for (let [di, dj] of direction) {
        const [ni, nj] = [di + i, dj + j];
        console.log(ni, nj, di , dj)
        if (0 <= ni && ni < gridSize && 0<= nj && nj < gridSize && !visited[ni][nj]) {
          if (!saved[ni][nj]) {
          
            if (data.isTown) {
              const { address_name, x, y } = data;
              if (address_name.length == 2) {
                visited[ni][nj] = true
                continue
              }
              saved[ni][nj] = { address_name, x, y };
              console.log(`address: ${address_name}, x: ${x}, y: ${y}`);
            } else {
              console.log("마을은 없음")
            }
          } else {
            console.log("이미조사함")
          }
          visited[ni][nj] = true
          q.push([ni, nj]);
        }
      }
    }
  }
}
let maxPos = {i: 0, j: 0}
let a = 0
grid.forEach((val, i) => {
  val.forEach((val2, j) => {
    if (a < val2.length) {
      maxPos = {i, j}
      a = val2.length
    }
  })});
console.log(a,"1");
console.log(maxPos);

fs.writeFileSync(__dirname + "/map.json", JSON.stringify(grid));
// console.log(grid[maxPos.i][maxPos.j]);
// bfs()
console.log(range);
console.log(`range.longitudeMin = ${range.longitudeMin}`);
console.log(`range.latitudeMin = ${range.latitudeMin}`);
console.log("range.longitudeMax - range.longitudeMin =", range.longitudeMax - range.longitudeMin);
console.log("range.latitudeMax - range.latitudeMin =", range.latitudeMax - range.latitudeMin);
console.log(`716 * 527 = ${716 * 527}`);
console.log(`716 / 527 = ${716 / 527}`);
console.log(`Math.ceil(716 / 5), Math.ceil(527 / 5) = ${Math.ceil(716 / 5)}, ${Math.ceil(527 / 5)}`);
console.log(`Math.ceil(716 / 5) * Math.ceil(527 / 5) = ${Math.ceil(716 / 5) * Math.ceil(527 / 5)}`);


// console.log(`${715 - 526}, ${ - 59}`)
// console.log(Math.max(3, undefined))