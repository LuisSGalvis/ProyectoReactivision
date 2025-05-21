
class FiducialHandler {
  Errores errores;
  String mensaje = "Conecta tu PC y usa los marcadores para resolver los errores.";
  int ultimoID = -1;
  int intentos = 0;
  HashMap<Integer, String> accionesFiducial = new HashMap<Integer, String>();

  FiducialHandler(Errores errores) {
    this.errores = errores;
    accionesFiducial.put(1, "Cerrar procesos ocultos");
    accionesFiducial.put(2, "Liberar RAM");
    accionesFiducial.put(4, "Desfragmentar disco");
    accionesFiducial.put(5, "Enfriar CPU");
    accionesFiducial.put(6, "Optimizar procesos de inicio");
    accionesFiducial.put(8, "Escanear virus");
    accionesFiducial.put(11, "Optimizar batería");
  }

void procesarMarcador(int id) {
  ultimoID = id;
  intentos++;

  if (errores.esCorrecto(id)) {
    mensaje = "✅ ¡Acción correcta! Se resolvió uno de los errores.";
  } else {
    String accion = accionesFiducial.containsKey(id) ? accionesFiducial.get(id) : "acción desconocida";
    mensaje = "❌ El marcador " + id + " realiza esta acción: \"" + accion + "\",\npero no soluciona los errores actuales.";
  }

  if (errores.estaResueltoTodo()) {
    mensaje = "🎉 ¡Todos los errores han sido solucionados! Buen trabajo.";
  }
}


  void mostrarInstrucciones() {
    fill(30);
    textSize(16);
    textAlign(CENTER);
    text(mensaje, width/2, height - 60);
    
    textSize(12);
    text("Intentos: " + intentos + " | Último marcador leído: " + (ultimoID == -1 ? "Ninguno" : str(ultimoID)), width/2, height - 30);
  }
}
