const axios = require("axios").default;
const Queue = require("./Queue");
const fs = require("fs");
const Kakao = {
  x: 127.10,
  y: 36.40
}
let direction = [[1, 0], [0, 1], [-1, 0], [0, -1]];

function makePositionFromRawPosition({ x, y }) {
  return { x: Kakao.x + (x - 500) / 100, y: Kakao.y + (y - 500) / 100 }
}
async function getTownWithPosition({ x, y }) {
  // await new Promise((resolve) => {setTimeout(resolve, 1)});
  const response = await axios({
    method: 'get',
    url: `https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=${x}&y=${y}`,
    headers: {
      'Authorization': 'KakaoAK 6d4ee65f00e9e4ba4d76346b7061a05b'
    }
  })
  if (response.status === 200) {
    for (let {region_type, address_name, x, y} of response.data.documents) {
      if (region_type === 'B') {
        console.log(address_name, x, y)
        return { isTown: true, address_name, x, y }
      }
    }
  }
  return { isTown: false }
}
function testmakePositionFromRawPosition() {
  const result = makePositionFromRawPosition({x : 500, y: 500}); 
  console.log(result);
}
// console.log(testmakePositionFromRawPosition())
async function testgetTownWithPositionFromKakao() {
  // const test = await getTownWithPosition({x: 127.1123, y: 37.42312}); 
  const test = await getTownWithPosition(makePositionFromRawPosition({x : 0, y: 1000}));
  console.log(test)
}

// testgetTownWithPositionFromKakao()

async function bfs() {
  const q = new Queue();
  const visited = Array.from(Array(1000), () => Array.from(Array(1000), () => false));
  q.push([500, 500]);
  try {
    while (q.length) {
      let [i, j] = q.pop();
      for (let [di, dj] of direction) {
        const [ni, nj] = [di + i, dj + j];
        console.log(ni, nj, di , dj)
        if (0 <= ni && ni < 1000 && 0<= nj && nj < 1000 && !visited[ni][nj]) {
          const data = await getTownWithPosition(makePositionFromRawPosition({x : ni, y: nj}));
          if (data.isTown) {
            const { address_name, x, y } = data;
            console.log(data.address_name);
            visited[ni][nj] = { address_name, x, y };
            q.push([ni, nj]);
          }
        }
      }
    }
  } finally {
    fs.writeFileSync("map.json", JSON.stringify(visited)) 
  }  
}
bfs()

// const q = new Queue();
// q.push(1)
// q.push(2)
// console.log(q.pop())

// q.push(1)
// console.log(q.pop())
// console.log(q.pop())