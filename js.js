let frameRateValue = 5; // Valor de frecuencia de cuadros por segundo
function setup() {
  createCanvas(windowWidth, windowHeight);

}

function draw() {
 
  background(0 );
  var img = document.createElement('img'); 
  img.src = 'img/textura1.PNG'; 
  var op = random( 0,255);
  let squareSize = random (50,150); // Tamaño de los cuadrados
  frameRate(frameRateValue);

  for (let i = 0; i < 100; i++) {
    let x = random(width); // Posición x aleatoria
    let y = random(height); // Posición y aleatoria
    
    // Alternar entre cuadrados naranjas y azules
    if (i % 2 === 0) {
      noStroke();
      fill(250, 80, 0,op); // Naranja

    } else {
      noStroke();

      fill(48, 5, 158, op); // Azul
    }

    rect (x, y, squareSize, squareSize);
  }
  
  
}