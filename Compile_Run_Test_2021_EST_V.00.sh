
#!/bin/bash
# === Mensaje bienvenida
echo Se va a compilar la practica 2020\/2021 con las dependencias y restricciones

# === Inputs ===
SRC_DIR=$PWD/src
BIN_DIR=/bin
MAIN=es/uned/lsi/eped/pract2020_2021/Main
JAVA_HOME_JDK=/Library/Java/JavaVirtualMachines/jdk-16.0.1.jdk/Contents/Home
TMP_FOLDER=$PWD/juego_de_pruebas_2021/tmp

if [ -z "$JAVA_HOME_JDK" ] 
    then
        if [ -z "$JAVA_HOME" ] 
            then 
	        echo Modifica la variable del archivo .sh JAVA_HOME_JDK 
	        read -rsp $'Press any key to continue...\n' -n 1 key
	        exit
	 else
	    JAVA_HOME_JDK="$JAVA_HOME"
	 fi
fi


# === Mostramos variables ===
echo Carpeta codigo = $SRC_DIR
echo Carpeta bin = $BIN_DIR
echo Clase principal = $MAIN
echo JAVA_HOME_JDK = $JAVA_HOME_JDK
echo  
echo 

# === Clean and make temp dir ===
echo Limpiando compilacion anterior
rm -rf "$TMP_FOLDER"
read -rsp $'Press any key to continue...\n' -n 1 key
echo Copiando archivos
if [ ! -e "$TMP_FOLDER" ]
    then
        mkdir "$TMP_FOLDER" 
fi 
mkdir "$TMP_FOLDER$BIN_DIR"
mkdir "$TMP_FOLDER/src"
mkdir "$TMP_FOLDER/src/es"
mkdir "$TMP_FOLDER/src/es/uned"
mkdir "$TMP_FOLDER/src/es/uned/lsi"
mkdir "$TMP_FOLDER/src/es/uned/lsi/eped"
mkdir "$TMP_FOLDER/src/es/uned/lsi/eped/pract2020_2021"
cp -r "$SRC_DIR/es/uned/lsi/eped/pract2020_2021/"* "$TMP_FOLDER/src/es/uned/lsi/eped/pract2020_2021"
echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key
# ===

# =============================
# === Compile ===
# =============================
echo Compilando en carpeta temporal
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/javac" -d "$TMP_FOLDER$BIN_DIR" -sourcepath "$TMP_FOLDER/src" -cp "juego_de_pruebas_2021/lib/TAD_modified.jar" "$TMP_FOLDER/src/"$MAIN".java"

"$JAVA_HOME_JDK/bin/javac" -d "$TMP_FOLDER$BIN_DIR" -sourcepath "$TMP_FOLDER/src" -cp "juego_de_pruebas_2021/lib/TAD_modified.jar" "$TMP_FOLDER/src/"$MAIN".java"

if [ $? -eq 1 ] 
    then
	echo Compilacion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Compilacion sin errores
echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key
# ===


# ==========================================================================================
# =============================
# === Run BQ Estudiantes PP ===
# =============================

echo Ejecutando el programa con bucket queue \(pocos pacientes y pocas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes PP ===
echo Comprobando bateria de pruebas para bucket queue \(pocos pacientes y pocas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_1000_10.dat" "erroresPP1.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_1000_10.dat" "erroresPP1.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key


# ================================================

# ==============================
# === Run BST Estudiantes PP ===
# ==============================

echo Ejecutando el programa con arbol de busqueda \(pocos pacientes y pocas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes PP ===
echo Comprobando bateria de pruebas para arbol de busqueda \(pocos pacientes y pocas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_1000_10.dat" "erroresPP2.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_10.dat" "juego_de_pruebas_2021/salida/Salida_1000_10.dat" "erroresPP2.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key




# ==========================================================================================
# =============================
# === Run BQ Estudiantes PM ===
# =============================

echo Ejecutando el programa con bucket queue \(pocos pacientes y muchas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes PM ===
echo Comprobando bateria de pruebas para bucket queue \(pocos pacientes y muchas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_1000_1000.dat" "erroresPM1.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_1000_1000.dat" "erroresPM1.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key


# ================================================

# ==============================
# === Run BST Estudiantes PM ===
# ==============================
echo Ejecutando el programa con arbol de busqueda \(pocos pacientes y muchas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes PM ===
echo Comprobando bateria de pruebas para arbol de busqueda \(pocos pacientes y muchas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_1000_1000.dat" "erroresPM2.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_1000_1000.dat" "juego_de_pruebas_2021/salida/Salida_1000_1000.dat" "erroresPM2.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key



# ==========================================================================================
# =============================
# === Run BQ Estudiantes MP ===
# =============================

echo Ejecutando el programa con bucket queue \(muchos pacientes y pocas prioridades\)
echo ATENCION: PUEDE TARDAR UN POCO
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes MP ===
echo Comprobando bateria de pruebas para bucket queue \(muchos pacientes y pocas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_20000_10.dat" "erroresMP1.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_20000_10.dat" "erroresMP1.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key


# ================================================


# ==============================
# === Run BST Estudiantes MP ===
# ==============================
echo Ejecutando el programa con arbol de busqueda \(muchos pacientes y pocas prioridades\)
echo ATENCION: PUEDE TARDAR UN POCO
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes MP ===
echo Comprobando bateria de pruebas para arbol de busqueda \(muchos pacientes y pocas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_20000_10.dat" "erroresMP2.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10.dat" "juego_de_pruebas_2021/salida/Salida_20000_10.dat" "erroresMP2.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key




# ==========================================================================================
# =============================
# === Run BQ Estudiantes MM ===
# =============================
echo Ejecutando el programa con bucket queue \(muchos pacientes y muchas prioridades\)
echo ATENCION: PUEDE TARDAR UN POCO
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BQ "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes MM ===
echo echo Comprobando bateria de pruebas para bucket queue \(muchos pacientes y muchas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_20000_10000.dat" "erroresMM1.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_20000_10000.dat" "erroresMM1.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key


# ================================================

# ==============================
# === Run BST Estudiantes MM ===
# ==============================
echo Ejecutando el programa con arbol de busqueda \(muchos pacientes y muchas prioridades\)
echo ATENCION: PUEDE TARDAR UN POCO
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat"

"$JAVA_HOME_JDK/bin/java" -cp "$TMP_FOLDER$BIN_DIR:juego_de_pruebas_2021/lib/TAD_modified.jar" "$MAIN" BST "juego_de_pruebas_2021/pruebas/JuegoPruebas_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo Ejecucion sin errores
read -rsp $'Press any key to continue...\n' -n 1 key

# === Comprobacion Estudiantes MM ===
echo Comprobando bateria de pruebas para arbol de busqueda \(muchos pacientes y muchas prioridades\)
# === DESCOMENTAR LA SIGUIENTE LINEA SI SE QUIERE IMPRIMIR LA ORDEN === 
# echo "$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_20000_10000.dat" "erroresMM2.txt"

"$JAVA_HOME_JDK/bin/java" -jar "juego_de_pruebas_2021/lib/Comparator.jar" "juego_de_pruebas_2021/salida/Salida_Estudiantes_20000_10000.dat" "juego_de_pruebas_2021/salida/Salida_20000_10000.dat" "erroresMM2.txt"

if [ $? -eq 1 ] 
    then
	echo Ejecucion con errores
	read -rsp $'Press any key to continue...\n' -n 1 key
	exit 1
fi

echo
echo
read -rsp $'Press any key to continue...\n' -n 1 key

exit
