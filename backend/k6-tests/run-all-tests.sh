#!/bin/bash

# Script para ejecutar todas las pruebas de K6 del sistema SPA Modern
# Asegúrate de que el backend esté ejecutándose en http://localhost:3000

echo " Iniciando suite completa de pruebas K6 para SPA Modern Backend"
echo "=============================================================="

# Verificar que K6 esté instalado
if ! command -v k6 &> /dev/null; then
    echo " K6 no está instalado. Por favor instálalo desde https://k6.io/docs/get-started/installation/"
    exit 1
fi

# Verificar que el backend esté ejecutándose
echo " Verificando que el backend esté disponible..."
if ! curl -s http://localhost:3000/health > /dev/null; then
    echo "El backend no está disponible en http://localhost:3000"
    echo "   Por favor inicia el backend antes de ejecutar las pruebas"
    exit 1
fi
echo " Backend disponible"

# Crear directorio de resultados
RESULTS_DIR="./results/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

echo ""
echo " Los resultados se guardarán en: $RESULTS_DIR"
echo ""

# Función para ejecutar una prueba
run_test() {
    local test_name=$1
    local test_file=$2
    local description=$3
    
    echo " Ejecutando: $test_name"
    echo "   $description"
    echo "   Archivo: $test_file"
    echo "    Iniciado a las $(date '+%H:%M:%S')"
    
    # Ejecutar la prueba y capturar la salida
    k6 run "$test_file" --out json="$RESULTS_DIR/${test_name}-raw.json" > "$RESULTS_DIR/${test_name}-output.txt" 2>&1
    
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo "    Completado exitosamente"
    else
        echo "     Completado con advertencias (código: $exit_code)"
    fi
    
    echo "    Resultados guardados en $RESULTS_DIR/${test_name}-*"
    echo ""
}

# Ejecutar las pruebas en orden
echo " Comenzando ejecución de pruebas..."
echo ""

# 1. Health Check Test
run_test "health-check" "health-check.js" "Prueba básica de salud del sistema"

# Pausa entre pruebas
echo "  Pausa de 30 segundos entre pruebas..."
sleep 30

# 2. Authentication Load Test
run_test "auth-load" "auth-load-test.js" "Prueba de carga del sistema de autenticación"

# Pausa entre pruebas
echo "  Pausa de 60 segundos entre pruebas..."
sleep 60

# 3. CRUD Operations Test
run_test "crud-operations" "crud-operations.js" "Prueba de operaciones CRUD bajo carga"

# Pausa entre pruebas
echo "  Pausa de 90 segundos entre pruebas..."
sleep 90

# 4. Stress Test
run_test "stress-test" "stress-test.js" "Prueba de estrés con alta concurrencia"

# Pausa entre pruebas
echo "  Pausa de 120 segundos entre pruebas..."
sleep 120

# 5. Spike Test
run_test "spike-test" "spike-test.js" "Prueba de picos súbitos de tráfico"

# Pausa entre pruebas
echo "  Pausa de 60 segundos antes de la prueba final..."
sleep 60

# 6. Sustained Load Test (opcional - comentada por defecto debido a duración)
echo "  Prueba de carga sostenida omitida (15+ minutos de duración)"
echo "   Para ejecutarla manualmente: k6 run sustained-load-test.js"
# run_test "sustained-load" "sustained-load-test.js" "Prueba de carga sostenida (15+ minutos)"

echo ""
echo " Suite de pruebas completada!"
echo "=============================================================="
echo " Todos los resultados están en: $RESULTS_DIR"
echo ""
echo " Resumen de archivos generados:"
ls -la "$RESULTS_DIR"
echo ""
echo " Para analizar los resultados:"
echo "   - Revisa los archivos *-output.txt para resúmenes legibles"
echo "   - Los archivos *-raw.json contienen métricas detalladas"
echo "   - Los archivos *-results.json contienen resúmenes estructurados"
echo ""
echo " Para pruebas individuales futuras:"
echo "   k6 run health-check.js"
echo "   k6 run auth-load-test.js"
echo "   k6 run crud-operations.js"
echo "   k6 run stress-test.js"
echo "   k6 run spike-test.js"
echo "   k6 run sustained-load-test.js"
