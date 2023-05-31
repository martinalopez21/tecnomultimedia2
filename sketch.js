let trazos = [];
let trazos1 = [];
let cantidad = 2;
let cantidad1= 3;
let tamañoImagen = 100; // Tamaño inicial de la imagen
let opacidad = 0;



function preload() {
  miPaleta = new Paleta( "img/paletaR.jpg" );
  for (let i = 0; i < cantidad; i++) {
    let nombre = "img/pincelviejo" + i + ".png";
    trazos[i] = loadImage(nombre);
  }


  for (let i = 0; i < cantidad1; i++) {
    let nombre1 = "img/linea" + i + ".png";
    trazos1[i] = loadImage(nombre1);
  }
}

function setup() {
  createCanvas(displayWidth, displayHeight);
  frameRate(10);
  background(54, 1, 6);
  imageMode(CENTER);
}

function draw() {
  let esteColor =  miPaleta.darColor();
  let cual = int(random(cantidad));
  let cual1 = int(random(cantidad1));
  let x = random(width);
  let y = random(height);

  let x1 = random(width);
  let y1 = random (height);


  let nuevoTamaño = tamañoImagen + mouseY; // Nuevo tamaño de la imagen basado en el movimiento del mouse en el eje x
  let nuevaOpacidad = opacidad + mouseX;

  tint( red(esteColor) , green(esteColor) , blue(esteColor) , nuevaOpacidad );
//   //if (random() < 0.5) {
//   tint(random(100, 255), 0, 0, nuevaOpacidad);
// } else {
//   tint(0, 0, random(100, 255), nuevaOpacidad);
// } cambiar entre azul y rojo
  

  image(trazos[cual], x, y, nuevoTamaño, nuevoTamaño); // Dibuja la imagen con el nuevo tamaño
  tint( 0,0,0 , nuevaOpacidad );
  image(trazos1[cual1], x1, y1, 200, 200); // Dibuja la imagen con el nuevo tamaño
}
