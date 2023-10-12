import fisica.*;

import ddf.minim.*;

Minim minim;

AudioPlayer fondo;
AudioPlayer boing;
AudioPlayer Perdi;
AudioPlayer Reboflan;
AudioPlayer Piso;
AudioPlayer bombaSlime;
AudioPlayer vaso;


FWorld mundo;

Bolas bola1;
Bolas bola2;
Bolas bola3;

PlataformaBomba bomba1;
PlataformaBomba bomba2;
PlataformaBomba bomba3;
PlataformaBomba bomba4;

PlataformaNube nube1;
PlataformaNube nube2;
PlataformaNube nube3;

PlataformaFlan flan1;
PlataformaFlan flan2;
PlataformaFlan flan3;

int PUERTO_OSC = 12345;

Receptor receptor;

Administrador admin;

float xpuntero;
float ypuntero;


//Imagenes
PImage Fondo;
PImage platFija;
PImage platRebot;
PImage platBomba;
PImage platNube;
PImage pelotaC;
PImage pelotaG;
PImage pelotaM;
PImage Vaso;
PImage[] ganaste;
PImage punteroo;
PImage[] puntos;///////////////PUNTOS
PImage Explo;



//Parametros
String estado;
Pantalla p;

boolean desaparecerBomba = false;
boolean monitor = true;
int estrellas = 0;

FMouseJoint manija;

void setup() {
  size (1400, 750);


  minim= new Minim (this);
  fondo = minim.loadFile("musicafondo.mp3");
  boing = minim.loadFile("boing.mp3");
  Perdi = minim.loadFile("Perdiste.mp3");
  Reboflan = minim.loadFile("reboflan.mp3");
  Piso = minim.loadFile("piso.mp3");
  bombaSlime = minim.loadFile("bomba.mp3");
  vaso = minim.loadFile("vaso.mp3");



  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 0);

  setupOSC(PUERTO_OSC);

  receptor = new Receptor();

  admin = new Administrador(mundo);


  for (int i=0; i<100; i++) {

    FCircle c = new FCircle(random(20, 50));
    c.setPosition(random (50, width-50), random(50, height-50));
    c.setFill(random(255), random(255), random(255));
    mundo.add(c);
  }


  //física
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();

  p = new Pantalla();

  //Imagenes
  Fondo = loadImage ("fondo1.jpg");
  platFija= loadImage("plataformaFija.png");
  Vaso= loadImage("Vaso.png");
  //plataformaRebo = loadImage ("plataformaRebote.png");
  platRebot = loadImage ("flan.png");
  platBomba = loadImage ("bomba.png");
  platNube = loadImage ("Nube.png");
  pelotaC = loadImage ("pelotaC.png");
  pelotaG = loadImage ("pelotaG.png");
  pelotaM = loadImage ("pelotaM.png");
  Explo = loadImage ("explo.png");
  
    punteroo = loadImage ("mano1.png");
  ganaste = new PImage[3];
  for (int i = 0; i < 3; i++)
  {
    ganaste[i] = loadImage("ganaste"+i+".jpg");
  }

puntos = new PImage[4];////////////////////////CARGAR IMAGENES PUNTOS
  for (int i = 0; i < 4; i++)
  {
    puntos[i] = loadImage("estrellas"+i+".png");
  }

  //Iniciar juego
  estado = "Inicio";

  iniciarJuego();
}

