var re = /^((turn on)|(turn off)|(toggle)) (\d+),(\d+) through (\d+),(\d+)$/
var c = document.getElementById("lights")
var ctx = c.getContext("2d")
var width = 1000
var height = 1000

var onColor = "#FFFFFF"
var onColorArr = [255, 255, 255]
var offColor = "#000000"
var offColorArr = [0, 0, 0]

function set(color, x1, y1, x2, y2) {
  var w = x2 - x1 + 1
  var h = y2 - y1 + 1
  ctx.fillStyle = color
  ctx.fillRect(x1, y1, w, h);
}

function on(x1, y1, x2, y2) {
  set(onColor, x1, y1, x2, y2)
}

function off(x1, y1, x2, y2) {
  set(offColor, x1, y1, x2, y2)
}

function toggle(x1, y1, x2, y2) {
  var w = x2 - x1 + 1
  var h = y2 - y1 + 1
  var imageData = ctx.getImageData(x1, y1, w, h);
  var dataArr = imageData.data;

  for(var i = 0; i < dataArr.length; i += 4) {
    var pixel = [
      dataArr[i],
      dataArr[i + 1],
      dataArr[i + 2]
    ]
    var toColor = offColorArr
    if (pixel.join() == offColorArr.join()){
      toColor = onColorArr
    }
    for(var j = 0; j < toColor.length; j++) {
      dataArr[i + j] = toColor[j];
    }
  }
      
  ctx.putImageData(imageData, x1, y1);
}

// turn all lights off (black)
off(0, 0, width, height);

input.forEach(function(instruction, i){
  var match = re.exec(instruction)
  var action = match[1]
  var x1 = match[5]
  var y1 = match[6]
  var x2 = match[7]
  var y2 = match[8]

  switch(action) {
    case "turn on":
      on(x1, y1, x2, y2)
      break
    case "turn off":
      off(x1, y1, x2, y2)
      break
    case "toggle":
      toggle(x1, y1, x2, y2)
      break
  }
})

var imageData = ctx.getImageData(0, 0, width, height);
var dataArr = imageData.data;
var onCount = 0

for(var i = 0; i < dataArr.length; i += 4) {
  var pixel = [
    dataArr[i],
    dataArr[i + 1],
    dataArr[i + 2]
  ]
  if (pixel.join() == onColorArr.join()){
    onCount++
  }
}
alert(onCount + " lights on")