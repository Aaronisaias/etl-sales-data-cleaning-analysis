from extract import extraccion
from transform import transform
from validate import validacion
from load import enviar_carpeta, cargua_servidor, consulta, preperar_datos, envio
from report import reporte

#Extraccion del Datos Normal
df = extraccion()

#Datos Normalizados
df, duplicados, nulls = transform(df)

#Cargua de Datos en la Carpeta
cargua_de_datos = enviar_carpeta(df)
conexion, cursor = cargua_servidor()
datos, columnas, placeholders = preperar_datos(df)
consultaa = consulta(columnas, placeholders)

#Errores detectados
errores = validacion(df)

#Reporte
report = reporte(df, duplicados, nulls, errores)

if len(errores) > 0:
    for error in errores:
        print(error)

print(envio(consultaa, datos, cursor))