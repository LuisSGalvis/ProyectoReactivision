import TUIO.*;

TuioProcessing tuio;
FiducialHandler handler;
Errores errores;
PImage pestaña;
PImage peligro;
PImage finale;
float pestañaX = 1200; // fuera de pantalla al inicio
float pestañaY = 300;
int tiempoInicio= -1;
int tiempoInicio2=-1;
boolean mostrarLogo = false;
boolean abriendo = false;
boolean advertencia = false;
boolean animacionIniciada = false;

boolean esperandoAntesDeLogo = false;
int tiempoEspera = -1;
boolean anticipacionActiva = false;
float anticipacionX = 0;
boolean logoFinalizado = false; 

boolean animacionFinalActiva = false;
int tiempoInicioFinal = -1;
float rotacionFinal = 0;

PImage portada;
boolean mostrandoPortada = true;
boolean haciendoFadeOut = false;
boolean haciendoFadeIn = false;
int fadeStartTime = 0;
int fadeDuration = 1000; // 1 segundo

void setup() {
  size(900, 600);
  tuio = new TuioProcessing(this);
  errores = new Errores();
  handler = new FiducialHandler(errores);
  pestaña = loadImage("pestana.jpeg");
  peligro = loadImage("peligro.png");
  finale = loadImage("Final.jpeg");
  portada = loadImage("portada.jpeg"); // o el nombre de tu imagen

}

void draw() {
  if (mostrandoPortada) {
  int fade=255;
  imageMode(CENTER);
  tint(255, fade);
  image(portada, width/2, height/2, width, height);

  if (haciendoFadeOut) {
    int elapsed = millis() - fadeStartTime;
    float alpha = map(elapsed, 0, fadeDuration, 0, 255);
    fill(0, constrain(alpha, 0, 255));
    rect(0, 0, width, height);

    if (elapsed >= fadeDuration) {
      fade=0;
      haciendoFadeOut = false;
      haciendoFadeIn = true;
      fadeStartTime = millis(); // iniciar fade in

    }
  } else if (haciendoFadeIn) {
    int elapsed = millis() - fadeStartTime;
    float alpha = map(elapsed, 0, fadeDuration, 255, 0);
    fill(0, constrain(alpha, 0, 255));
    rect(0, 0, width, height);

    if (elapsed >= fadeDuration) {
      haciendoFadeIn = false;
      mostrandoPortada = false;
    }
  }

  return; // Detiene el resto de draw() mientras estamos en portada
  }

  background(245);
  fill(0);
  textAlign(CENTER);
  textSize(24);
  text("Puesto de Autocuidado Digital Universitario", width/2, 40);
  handler.mostrarInstrucciones(); // dice qué hacer y muestra resultado

  if (abriendo) {
    if (millis() - tiempoInicio < 2000) {
      float alpha = map(sin(frameCount * 0.05), -1, 1, 0, 255); // animación de opacidad
      tint(255, alpha);
      imageMode(CENTER);
      image(peligro, width/2, height/2);
      noTint();
    } else {
      advertencia = true;
      abriendo = false;
    }
  }

  if (pestañaX > 500 && advertencia) {
    pestañaX -= 1.5;
    
    // Saltitos verticales al avanzar
    pestañaY = 300 + sin(frameCount * 0.2) * 8;
    
  } else if (advertencia && !esperandoAntesDeLogo) {
    // Ha llegado, iniciar espera de 1 segundo antes de mostrar animación
    esperandoAntesDeLogo = true;
    tiempoEspera = millis();
    pestañaY = 300; // se estabiliza
  }

  if (esperandoAntesDeLogo && millis() - tiempoEspera >= 1000 && !mostrarLogo) {
    mostrarLogo = true;
    anticipacionActiva = true;
    tiempoInicio2 = millis();
  }

  // Mostrar la pestaña deslizándose o fija
  if (!mostrarLogo) {
    image(pestaña, pestañaX, pestañaY);
  }

  // Animación de desaparición con anticipación
  if (mostrarLogo && !logoFinalizado) {
  int duracion = 2000;
  int tiempoTranscurrido = millis() - tiempoInicio2;

  float x = width/2;
  float y = height/2;

  // Anticipación (primeros 300ms)
  if (tiempoTranscurrido < 300 && anticipacionActiva) {
    anticipacionX = sin(tiempoTranscurrido * 0.1) * 20;
    x += anticipacionX;
  } else {
    anticipacionActiva = false;
  }

  if (tiempoTranscurrido < duracion) {
    float progreso = tiempoTranscurrido / float(duracion);
    float alpha = map(1 - progreso, 0, 1, 0, 255);
    float rotacion = TWO_PI * 3 * progreso;

    tint(255, alpha);
    pushMatrix();
    translate(x, y);
    rotate(rotacion);
    image(pestaña, 0, 0);
    popMatrix();
    noTint();
  } else {
    // Termina la animación SOLO UNA VEZ
    mostrarLogo = false;
    logoFinalizado = true;
  }
}
if (logoFinalizado) {
  errores.mostrarErrores();
}
if (errores.estaResueltoTodo()) {
  if (!animacionFinalActiva) {
    animacionFinalActiva = true;
    tiempoInicioFinal = millis();
  }

  int tiempo = millis() - tiempoInicioFinal;

  pushMatrix();
  // Mover al punto de pivote (esquina inferior izquierda)
  translate(450, 300);
  translate(-finale.width/2, finale.height/2);

  // Animación de rotación
  if (tiempo < 750) {
    rotacionFinal = radians(-25) * (tiempo / 750.0); // 0° a 25°
  } else if (tiempo < 1250) {
    float t = (tiempo - 750) / 500.0;
    rotacionFinal = radians(-25 + 55 * t); // 25° a -40°
  } else {
    rotacionFinal = radians(30); // queda fijo en -40°
  }

  rotate(rotacionFinal);

  // Volver al centro para dibujar la imagen
  translate(finale.width/2, -finale.height/2);
  imageMode(CENTER);
  image(finale, 0, 0);
  popMatrix();
}


}

//KeyPressed
void keyPressed() {
  if ((key == 'a'|| key==' ') && !mostrandoPortada)
  {
  tiempoInicio = millis();
  abriendo = true;

  }
  if (mostrandoPortada && key == 's') {
  haciendoFadeOut = true;
  fadeStartTime = millis();
  }

}


// Eventos TUIO
void addTuioObject(TuioObject tobj) {
  handler.procesarMarcador(tobj.getSymbolID());
}

void updateTuioObject(TuioObject tobj) {
  // opcional
}

void removeTuioObject(TuioObject tobj) {
  // opcional
}
