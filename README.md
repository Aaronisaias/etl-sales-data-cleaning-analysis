# 🛠️ ETL | Limpieza, Transformación y Análisis de Datos de Ventas

## 📌 Descripción

Este proyecto implementa un proceso ETL completo utilizando Python y Pandas para transformar un conjunto de datos de ventas con problemas de calidad en información limpia, consistente y preparada para análisis.

El dataset contiene errores intencionales similares a los que pueden encontrarse en sistemas reales:

- Formatos numéricos inconsistentes.
- Símbolos de moneda.
- Valores negativos.
- Fechas en múltiples formatos.
- Fechas corruptas.
- Inconsistencias de texto.
- Valores atípicos (Outliers).
- Estados y productos escritos de diferentes maneras.

El objetivo es construir un pipeline capaz de **detectar, limpiar, transformar y analizar estos problemas antes de utilizarlos para tomar decisiones de negocio.**

---

# 🎯 Objetivo del proyecto

Desarrollar un proceso ETL profesional dividido en tres etapas:

```text
EXTRACT
   ↓
TRANSFORM
   ↓
LOAD
   ↓
ANALYSIS
```

El proyecto busca demostrar cómo transformar datos desordenados en información confiable para análisis empresarial.

---

# 🔎 Problemas encontrados

## 1. Limpieza de columnas numéricas

La columna:

```text
Costo_Envio
```

contiene diferentes problemas:

- Símbolos `$`.
- Espacios innecesarios.
- Valores almacenados como texto.
- Valores nulos.
- Valores negativos.
- Valores atípicos.

Ejemplos:

```text
$40.0
 $ 40.0
-5.0
1200.0
```

### Solución

Se realiza una limpieza mediante métodos de cadenas y expresiones regulares para eliminar caracteres innecesarios.

Posteriormente se convierte la columna a un tipo numérico:

```python
pd.to_numeric()
```

Finalmente se identifican y tratan valores negativos y valores atípicos.

---

# 📅 2. Normalización de fechas

La columna:

```text
Fecha_Despacho
```

presenta múltiples formatos:

```text
YYYY-MM-DD
DD/MM/YYYY
DD-MM-YYYY
```

También existen valores corruptos:

```text
Sin_Fecha
```

### Solución

Las fechas se transforman a un formato estándar utilizando Pandas.

Los valores que no pueden convertirse correctamente se identifican como inválidos mediante:

```python
pd.to_datetime(
    errors="coerce"
)
```

Esto permite evitar que fechas corruptas contaminen el análisis.

---

# 📦 3. Inconsistencias de productos y estados

Los productos y estados pueden aparecer escritos de diferentes maneras.

Ejemplo:

```text
Laptop Gamer
laptop gamer
LAPTOP GAMER
```

Lo mismo puede ocurrir con los estados:

```text
Entregado
entregado
ENTREGADO
```

### Solución

Se realiza una estandarización de texto para obtener valores consistentes.

Por ejemplo:

```text
Laptop Gamer
```

se transforma en un único formato:

```text
Laptop Gamer
```

Esto permite agrupar correctamente los registros durante el análisis.

---

# 🚨 4. Outliers operativos

El dataset contiene valores que no representan correctamente el comportamiento esperado del negocio.

### Días de retraso

Se encuentran valores como:

```text
-3
90
```

Un valor negativo representa una situación lógicamente inválida y 90 días puede representar un valor atípico para este escenario.

### Monto total

También existen:

- Montos negativos.
- Valores excesivamente elevados.
- Registros que pueden distorsionar los indicadores financieros.

Estos valores son identificados durante la etapa de transformación antes de calcular las métricas finales.

---

# 🔄 Arquitectura ETL

## 1️⃣ Extract

Se obtiene la información desde:

```text
data/raw/desafio_analisis_ventas.csv
```

Utilizando:

```python
pandas.read_csv()
```

---

## 2️⃣ Transform

Durante esta etapa se realizan las principales operaciones de limpieza:

### Limpieza

- Eliminación de espacios.
- Estandarización de texto.
- Eliminación de símbolos de moneda.
- Conversión de tipos de datos.

### Validación

- Identificación de valores nulos.
- Detección de valores negativos.
- Detección de outliers.
- Detección de fechas inválidas.

### Transformación

