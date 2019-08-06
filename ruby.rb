# Definicion de palabras reservadas y defniciones
$palabrasReservadas = %w[echo print printf]
$traducciones = {"echo" => "puts"}

#Metodo que ayuda a consultar si es una palabra reservada
def palabraReservada?(palabra)
    return $palabrasReservadas.include? palabra
end

#Consulta la traducción de la palabra reservada detectada
def traducir(palabra)
    return $traducciones[palabra]
end

#Metodo para escribir al archivo de salida
def escribirArchivo(palabra)
    file = File.open("traducido.rb", "a+")
    if palabraReservada?(palabra)
        file.write($traducciones[palabra])
    else
        file.write(palabra)
    end
    file.close
end


#Lectura del archivo e iteración en cada linea
IO.foreach('bash.sh') do |line|
    #Si la linea empieza con comentario y nueva linea se omite
    next if line.start_with?("#")
    next if line.start_with?("\n")
    #Se define variables auxiliares
    pArmada = ""
    indice = 0
    #Separamos la linea en un arreglo de caracteres
    letras = line.split("""")
    #Trabajamos cada letra utilizando el indice antes definido
    while (indice < letras.size)
        if letras[indice]!= " " && letras[indice] != "\n"
            pArmada = pArmada + letras[indice]
            indice = indice + 1
        else
            if letras[indice] == " "
                indice = indice +1
                escribirArchivo(pArmada)
                escribirArchivo(" ")
                pArmada = ""
            elsif letras[indice] == "\n"
                escribirArchivo(pArmada)
                escribirArchivo("\n")
                pArmada = ""
                break
            end
        end

    end
end


