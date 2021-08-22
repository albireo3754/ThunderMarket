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
let grid = Array.from(Array(106), () => Array.from(Array(144), () => Array.from(Array(), () => {})))


let Position = {
  i: 3850,
  j: 12470,
  correct: function(longitude, latitude) {
    i = Math.floor((this.i - longitude * 100) / 5)
    j = Math.floor((latitude * 100 - this.j) / 5)
    return { i, j }
  }
}
let mapConfig = {
  i: 3.850,
  j: 12.470,
  scale: 5,
}

for (let idx = 0; idx < rows.length; idx ++) {
  let [name, latitude, longitude] = rows[idx].split(",");
  range.update(name, Number(longitude), Number(latitude))
  let { i, j } = Position.correct(longitude, latitude);
  // console.log(x, y);
  grid[i][j].push(name);
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
// grid.forEach((val, i) => {
//   val.forEach((val2, j) => {
//     if (a < val2.length) {
//       maxPos = {i, j}
//       a = val2.length
//     }
//   })});
// console.log(a,"1");
// console.log(maxPos);
let map = {
  grid,
  i: 3.850,
  j: 12.470,
  scale: 5,  
}
fs.writeFileSync(__dirname + "/map.json", JSON.stringify(map));
fs.writeFileSync(__dirname + "/mapConfig.json", JSON.stringify(mapConfig));
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