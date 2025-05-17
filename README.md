# Proyecto Reactivision - Puesto de Autocuidado Digital Universitario

Este proyecto fue desarrollado como parte del curso de Interacción Humano-Computador. Su objetivo es prototipar una solución tangible e interactiva para fomentar el mantenimiento preventivo de computadores en entornos universitarios, con el fin de reducir la obsolescencia temprana y promover el uso responsable de la tecnología.

## Descripción general

El sistema simula el funcionamiento de un **puesto físico de autocuidado digital** ubicado en la universidad. Este puesto permite a los estudiantes conectar sus computadores para recibir un diagnóstico técnico simulado. A partir de dicho diagnóstico, el estudiante debe utilizar **marcadores físicos (fiduciales)** reconocidos mediante **Reactivision** para ejecutar las acciones de solución correspondientes.

La interacción busca representar una experiencia educativa, tangible y lúdica que incentive el cuidado del equipo, haciendo uso de tecnologías accesibles y conceptos de diseño centrado en el humano.

## Tecnologías utilizadas

- **Processing**: desarrollo del prototipo visual e interactivo.
- **Reactivision**: software de reconocimiento de marcadores físicos (fiduciales).
- **Protocolo TUIO**: comunicación entre Reactivision y Processing.
- **HashMaps y estructuras de control**: para mapear errores, soluciones y acciones de retroalimentación.

## Funcionamiento del sistema

1. Al iniciar, el programa genera aleatoriamente tres errores técnicos simulados en el computador conectado.
2. Los errores se muestran en pantalla con una breve explicación y el número del marcador que puede solucionarlos.
3. El estudiante debe colocar los marcadores físicos correctos frente a la cámara.
4. El sistema identifica el marcador:
   - Si corresponde a uno de los errores activos, lo resuelve parcialmente y actualiza el estado.
   - Si no corresponde, se muestra la acción que representa ese marcador y se indica que no aplica a los errores actuales.
5. Una vez se resuelven todos los errores correctamente, el sistema informa al usuario que el mantenimiento ha sido exitoso.

## Lista de marcadores y acciones representadas

| Fiducial ID | Acción representada             |
|-------------|---------------------------------|
| 1           | Cerrar procesos ocultos         |
| 2           | Liberar memoria RAM             |
| 4           | Desfragmentar disco duro        |
| 5           | Enfriar el procesador (CPU)     |
| 6           | Optimizar procesos de inicio    |
| 8           | Escanear sistema en busca de virus |
| 11          | Optimizar batería               |

Los marcadores pueden imprimirse desde la plataforma oficial de Reactivision. Se recomienda etiquetarlos visualmente para que los estudiantes puedan identificarlos fácilmente durante el uso.

## Requisitos para ejecución

1. Tener instalado **Processing** (https://processing.org).
2. Tener instalada la librería **TUIO** en Processing.
3. Ejecutar **Reactivision** con la cámara apuntando a la superficie donde se colocarán los marcadores.
4. Abrir el sketch en Processing (`sketch.pde`) y ejecutar el programa.
