Este programa en ensamblador para el **PIC16F628A** controla un letrero dinámico. Según el valor en **PORTA**, 
el programa ejecuta un desplazamiento hacia la derecha o izquierda en **PORTB**, iluminando los LEDs en secuencia 
para simular movimiento. Usa subrutinas (`turn_right` y `turn_left`) para los desplazamientos y un retardo (`Deley`)
entre pasos.
