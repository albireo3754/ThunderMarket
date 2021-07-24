const axios = require("axios").default;
const Queue = require("./Queue");
const fs = require("fs");
const Kakao = {
  x: 127.10,
  y: 36.40
}
let direction = [[1, 0], [0, 1], [-1, 0], [0, -1]];
const gridSize = 100;
const gridCenter = gridSize / 2
const gridPositionDivide = gridSize / 10
function makePositionFromRawPosition({ x, y }) {
  return { x: Kakao.x + (x - gridCenter) / gridPositionDivide, y: Kakao.y + (y - gridCenter) / gridPositionDivide }
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
  const result = makePositionFromRawPosition({x : gridCenter, y: gridCenter}); 
  console.log(result);
}
// console.log(testmakePositionFromRawPosition())
async function testgetTownWithPositionFromKakao() {
  // const test = await getTownWithPosition({x: 127.1123, y: 37.42312}); 
  const test = await getTownWithPosition(makePositionFromRawPosition({x : 0, y: gridSize}));
  console.log(test)
}

// testgetTownWithPositionFromKakao()

async function bfs() {
  const q = new Queue();
  let saved;
  if (fs.existsSync(__dirname + `/map_${gridSize}.json`)) {
    const buffer = fs.readFileSync(__dirname + `/map.json${gridSize}`);
    saved = JSON.parse(buffer);
  } else {
    saved = Array.from(Array(gridSize), () => Array.from(Array(gridSize), () => false)); 
  }  
  // console.log(visited[500][500])
  const visited = Array.from(Array(gridSize), () => Array.from(Array(gridSize), () => false));
  q.push([gridCenter, gridCenter]);
  try {
    while (q.length) {
      let [i, j] = q.pop();
      for (let [di, dj] of direction) {
        const [ni, nj] = [di + i, dj + j];
        console.log(ni, nj, di , dj)
        if (0 <= ni && ni < gridSize && 0<= nj && nj < gridSize && !visited[ni][nj]) {
          if (!saved[ni][nj]) {
            const data = await getTownWithPosition(makePositionFromRawPosition({x : ni, y: nj}));
            
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
  } catch(e) {
   console.log(e) 
  }finally {
    fs.writeFileSync(`map_${gridSize}.json`, JSON.stringify(saved)) 
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