- Conversión de `Costo_Envio` a numérico.
- Conversión de `Fecha_Despacho` a datetime.
- Normalización de productos.
- Normalización de estados.
- Tratamiento de valores inválidos.

---

# 📊 Análisis Exploratorio

Una vez finalizada la limpieza, se calculan métricas para responder preguntas de negocio.

## 1. Costo de envío real

### Pregunta

¿Cuál es el costo promedio real de envío por pedido después de eliminar errores y valores atípicos?

Esto permite conocer el costo operativo promedio sin que valores anormales distorsionen el resultado.

---

## 2. Tasa de incidencias

### Pregunta

¿Qué porcentaje de los envíos termina:

- Retrasado
- Cancelado

frente a los envíos exitosos?

Esta métrica permite evaluar la calidad operativa del proceso de entrega.

---

## 3. Impacto por producto

### Pregunta

¿Cuál es el producto que genera mayores ingresos brutos?

Se agrupan las ventas por producto para identificar cuáles tienen mayor impacto económico.

---

# 🧮 Métricas principales

El análisis final busca obtener:

```text
Costo promedio de envío
        ↓
Tasa de incidencias
        ↓
Ingresos por producto
        ↓
Producto con mayor facturación
```

---

# 🛠️ Tecnologías utilizadas

- Python
- Pandas
- SQL
- SQL Server
- pyodbc
- CSV
- ETL
- Data Cleaning
- Exploratory Data Analysis (EDA)

---

# 📂 Estructura del proyecto

```text
etl-sales-data-cleaning-analysis/
│
├── data/
│   └── raw/
│       └── desafio_analisis_ventas.csv
│
├── sql/
│   └── consultas.sql
│
├── src/
│   ├── extract.py
│   ├── transform.py
│   ├── analysis.py
│   ├── load.py
│   └── main.py
│
├── docs/
│   └── problema_analizar.txt
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

# 🧠 Habilidades demostradas

### Python

- Pandas
- Manipulación de DataFrames
- Limpieza de datos
- Conversión de tipos
- Tratamiento de valores nulos
- Automatización

### SQL

- Consultas de análisis
- Agregaciones
- `GROUP BY`
- `ORDER BY`
- `COUNT`
- `SUM`
- `AVG`
- Filtrado de datos

### Data Analysis

- Data Quality
- Exploratory Data Analysis
- Detección de Outliers
- Análisis de métricas
- Interpretación de datos

### ETL

- Extract
- Transform
- Load
- Validación de datos
- Preparación para análisis

---

# 🗄️ SQL

El archivo:

```text
sql/consultas.sql
```

contiene consultas destinadas a validar los datos y responder las principales preguntas de negocio.

Entre ellas:

- Costo promedio de envío.
- Cantidad de envíos.
- Estados de envío.
- Tasa de incidencias.
- Ingresos por producto.
- Ranking de productos.
- Identificación de valores inválidos.

---

# 🚀 Ejecución del proyecto

## 1. Clonar repositorio

```bash
git clone https://github.com/TU_USUARIO/etl-sales-data-cleaning-analysis.git
```

## 2. Entrar al proyecto

```bash
cd etl-sales-data-cleaning-analysis
```

## 3. Instalar dependencias

```bash
pip install -r requirements.txt
```

## 4. Ejecutar pipeline

```bash
python src/main.py
```

---

# 📌 Resultado esperado

Al finalizar el pipeline se obtiene un conjunto de datos:

- Limpio.
- Estandarizado.
- Validado.
- Sin valores inválidos utilizados en las métricas.
- Preparado para análisis.
- Listo para ser cargado en SQL Server.

El objetivo final es que las métricas obtenidas representen el comportamiento real del negocio y no estén distorsionadas por errores de calidad.

---

# 🎯 Enfoque profesional

Este proyecto no se limita a calcular métricas.

La prioridad es:

```text
DATOS SUCIOS
     ↓
AUDITORÍA
     ↓
DETECCIÓN DE ERRORES
     ↓
LIMPIEZA
     ↓
TRANSFORMACIÓN
     ↓
VALIDACIÓN
     ↓
ANÁLISIS
     ↓
DECISIÓN DE NEGOCIO
```

La idea fundamental es:

> **Antes de analizar los datos, hay que asegurarse de que los datos sean confiables.**

---

# 👨‍💻 Autor

**Aaron Isaias Medina**

**Data Analyst | Python | SQL | ETL | Power BI**
