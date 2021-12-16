"""
Gilberto Misrain Vicente Yoc
201503776
Graficas para proyecto electronica 6
"""
from matplotlib import pyplot as plt #Importa pyplot para realizar la gráfica.
from matplotlib import animation  #Importa animation que permite actualizar la gráfica en intervalos concretos
from matplotlib import style #Permite cambiar el estilo de nuestra gráfica.
import serial #Importa librería para trabajar con el puerto serie.

style.use('fivethirtyeight')  #Cambia el estilo de nuestra gráfica.

fig = plt.figure() #Creamos un objeto para almacenar el la gráfica.

ax1 = fig.add_subplot(1,5,1) #Añadimos una "subgráfica" a nuestra ventana.
ax2 = fig.add_subplot(1,5,2) #Añadimos una "subgráfica" a nuestra ventana.
ax3 = fig.add_subplot(1,5,3)
ax4 = fig.add_subplot(1,5,4)
ax5 = fig.add_subplot(1,5,5)

ser = serial.Serial('COM5', 115200) #Abrimos puerto Serie, 'dev/ttyUSB0','COM2', 'COM3'

ser.readline()

def plotea (i):
     dedo1 = []
     dedo2 = []
     dedo3 = []
     dedo4 = []
     dedo5 = []
     for i in range(0,50): #Bucle for para recibir 50 valores anets de pintarlos.
        
        datoString = ser.readline()  #Leemos una línea enviada (hasta que se recibe el carácter ,).
        
        datos = str(datoString).split(",")
        dedo1.append(datos[0][2:])
        dedo2.append(datos[1][:4])
        dedo3.append(datos[2][:4])
        dedo4.append(datos[3][:4])
        dedo5.append(datos[4][:-5])
        
        print (dedo1[i] + " " + dedo2[i] + " " + dedo3[i] + " " + dedo4[i] + " " + dedo5[i] )
       
     ax1.clear() #Limpiamos la gráfica para volver a pintar.
     ax1.set_ylim([0,5]) #Ajustamos el límite vertical de la gráfica.
     
     ax2.clear() #Limpiamos la gráfica para volver a pintar.
     ax2.set_ylim([0,5]) #Ajustamos el límite vertical de la gráfica.
     
     ax3.clear()
     ax3.set_ylim([0,5])
     
     ax4.clear()
     ax4.set_ylim([0,5])
     
     ax5.clear()
     ax5.set_ylim([0,50])
     try:  #Nos permite comprobar si hay un error al ejecutar la siguiente instrucción.
         ax1.plot(range(0,50), dedo1) # Plotea los datos en x de 0 a 100.
         ax2.plot(range(0,50), dedo2) # Plotea los datos en x de 0 a 100.
         ax3.plot(range(0,50), dedo3)
         ax4.plot(range(0,50), dedo4)
         ax5.plot(range(0,50), dedo5)
         
         
     except UnicodeDecodeError: #Si se produce el error al plotear no hacemos nada y evitamos que el programa se pare.
        pass
         

ani = animation.FuncAnimation(fig, plotea, interval = 1) #Creamos animación para que se ejecute la función plotea con un intervalo de 1ms.

plt.show() #Muestra la gráfica.