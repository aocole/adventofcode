var re = /^((turn on)|(turn off)|(toggle)) (\d+),(\d+) through (\d+),(\d+)$/
var c = document.getElementById("lights")
var ctx = c.getContext("2d")
var width = 1000
var height = 1000

// Red channel is the reference source for brightness

function on(x1, y1, x2, y2) {
  change(1, x1, y1, x2, y2)
}

function off(x1, y1, x2, y2) {
  change(-1, x1, y1, x2, y2)
}

function toggle(x1, y1, x2, y2) {
  change(2, x1, y1, x2, y2)
}

function change(increment, x1, y1, x2, y2) {
  var w = x2 - x1 + 1
  var h = y2 - y1 + 1
  var imageData = ctx.getImageData(x1, y1, w, h);
  var dataArr = imageData.data;

  for(var i = 0; i < dataArr.length; i += 4) {
    var brightness = dataArr[i] // get from red channel
    var toBrightness = brightness + 4*increment;
    if (toBrightness < 0) {
      toBrightness = 0
    }
    if (toBrightness > 255) {
      console.error("Clipped brightness!")
      sdfgsdfg
    }
    for(var j = 0; j < 3; j++) {
      dataArr[i + j] = toBrightness;
    }
  }
      
  ctx.putImageData(imageData, x1, y1);
}

// Start will all lights off
ctx.fillStyle = "#000000"
ctx.fillRect(0, 0, width, height);

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
var totalBrightness = 0

for(var i = 0; i < dataArr.length; i += 4) {
  var brightness = dataArr[i] // get from red channel
  totalBrightness += brightness
}
alert(totalBrightness/4 + " total brightness")