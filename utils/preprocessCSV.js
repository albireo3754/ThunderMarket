const fs = require("fs");

const buffer = fs.readFileSync(__dirname + "/_location.csv");
let text = buffer.toString();
let row = text.split("\n");

let result = ["이름,경도(초/100),위도(초/100)"];
for (let i = 1; i < row.length; i++) {
  let errorData = row[i].match(/".+"/)
  if (errorData) {
    let correctedData = errorData[0].slice(1, errorData[0].length - 1).replace(",", ".");
    row[i] = row[i].slice(0, errorData["index"]) + correctedData + 
      row[i].slice(errorData["index"] + errorData[0].length, row[i].length);
    console.log(row[i]);
    
  }
  if (row[i].split(",")[4] == "") {
    // console.log(row[i]);
    continue;
  }

  let rowSplit = row[i].split(",").slice(2, 7);
  let newRow = `${rowSplit.slice(0, 3).join(" ")},${rowSplit[3]},${
    rowSplit[4]
  }`;
  // console.log(newRow);
  result.push(newRow);
}

fs.writeFileSync(__dirname + "/location.csv", result.join(`\r`));
// console.log(test.split(","));
// console.log(test);
