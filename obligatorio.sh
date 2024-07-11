#!/bin/bash
#Emma Coates - 302546
#Sara Sellanes - 269594

#pedir usuario y contrasenia para ingresar al menu
echo "Ingrese usuario"
read usuario
echo "Ingrese contrasenia"
read contrasenia

#inicializar variable para verificar que el usuario es valido
esta=0

#inicializar variable para verificar que el usuario dado de alta no exista previamente
existe=0


listarUsuarios(){
	#Ruta al archivo de texto donde se almacenan los usuarios
	archivo="/home/alumno/Escritorio/documento.txt"

	#Bucle para leer linea por linea el archivo de texto
	while IFS= read -r nombre && IFS= read -r contra && IFS= read -r guion; do
	#muestra los usuarios registrados
	echo "$nombre"
	done < "$archivo"
}
#listarUsuarios

altaUsuario(){
	#pide los datos del nuevo usuario
	echo "Ingrese usuario"
	read nuevoUsuario
	echo "Ingrese contrasenia"
	read nuevaContrasenia
	archivo="/home/alumno/Escritorio/documento.txt"

	#Verifica que el usuario ingresado no exista previamente
	while IFS= read -r nombre && IFS= read -r contra && IFS= read -r guion; do
		if [[ "$nuevoUsuario" == "$nombre" ]]; then
			existe=1
			echo "este usuario ya existe, intente nuevamente"
			break
		fi
	done < "$archivo"
	#si el usuario ya existe, termina la funcion

	if [[ "$existe" -eq 0 ]]; then
		echo "$nuevoUsuario" >> documento.txt
		echo "$nuevaContrasenia" >> documento.txt
		echo "#" >> documento.txt
		echo "Usuario agregado con exito!"
	fi
	#el usuario no existe, entonces se agrega al archivo de texto
}
#altaUsuario


letraI=""
letraInicio(){
#se pide la letra de inicio y se la muestra al usuario
	echo "ingrese lerta inicial"
	read letraI
	echo "la letra ingresada es $letraI"
}
#letraInicio


letraF=""
letraFin(){
#se pide la letra de fin y se la muestra al usuario
	echo "ingrese letra final"
	read letraF
	echo "la letra ingresada es $letraF"
}
#letraFin


letraC=""
letraContenida(){
#se pide la letra contenida y se la muestra al usuario
	echo "ingrese letra contenida"
	read letraC
	echo "la letra ingresada es $letraC"
}
#letraContenida

#definimos las variables antes de ejecutar la funcion que consulta el diccionario 
fecha=""
palabrastotales=0
porcentaje=0
palabrasdiccionario=0
consultarDiccionario(){

#Verificar que palabras cumplen con las condiciones y mostrarlo en consola
grep -e "^$letraI" diccionario.txt | grep -e "$letraC" | grep -e "$letraF$"
palabrasdiccionario=$(grep -e "^$letraI" diccionario.txt | grep -e "$letraC" | grep -e "$letraF$" | wc -l)

#Se obtiene la fecha actual
fecha=$(date +"%Y-%m-%d")

#Contar la cantidad de palabras en el diccionario
palabrastotales=$(wc -l < diccionario.txt)

#Calcular el porcentaje de palabras en el diccionario que cumplen las condiciones
porcentaje=$(echo "scale=2; ($palabrasdiccionario * 100) / $palabrastotales" | bc)

#Guardar todos los datos en un archivo de texto
echo "datos:" >> consultardiccionario.txt
echo "$fecha" >> consultardiccionario.txt
echo "$palabrasdiccionario" >> consultardiccionario.txt
echo "$palabrastotales" >> consultardiccionario.txt
echo "$porcentaje" >> consultardiccionario.txt
echo "$usuario" >> consultardiccionario.txt

#Llamar al archivo
echo >> consultardiccionario.txt

#Actualizamos las variables cada vez que se hace una consulta
fecha=""
palabrastotales=0
palabrasdiccionario=0
porcentaje=0
letraI=""
letraF=""
letraC=""

}


vocal=""
ingresarVocal(){
#se pide la vocal  y se la muestra al usuario
	echo "ingrese vocal"
	read vocal
	if [[ "$vocal" = ^[aeiouAEIOU]$ ]]; then
		echo "la vocal ingresada es $vocal"
	else
		echo "ingrese una vocal valida"
	fi
}
#ingresarVocal


diccionarioVocal(){
}
#diccionarioVocal


algoritmo1(){
#Solicitar la cantidad de datos
	echo "Cuantos datos desea ingresar?"
	read datos

#Inicializar las variables para la suma, maximo y minimo
	suma=0
	minimo=9999999
	maximo=-9999999

#solicitar los datos y realizar los calculos
	for (( i=0; i<datos; i++ )); do
	echo "Ingrese dato"
	read dato
	suma=$(( suma + dato ))
	if (( dato > maximo )); then
		maximo=$dato
	fi
	if (( dato < minimo )); then
		minimo=$dato
	fi
	done

#Calcular el promedio
	promedio=$(( suma / datos ))

#Mostrar los resultados
	echo "el promedio de los datos es: $promedio"
	echo "el menor dato ingresado es: $minimo"
	echo "el mayor dato ingresado es: $maximo"

}


algoritmo2(){
#se pide la palabra a analizar
	echo "Ingrese una palabra"
	read $palabra

#se define la variable palinv como la inversa de la palabra
	palinv= $palabra | rev

#se compara palabra y palinv para verificar si es capicua
	if [[ "$palabra" == "$palinv" ]]; then
	echo "Es capicua"
	else
	echo "No es capicua"
	fi
}

menuInicial(){
#se listan las opciones que el usuario puede elegir
while true; do
	echo "1. Listar usuarios registrados"
	echo "2. Dar de alta un usuario"
	echo "3. Configurar letra de inicio"
	echo "4. Configurar letra de fin"
	echo "5. Configurar letra contenida"
	echo "6. Consultar diccionario"
	echo "7. Ingresar vocal"
	echo "8. Listar las palabras del diccionario que cumplan que contengan la vocal"
	echo "9. Algoritmo 1"
	echo "10. Algoritmo 2"
	echo "11. Salir"
	read opcion

#se vinculan las opciones con sus respectivas funciones a ejecutar
	case $opcion in #para que sirve el case
	1) listarUsuarios ;;
	2) altaUsuario ;;
	3) letraInicio ;;
	4) letraFin ;;
	5) letraContenida ;;
	6) consultarDiccionario ;;
	7) ingresarVocal ;;
	8) diccionarioVocal ;;
	9) algoritmo1 ;;
	10) algoritmo2 ;;
	11) break ;;
	esac
done
}

verificarUsuario(){
	#Ruta al archivo de texto donde se guardan los usuarios
	 archivo="/home/alumno/Escritorio/documento.txt"
        #Bucle que recorre y lee el archivo de los usuarios linea por linea
	while IFS= read -r nombre && IFS= read -r contra && IFS= read -r guion; do
	#Se verifica que el usuario y contrasenia se encuentren en el archivo
        if [[ "$usuario" == "$nombre" && "$contrasenia" == "$contra" ]]; then
                esta=1
                break
        fi
        done < "$archivo"
        if [[ "$esta" -eq 1 ]]; then
	#Si el usuario se encuentra en el archivo, se abre el menu principal
        menuInicial
        else
         echo "usuario o contrasenia no valida"
        fi
}
verificarUsuario
