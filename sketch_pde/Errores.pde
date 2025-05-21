class Errores {
  HashMap<String, Integer> errores = new HashMap<String, Integer>(); // nombre → id solución
  ArrayList<String> erroresActivos = new ArrayList<String>();
  int erroresTotales = 0;

  HashMap<String, PImage> imagenesErrores = new HashMap<String, PImage>(); // error → imagen

  Errores() {
    cargarImagenesErrores();         // ← carga las imágenes antes de generar errores
    generarErroresAleatorios();
  }

  void cargarImagenesErrores() {
    imagenesErrores.put("RAM saturada (uso > 90%)", loadImage("ram.png"));
    imagenesErrores.put("Programas pesados en segundo plano", loadImage("cerrar.png"));
    imagenesErrores.put("Batería sobrecargada", loadImage("bateria.png"));
    imagenesErrores.put("Fragmentación del disco", loadImage("desfrag.png"));
    imagenesErrores.put("Demasiados procesos de inicio", loadImage("cerrar.png"));
    imagenesErrores.put("Alta temperatura del CPU", loadImage("frio.png"));
  }

  void generarErroresAleatorios() {
    // Todos los posibles errores y su solución correcta
    HashMap<String, Integer> posibles = new HashMap<String, Integer>();
    posibles.put("RAM saturada (uso > 90%)", 2);
    posibles.put("Programas pesados en segundo plano", 1);
    posibles.put("Batería sobrecargada", 11);
    posibles.put("Fragmentación del disco", 4);
    posibles.put("Demasiados procesos de inicio", 7);
    posibles.put("Alta temperatura del CPU", 5);

    // Escoge 3 al azar sin repetir
    ArrayList<String> llaves = new ArrayList<String>(posibles.keySet());
    while (errores.size() < 3) {
      int r = int(random(llaves.size()));
      String err = llaves.get(r);
      if (!errores.containsKey(err)) {
        errores.put(err, posibles.get(err));
        erroresActivos.add(err);
      }
    }
    erroresTotales = erroresActivos.size();
  }

  void mostrarErrores() {
    fill(0);
    textAlign(LEFT);
    textSize(24);
    text("Diagnóstico del sistema conectado:", 50, 100);
    int y = 140;
    
    for (String e : erroresActivos) {
      text("- " + e, 60, y);
      
      // Mostrar imagen asociada si existe
      PImage img = imagenesErrores.get(e);
      if (img != null) {
        image(img, 500, y - 10, 50, 50); // Ajusta tamaño y posición si lo deseas
      }
      
      y += 60;
    }
  }

  boolean esCorrecto(int idFiducial) {
    for (String err : erroresActivos) {
      if (errores.get(err) == idFiducial) {
        erroresActivos.remove(err);
        return true;
      }
    }
    return false;
  }

  boolean estaResueltoTodo() {
    return erroresActivos.isEmpty();
  }
}
