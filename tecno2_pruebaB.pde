import fisica.*;

//física
FWorld mundo;

//Imagenes
PImage Fondo;
PImage platFija;
PImage platRebot;
PImage platBomba;
PImage platNube;
PImage pelotaC;
PImage pelotaG;
PImage pelotaM;

//Parametros
String estado;
Pantalla p;

boolean desaparecerBomba = false;

void setup() {
  size (1400, 750);

  //física
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();

  p = new Pantalla();

  //Imagenes
  Fondo = loadImage ("fondo1.jpg");
  platFija= loadImage("plataformaFija.png");
  //plataformaRebo = loadImage ("plataformaRebote.png");
  platRebot = loadImage ("flan.png");
  platBomba = loadImage ("bomba.png");
  platNube = loadImage ("Nube.png");
  pelotaC = loadImage ("pelotaC.png");
    pelotaG = loadImage ("pelotaG.png");
      pelotaM = loadImage ("pelotaM.png");



  //Iniciar juego
  estado = "Inicio";
}

void draw() {
  
    println("Posición del mouse: (" + mouseX + ", " + mouseY + ")");

  
  switch(estado) {
  case "Inicio":
    p.dibujar(0);
    break;
  case "Instruc":
    p.dibujar(1);
    break;
  case "inicializaJuego":
    iniciarJuego();
    estado = "estaJugando";
    break;
  case "estaJugando":
    image(Fondo, 0, 0);

    mundo.step();
    mundo.draw();

    break;
  case "Perdiste":
    p.dibujar(2);
    break;
  case "Gansate":
    p.dibujar(3);
    break;
  }
}

void keyPressed() {

  switch(estado) {
  case "Inicio":
    if (key == ENTER) {
      estado = "Instruc";
    }
    break;
  case "Instruc":
    if (key == ENTER) {
      estado = "inicializaJuego";
    }
        break;
  case "estaJugando":
    if (key == 'p') {
      estado = "Perdiste";
    }
    break;
  case "Perdiste":
    if (key == ENTER) {
      estado = "Inicio";
    }
    break;
  case "Ganaste":
    if (key==ENTER) {
      estado="Inicio";
    }
    break;
  }
}

void iniciarJuego() {

//BOLITAS
  //Bola uno MAS CHICA
  FCircle bolaBol = new FCircle (40);
  bolaBol.setPosition(200, 100);
  bolaBol.setRestitution(1.6);
  bolaBol.setDensity(0.5);
  bolaBol.setFill(255, 0, 0);
  mundo.add (bolaBol);
    bolaBol.attachImage(pelotaC);

  //Bola dos MEDIANA
  FCircle bolaBol1 = new FCircle (55);
  bolaBol1.setPosition(100, 100);
  bolaBol1.setRestitution(1.5);
    bolaBol1.setDensity(1);
      bolaBol1.attachImage(pelotaM);


  bolaBol1.setFill(0, 255, 0);
  mundo.add (bolaBol1);

  //Bola tres GRANDE
  FCircle bolaBol2 = new FCircle (70);
  bolaBol2.setPosition(50, 100);
  bolaBol2.setRestitution(1);
  bolaBol2.setFill(0, 0, 255);
  mundo.add (bolaBol2);
    bolaBol2.setDensity(1.5);
  bolaBol2.attachImage(pelotaG);


//PLATARFOMAS ESTÁTICAS
  //plat est 1
  Plataforma base1 = new Plataforma(150, 30);
  base1.setGrabbable(true);
  base1.inicializar (140, 145);
  //base1.setFill(0, 0, 255);
  base1.attachImage(platFija);
  mundo.add(base1);

  //plat est 2
  Plataforma base2 = new Plataforma(150, 30);
  base2.setGrabbable(true);
  base2.inicializar (1400, 700);
  //base2.setFill(0, 0, 255);
  base2.attachImage(platFija);
  mundo.add(base2);

//PLATAFORMAS REBOTE FLANES
  PlatRebo platRebo = new PlatRebo(60, 55);//tamaño
  platRebo.inicializar(397, 248);//posición
  mundo.add(platRebo.platRebo);
  
  PlatRebo platRebo1 = new PlatRebo(60, 55);
  platRebo1.inicializar(538, 544);
  mundo.add(platRebo1.platRebo);

  PlatRebo platRebo2 = new PlatRebo(60, 55);
  platRebo2.inicializar(848, 175);
  mundo.add(platRebo2.platRebo);
  
  PlatRebo platRebo3 = new PlatRebo(60, 55);
  platRebo3.inicializar(1237, 385);
  mundo.add(platRebo3.platRebo);
  
  //PLATAFORMAS REBOTE NUBES
  PlataformaNube platnube = new PlataformaNube(70, 50);//tamaño
  platnube.inicializar(359, 587);//posición
  mundo.add(platnube.platnube);
  
  PlataformaNube platnube1 = new PlataformaNube(70, 50);//tamaño
  platnube1.inicializar(735, 497);//posición
  mundo.add(platnube1.platnube);

  PlataformaNube platnube2 = new PlataformaNube(70, 50);//tamaño
  platnube2.inicializar(1074, 564);//posición
  mundo.add(platnube2.platnube);

  
//PLATARFOMAS BOMBA
  //plat bomba 1
  PlataformaBomba bomba1 = new PlataformaBomba(55, 30);
  bomba1.setGrabbable(true);
  bomba1.inicializar (240, 389);
  //bomba1.setFill(0,225, 0);
  bomba1.attachImage (platBomba);
  mundo.add(bomba1);

  //plat bomba 2
  PlataformaBomba bomba2 = new PlataformaBomba(55, 30);
  bomba2.setGrabbable(true);
  bomba2.inicializar (618, 311);
  //bomba2.setFill(0, 255, 0);
  bomba2.attachImage (platBomba);
  mundo.add(bomba2);
  
    //plat bomba 3
  PlataformaBomba bomba3 = new PlataformaBomba(55, 30);
  bomba3.setGrabbable(true);
  bomba3.inicializar (922, 418);
  //bomba2.setFill(0, 255, 0);
  bomba3.attachImage (platBomba);
  mundo.add(bomba3);
  
  PlataformaBomba bomba4 = new PlataformaBomba(55, 30);
  bomba4.setGrabbable(true);
  bomba4.inicializar (1106, 208);
  //bomba2.setFill(0, 255, 0);
  bomba4.attachImage (platBomba);
  mundo.add(bomba4);
}
