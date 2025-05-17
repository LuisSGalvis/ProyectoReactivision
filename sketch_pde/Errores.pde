class Errores {
  HashMap<String, Integer> errores = new HashMap<String, Integer>(); // nombre → id solución
  ArrayList<String> erroresActivos = new ArrayList<String>();
  int erroresTotales = 0;
  
  Errores() {
    generarErroresAleatorios();
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

    // Escoge 3 al azar
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
    textSize(18);
    text("Diagnóstico del sistema conectado:", 50, 100);
    int y = 140;
    for (String e : erroresActivos) {
      text("- " + e, 60, y);
      y += 30;
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