void draw() {
  receptor.actualizar(mensajes); //
  receptor.dibujarBlobs(width, height);

  float xtotal = 0;
  float ytotal = 0;
  int cantpuntero = 0;

  // Eventos de entrada y salida
  for (Blob b : receptor.blobs) {

    if (!b.salio) {
      xtotal += b.centroidX*width;
      ytotal += b.centroidY*height;
      cantpuntero ++;
    }

    if (b.entro) {
      admin.crearPuntero(b);
      println("--> entro blob: " + b.id);
    }
    if (b.salio) {
      admin.removerPuntero(b);
      println("<-- salio blob: " + b.id);
    }

    admin.actualizarPuntero(b);
  }


  if (cantpuntero>0) {
    xtotal /= cantpuntero;
    ytotal /= cantpuntero;

    xpuntero = xtotal;
    ypuntero = ytotal;
  }

  manija.setTarget (xpuntero, ypuntero);

  //println("cantidad de blobs: " + receptor.blobs.size());





  println("PosiciónX del mouse: (" + mouseX + ", " + mouseY + ")");
  println("N_Eestrellas:" +(estrellas));

  switch(estado) {
  case "Inicio":
   p.dibujar(0);
   if (estado =="Inicio" && xpuntero >= 71 &&  ypuntero >= 637 &&  xpuntero <= 300 && ypuntero <= 700) {
      estado = "Instruc";
    }
  break;

  case "Instruc":
    p.dibujar(1);
  if (estado =="Instruc" && xpuntero >= 640 &&  ypuntero >= 513 &&  xpuntero <= 755 && ypuntero <= 664) {
     estado = "inicializaJuego";
    }
    break;
  case "inicializaJuego":

    estado = "nivel1";
    break;
  case "nivel1":
    image(Fondo, 0, 0);
    
    image(puntos[0], 1200,30);
  if(estrellas==1){
    image(puntos[1], 1200,30);
  } else if(estrellas==2){
    image(puntos[2], 1200,30);
  }else if(estrellas==3){
    image(puntos[3], 1200,30);
  }

    mundo.step();
    mundo.draw();

    break;
  case "Fin":
  
    if (estrellas==0) {
      p.dibujar(2);
    } else if (estrellas==1) {
      image(ganaste[0], 0, 0);
    } else if (estrellas==2) {
      image(ganaste[1], 0, 0);
    } else if (estrellas==3) {
      image(ganaste[2], 0, 0);
    }
  if (estado =="Fin" && xpuntero >= 1180 &&  ypuntero >= 586 &&  xpuntero <= 1300 && ypuntero <= 717) {
     estado = "Inicio";
    }




    break;
  }
  if (monitor) {
    //  admin.dibujar();
    push();
    fill (0, 255, 0);
    image  (punteroo, xpuntero, ypuntero, 50, 50);
    pop();
  }

  //if ( estado =="Inicio" && xpuntero >= 640 &&  ypuntero >= 513 &&  xpuntero <= 755 && ypuntero <= 664);
 // {
  //estado = "Ganaste";
  //}
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
  case "Fin":
    if (key==ENTER) {
      estado="Inicio";
    }
    break;
  }
}

void iniciarJuego() {
  

  fondo.setGain(-15);
  fondo.play();

  //BOLITAS
  //Bola 2 MEDIANA
  bola3 = new Bolas(55, 30);
  bola3.setPosition(100, 100);
  bola3.setRestitution(2);
  bola3.setDensity(10);
  bola3.attachImage (pelotaC);
  bola3.setGrabbable(true);
  bola3.setName("Bolas3");////////////////////////// BOLA1  SETNAME

  //Bola 2 MEDIANA
  bola2 = new Bolas(55, 30);
  bola2.setPosition(100, 100);
  bola2.setRestitution(1.5);
  bola2.setDensity(50);
  bola2.attachImage (pelotaM);
  bola2.setGrabbable(true);
  bola2.setName("Bolas2");////////////////////////// BOLA1  SETNAME


  //Bola 1 GRANDE
  bola1 = new Bolas(55, 30);
  bola1.setPosition(100, 100);
  bola1.setRestitution(1);
  bola1.setDensity(100);
  bola1.attachImage (pelotaG);
  bola1.setGrabbable(true);
  bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
  mundo.add(bola1);


  //PLATARFOMAS ESTÁTICAS
  //plat est 1
  Plataforma base1 = new Plataforma(150, 30);
  base1.setGrabbable(true);
  base1.inicializar (140, 145);
  //base1.setFill(0, 0, 255);
  base1.attachImage(platFija);
  mundo.add(base1);

  manija = new FMouseJoint (base1, 140, 145);
  mundo.add (manija);

  //plat est 2
  Plataforma base2 = new Plataforma(150, 30);
  base2.setGrabbable(true);
  base2.inicializar (1300, 650);
  //base2.setFill(0, 0, 255);
  base2.setStatic(true);
  base2.attachImage(Vaso);
  base2.setName("Vaso");////////////////////////// BOLA1  SETNAME
  mundo.add(base2);

  //--------------------------------------- FLANES -------------------------------------------------------------------------------------------- platRebo=flan


 /* PlataformaFlan flan1 = new PlataformaFlan(55, 30);
  flan1.setGrabbable(true);
  flan1.inicializar (139, 229);
  //bomba1.setFill(0,225, 0);
  flan1.attachImage (platRebot);
  flan1.setName("plataformaFlan");////////////////////////// NUBE 2 SETNAME
  mundo.add(flan1);*/


  PlataformaFlan flan2 = new PlataformaFlan(55, 30);
  flan2.setGrabbable(true);
  flan2.inicializar (627, 387);
  //bomba1.setFill(0,225, 0);
  flan2.attachImage (platRebot);
  flan2.setName("plataformaFlan");////////////////////////// NUBE 2 SETNAME
  mundo.add(flan2);

  PlataformaFlan flan3 = new PlataformaFlan(55, 30);
  flan3.setGrabbable(true);
  flan3.inicializar (951, 576);
  //bomba1.setFill(0,225, 0);
  flan3.attachImage (platRebot);
  flan3.setName("plataformaFlan");////////////////////////// NUBE 1 SETNAME
  mundo.add(flan3);


  //--------------------------------------- NUBES --------------------------------------------------------------------------------------------

  //nube 1

  nube1 = new PlataformaNube(55, 30);
  nube1.setGrabbable(true);
  nube1.inicializar (299, 450);
  //bomba1.setFill(0,225, 0);
  nube1.attachImage (platNube);
  nube1.setName("plataformaNube");////////////////////////// NUBE 1 SETNAME
  mundo.add(nube1);

  //nube 2

  nube2 = new PlataformaNube(55, 30);
  nube2.setGrabbable(true);
  nube2.inicializar (1014, 212);
  //bomba1.setFill(0,225, 0);
  nube2.attachImage (platNube);
  nube2.setName("plataformaNube2");////////////////////////// NUBE 2 SETNAME
  mundo.add(nube2);

  //nube 3

  nube3 = new PlataformaNube(55, 30);
  nube3.setGrabbable(true);
  nube3.inicializar (1104, 456);
  //bomba1.setFill(0,225, 0);
  nube3.attachImage (platNube);
  nube3.setName("plataformaNube3");////////////////////////// NUBE 3 SETNAME
  mundo.add(nube3);



  //--------------------------------------- BOMBA --------------------------------------------------------------------------------------------

  //bomba 1

  bomba1 = new PlataformaBomba(55, 30);
  bomba1.setGrabbable(true);
  bomba1.inicializar (111, 582);
  //bomba1.setFill(0,225, 0);
  bomba1.attachImage (platBomba);
  bomba1.setName("plataformaBomba");//////////////////////////BOMBA 1 SETNAME
  mundo.add(bomba1);
  

  //bomba 2

  bomba2 = new PlataformaBomba(55, 30);
  bomba2.setGrabbable(true);
  bomba2.inicializar (547, 161);
  //bomba2.setFill(0, 255, 0);
  bomba2.attachImage (platBomba);
  bomba2.setName("plataformaBomba2");//////////////////////////BOMBA 2 SETNAME
  mundo.add(bomba2);

  //bomba 3

  bomba3 = new PlataformaBomba(55, 30);
  bomba3.setGrabbable(true);
  bomba3.inicializar (1297, 125);
  //bomba2.setFill(0, 255, 0);
  bomba3.attachImage (platBomba);
  bomba3.setName("plataformaBomba3");//////////////////////////BOMBA 3 SETNAME
  mundo.add(bomba3);


rect(111,582,20,20);

  
  

  FBox marcoB = new FBox(3000, 50);//ABAJO
  marcoB.setPosition(50, 745);
  marcoB.setStatic(true);
  marcoB.setGrabbable(false);
  marcoB.setNoFill();
  marcoB.setNoStroke();
  marcoB.setName ("marcoPiso");
  mundo.add(marcoB);
}




