# ProyectoPrueba – Pruebas de carga con k6 y GitHub Actions

Este repositorio contiene un proyecto **full-stack utilizado como entorno de pruebas de rendimiento**, donde se aplican **pruebas de carga con k6** integradas en **GitHub Actions** como parte de un flujo CI/CD.

El objetivo principal es demostrar:
- Cómo estructurar pruebas de carga
- Cómo automatizarlas en un pipeline
- Cómo interpretar métricas de rendimiento

---

## 📌 Descripción

El proyecto incluye una aplicación backend y frontend que sirven como sistema bajo prueba, sobre el cual se ejecutan **tests de carga con k6** para evaluar:

- Número de usuarios virtuales (VU)
- Latencia de respuesta
- Estabilidad bajo carga
- Porcentaje de solicitudes exitosas

Las pruebas se ejecutan automáticamente mediante **GitHub Actions** en eventos como push o pull request.

---

## 🧰 Tecnologías y herramientas

- **k6** – pruebas de carga y rendimiento  
- **GitHub Actions** – automatización CI/CD  
- **Node.js / Express** – backend de prueba  
- **Angular** – frontend de prueba  
- **JavaScript (ES Modules)**  
- **Firebase Hosting** (para despliegue del frontend)

---

## 🚀 Cómo usar este proyecto

### Prerrequisitos

- k6 instalado localmente  
- Node.js 18+  
- npm  

> Angular y base de datos se usan solo como entorno de prueba, no son obligatorios para ejecutar k6.

---

### 1. Clonar el repositorio

```bash
git clone https://github.com/JhordyMarcillo/ProyectoPrueba.git
cd ProyectoPrueba
```

### 2. Iniciar en backend
```bash
cd backend
npm install
npm run dev
```
### 3. Iniciar en frontend
```bash
cd frontend
npm install
ng serve
```

### 4. Ejecutar pruebas de k6 localmente
Asumiendo que tienes instalado k6, puedes correr:

```bash
k6 run script.js
```

## 📁 Estructura del proyecto
```text
ProyectoPrueba/
├── .github/workflows/         # Configuraciones de GitHub Actions
│   └── firebase-hosting-merge.yml
|   └── firebase-hosting-pull-request.yml     
|   └── main.yml           
├── backend/                   # Scripts de backend
│   └── k6-test  
│   └── src
│        └── config
│        └── controllers         
│        └── middleware
│        └── models
│        └── routes
│        └── test
│        └── types
│   └── otros archivos
├── frontend/                   # Scripts de frontend
│   └── src
│        └── app
│        └── assets
│        └── enviroments
│        └── otros archivos
├── README.md                  # Documentación del proyecto
├── package.json               # Dependencias y scripts (opcional)
└── otros archivos           
```

## 🧪 Integración con GitHub Actions
Este proyecto incluye un flujo en .github/workflows que:

- Instala k6 en el runner.
- Ejecuta uno o varios scripts de prueba.
- Muestra resultados en la consola de acciones de GitHub.

### Ejemplo mínimo de configuración:

```yaml
name: k6 Performance Tests

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  run-k6-tests:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - name: Setup k6
        uses: grafana/setup-k6@v1
      - name: Run k6 tests
        run: k6 run scripts/load-test.js

```
Así puedes automatizar pruebas y comprobar métricas clave sin intervención manual. 
DeepWiki

## 📊 Métricas evaluadas
Cuando se ejecutan pruebas de rendimiento con k6, normalmente se obtienen métricas como:

- **http_req_duration**: latencia de las solicitudes.
- **vus**: cantidad de usuarios virtuales.
- **checks**: porcentaje de transacciones exitosas.

## 📝 Licencia

Este proyecto está protegido bajo una licencia propietaria.
No se permite el uso, modificación ni redistribución del código sin autorización expresa del autor.

Consulta el archivo LICENSE para más detalles.

