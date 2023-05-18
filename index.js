let pinceladas = [];
let cantidad = 5;
let tamA, tamN;
let figures = [];
let fondo;

function preload() {
  for (let i = 0; i < cantidad; i++) {
    let nombre = "img/trazo_" + i + ".png";
    pinceladas[i] = loadImage(nombre);
  }
}

function setup() {
  createCanvas(windowWidth, windowHeight);
}

function draw() {
  background(0); // Fondo negro

  //tamN = map(mouseX, 0, width, 0, 255); // Mapear la posición x del mouse a un valor de op entre 0 y 255
  tamN = map(mouseY, 0, height, 300, 100); // Mapear la posición y del mouse a un valor de op entre 0 y height
  tamA = map(mouseY, 0, height, 100, 300); // Mapear la posición y del mouse a un valor de op entre 0 y height
  
  
  if (tamA > 200) {
    fondo = color(1, 4, 54); // Azul
  } else {
    fondo = color(54, 1, 6); // rojo
  }
  fill(fondo);
  rect(0, 0, width, height);

  let figure = {
    image: pinceladas[int(random(cantidad))],
    x: random(width),
    y: random(height),
    //size: random(50, 200)
  };

  let figure1 = {
    image: pinceladas[int(random(cantidad))],
    x: random(width),
    y: random(height),
   // size: random(60, 260)
  };
  figures.push(figure);
  figures.push(figure1);


  for (let i = 0; i < figures.length; i++) {
    let figure = figures[i];
    let figure1 = figures[i];

    
    let opacity = map(mouseX, 0, width, 0, 255);

    tint(255, random(0,50), 10, opacity); // Naranja con opacidad variable
    image(figure.image, figure.x, figure.y, tamN, tamN);

    tint(random(0,50),10, 255, opacity); // ax con opacidad variable
    image(figure1.image, figure1.x, figure1.y, tamA, tamA);
  }
}