void contactStarted(FContact contact) {

  //////////////////////////////// bombas
  FBody _body1 = contact.getBody1();
  FBody _body2 = contact.getBody2();
  
  if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaBomba")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaBomba"))
  {

    bola1.matar();
    mundo.remove(bola1);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
    mundo.add(bola2);

    //mundo.remove(bomba1);
    bomba1.attachImage (Explo);

      
    bombaSlime.rewind(); 
    bombaSlime.play();
  }

  if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaBomba2")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaBomba2"))
  {

    bola1.matar();
    mundo.remove(bola1);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
    mundo.add(bola2);

  //  mundo.remove(bomba2);
  
  bomba2.attachImage (Explo);
    
    bombaSlime.rewind();     
    bombaSlime.play();
  }
  if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaBomba3")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaBomba3"))
  {

    bola1.matar();
    mundo.remove(bola1);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
    mundo.add(bola2);

    //mundo.remove(bomba3);
    
    bomba3.attachImage (Explo);
    
    bombaSlime.rewind();
    bombaSlime.play();
  }
  if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaBomba")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaBomba"))
  {

    bola1.matar();
    mundo.remove(bola2);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
    mundo.add(bola3);

    //mundo.remove(bomba1);
    
    bomba1.attachImage (Explo);
    
    bombaSlime.rewind();
    bombaSlime.play();
  }
  if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaBomba2")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaBomba2"))
  {

    bola1.matar();
    mundo.remove(bola2);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
    mundo.add(bola3);

    //mundo.remove(bomba2);
    bomba2.attachImage (Explo);
    
    
    bombaSlime.rewind();
    bombaSlime.play();
  }
  if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaBomba3")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaBomba3"))
  {

    bola1.matar();
    mundo.remove(bola2);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME
    mundo.add(bola3);

      //mundo.remove(bomba3);
    bomba3
    .attachImage (Explo);
    
    bombaSlime.rewind();
    bombaSlime.play();
  }
  if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaBomba")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaBomba"))
  {

    bola1.matar();
    mundo.remove(bola3);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME

    mundo.remove(bomba1);
    estado = "Fin";
    Perdi.rewind();
    Perdi.play();
    fondo.pause();

  }
  if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaBomba2")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaBomba2"))
  {

    bola1.matar();
    mundo.remove(bola3);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME

    mundo.remove(bomba2);
    estado = "Fin";
    Perdi.rewind();
    Perdi.play();
    fondo.pause();

    
  }
  if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaBomba3")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaBomba3"))
  {

    bola1.matar();
    mundo.remove(bola3);
    bola1 = new Bolas(55, 30);
    bola1.setPosition(100, 100);
    bola1.setRestitution(1.5);
    bola1.setDensity(50);
    bola1.attachImage (pelotaG);
    bola1.setGrabbable(true);
    bola1.setName("Bolas");////////////////////////// BOLA1  SETNAME

    mundo.remove(bomba3);
    estado = "Fin";
    Perdi.rewind();
    Perdi.play();
    fondo.pause();

  } 
  else if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaFlan")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaFlan"))
  {
    Reboflan.rewind();
    Reboflan.play();
  }
    else if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaFlan")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaFlan"))
  {
    Reboflan.rewind();
    Reboflan.play();
  }
      else if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaFlan")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaFlan"))
  {
    Reboflan.rewind();
    Reboflan.play();
  }
  //////////////////////////////////////////////////////////////////////////////////////NUBES//////////////////////////////////////////////////////////////////////////////////////
  
  else if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaNube")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaNube"))
  {
    mundo.remove(nube1);
  } 
  else if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaNube2")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaNube2"))
  {
    mundo.remove(nube2);
  }
  else if ((_body1.getName() == "Bolas" && _body2.getName() == "plataformaNube3")
    || (_body2.getName() == "Bolas" && _body1.getName() == "plataformaNube3"))
  {
    mundo.remove(nube3);
  }
  //--------------
  else if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaNube")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaNube"))
  {
    mundo.remove(nube1);
  } else if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaNube2")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaNube2"))
  {
    mundo.remove(nube2);
  } else if ((_body1.getName() == "Bolas2" && _body2.getName() == "plataformaNube3")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "plataformaNube3"))
  {
    mundo.remove(nube3);
  }
  //---------
  else if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaNube")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaNube"))
  {
    mundo.remove(nube1);
  } else if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaNube2")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaNube2"))
  {
    mundo.remove(nube2);
  } else if ((_body1.getName() == "Bolas3" && _body2.getName() == "plataformaNube3")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "plataformaNube3"))
  {
    mundo.remove(nube3);
  }
 /////////////////////////////////////////////////////////////////////////////////////PISO//////////////////////////////////////////////////////////////////////////////////////

  if ((_body1.getName() == "Bolas" && _body2.getName() == "marcoPiso")
    || (_body2.getName() == "Bolas" && _body1.getName() == "marcoPiso"))
  {
    mundo.remove(bola1);
    mundo.add(bola2);
    Piso.rewind();
    Piso.play();
  }
  if ((_body1.getName() == "Bolas2" && _body2.getName() == "marcoPiso")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "marcoPiso"))
  {
    mundo.remove(bola2);
    mundo.add(bola3);
    Piso.rewind();
    Piso.play();
  }
  if ((_body1.getName() == "Bolas3" && _body2.getName() == "marcoPiso")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "marcoPiso"))
  {
        vaso.rewind();
        vaso.play();

    mundo.remove(bola3);
    
    estado = "Fin";
    Perdi.rewind();
    Perdi.play();
    fondo.pause();
  }
  //////////////////////////////////////////////////////////////////////////////////////VASO//////////////////////////////////////////////////////////////////////////////////////

  if ((_body1.getName() == "Bolas3" && _body2.getName() == "Vaso")
    || (_body2.getName() == "Bolas3" && _body1.getName() == "Vaso") )
  {
    estrellas  +=1;
    estado = "Fin";
  }
  if ((_body1.getName() == "Bolas" && _body2.getName() == "Vaso")
    || (_body2.getName() == "Bolas" && _body1.getName() == "Vaso") )
  {
    vaso.rewind();
    vaso.play();

    estrellas  +=1;

    mundo.remove(bola1);
    mundo.add(bola2);
  }
  if ((_body1.getName() == "Bolas2" && _body2.getName() == "Vaso")
    || (_body2.getName() == "Bolas2" && _body1.getName() == "Vaso") )
  {
    vaso.rewind();
    vaso.play();

    estrellas  +=1;
    mundo.remove(bola2);
    mundo.add(bola3);
  }
}
