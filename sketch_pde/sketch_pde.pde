import TUIO.*;

TuioProcessing tuio;
FiducialHandler handler;
Errores errores;

void setup() {
  size(900, 600);
  tuio = new TuioProcessing(this);
  errores = new Errores();
  handler = new FiducialHandler(errores);
}

void draw() {
  background(245);
  
  fill(0);
  textAlign(CENTER);
  textSize(24);
  text("Puesto de Autocuidado Digital Universitario", width/2, 40);
  
  errores.mostrarErrores();     // muestra errores activos
  handler.mostrarInstrucciones(); // dice qué hacer y muestra resultado
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
