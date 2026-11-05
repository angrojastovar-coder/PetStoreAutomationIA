# Contexto Técnico del Proyecto: PetStoreAutomation

## Resumen
El proyecto **PetStoreAutomation** es una solución de automatización de pruebas para servicios y aplicaciones basada en el ecosistema Java y gestionada a través de la herramienta de construcción **Gradle**.

Actualmente, el proyecto se encuentra en su fase inicial de configuración y estructuración base (*scaffolding*). Se ha inicializado a través de IntelliJ IDEA con soporte para lenguaje Java 21 y se han incorporado dependencias orientadas a pruebas BDD (Behavior-Driven Development), automatización de APIs REST (REST Assured / Apache HttpClient) y automatización Web (Selenium WebDriver). Sin embargo, al momento del análisis no existe implementación activa de pruebas: el archivo de características `CreateUser.feature` se encuentra vacío, no existen clases de ejecución (*Runners*), definiciones de pasos (*Step Definitions*), controladores de servicios o clientes HTTP implementados en el código fuente.

* **Ruta base del proyecto:** `C:\Users\angro\IdeaProjects\PetStoreAutomation`
* **Grupo y versión:** `org.example:PetStoreAutomation:1.0-SNAPSHOT`

---

## Arquitectura y módulos
El proyecto está configurado como un proyecto monomódulo estándar de Java gestionado mediante Gradle (Groovy DSL).

### Estructura de directorios y archivos identificados
```text
PetStoreAutomation/
├── .gradle/
├── .idea/
│   ├── compiler.xml
│   ├── gradle.xml
│   ├── misc.xml
│   └── workspace.xml
├── gradle/
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── IA/
│   ├── 01. prompt_context.md
│   └── context.md
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── org/
│   │   │       └── example/
│   │   │           └── Main.java
│   │   └── resources/
│   └── test/
│       ├── java/
│       └── resources/
│           └── Feature/
│               └── Create_user/
│                   └── CreateUser.feature
├── .gitignore
├── build.gradle
├── gradlew
├── gradlew.bat
└── settings.gradle
```

### Detalle de módulos y componentes actuales
* **Raíz (`/`):** Contiene la configuración de construcción `build.gradle`, configuración del proyecto `settings.gradle`, scripts de ejecución del wrapper (`gradlew`, `gradlew.bat`) y reglas de exclusión `.gitignore`.
* **Módulo principal (`src/main`):**
  * `src/main/java/org/example/Main.java`: Clase con método `main` generado automáticamente por la plantilla de IntelliJ IDEA. No contiene lógica de negocio ni de soporte para pruebas.
  * `src/main/resources`: Directorio reservado para recursos de producción (vacío).
* **Módulo de pruebas (`src/test`):**
  * `src/test/java`: Directorio de código fuente de pruebas (vacío; no hay runners, step definitions ni page objects/servicios).
  * `src/test/resources/Feature/Create_user/CreateUser.feature`: Archivo BDD en Gherkin (actualmente vacío, 0 bytes).
* **Módulo IA (`IA/`):** Almacena prompts y contextos operativos para la asistencia técnica del proyecto (`01. prompt_context.md` y `context.md`).
* **Wrapper Gradle (`gradle/wrapper/`):** Empaqueta la distribución autónoma de Gradle versión 9.6.0.

### Enfoque arquitectónico previsto
A partir del análisis de las dependencias, la arquitectura proyectada responde a un framework de automatización BDD híbrido con dos líneas principales:
1. Automatización de Servicios/API con **REST Assured** y **Apache HttpClient**.
2. Automatización de Interfaz de Usuario con **Selenium WebDriver**.
3. Orquestación mediante **Cucumber BDD** y motor de ejecución **JUnit Platform Engine**.

---

## Tecnología y versiones
A continuación se detalla la matriz tecnológica extraída de las configuraciones reales (`build.gradle`, `.idea/misc.xml`, `gradle-wrapper.properties`):

| Componente / Librería | Grupo / Artefacto | Versión | Propósito / Alcance |
| :--- | :--- | :--- | :--- |
| **Java SDK** | `JDK` | `21` | Lenguaje de programación base (`languageLevel="JDK_21"`) |
| **Gradle** | `gradle-wrapper` | `9.6.0` | Gestor de compilación, empaquetado y dependencias |
| **JUnit BOM** | `org.junit:junit-bom` | `6.0.0` | Gestión centralizada de dependencias JUnit |
| **JUnit Jupiter** | `org.junit.jupiter:junit-jupiter` | Gestionada | Motor principal de pruebas unitarias y aserciones |
| **JUnit Platform Launcher** | `org.junit.platform:junit-platform-launcher` | Gestionada | Lanzador de suites en la plataforma JUnit |
| **JUnit Platform Suite** | `org.junit.platform:junit-platform-suite` | Gestionada | Soporte para agrupamiento y suites de pruebas |
| **Cucumber Core** | `io.cucumber:cucumber-core` | `7.18.0` | Motor central de Cucumber BDD |
| **Cucumber Java** | `io.cucumber:cucumber-java` | `7.18.0` | Soporte de anotaciones y sintaxis BDD en Java |
| **Cucumber JUnit** | `io.cucumber:cucumber-junit` | `7.18.0` | Integración de Cucumber con JUnit 4 |
| **Cucumber Platform Engine** | `io.cucumber:cucumber-junit-platform-engine`| Gestionada / 7.13.0 BOM | Ejecutor de Cucumber bajo JUnit Platform |
| **Cucumber BOM** | `io.cucumber:cucumber-bom` | `7.13.0` | Bill of Materials para Cucumber |
| **TestNG** | `org.testng:testng` | `7.10.1` | Framework alternativo de pruebas funcionales |
| **REST Assured** | `io.rest-assured:rest-assured` | `5.3.1` | Validación y automatización de endpoints HTTP / REST APIs |
| **Selenium Java** | `org.seleniumhq.selenium:selenium-java` | `4.20.0` | Automatización de navegadores web |
| **Apache HttpClient** | `org.apache.httpcomponents:httpclient` | `4.5.14` | Cliente HTTP de bajo nivel |
| **Jackson Databind** | `com.fasterxml.jackson.core:jackson-databind` | `2.14.2` | Serialización y deserialización JSON / POJO |
| **AssertJ Core** | `org.assertj:assertj-core` | `3.23.1` | Aserciones fluidas |
| **Hamcrest** | `org.hamcrest:hamcrest` | `2.2` | Matchers declarativos de aserción |
| **Allure JUnit 5** | `io.qameta.allure:allure-junit5` | `2.23.0` | Generación de reportes gráficos y métricas de prueba |
| **Logback Classic** | `ch.qos.logback:logback-classic` | `1.4.5` | Implementación SLF4J para registro de eventos |
| **Logback Core** | `ch.qos.logback:logback-core` | `1.4.5` | Motor de logging |
| **Janino** | `org.codehaus.janino:janino` | `3.1.9` | Compilador Java embebido (soporte de evaluación dinámica en logging) |
| **OpenCSV** | `com.opencsv:opencsv` | `5.7.1` | Lectura y manipulación de archivos planos CSV para pruebas Data-Driven |
| **Apache Commons Lang3** | `org.apache.commons:commons-lang3` | `3.0` | Utilidades de manipulación de cadenas y datos aleatorios |
| **Vavr** | `io.vavr:vavr` | `1.0.0-alpha-4` | Estructuras de datos inmutables y programación funcional |

### Configuración del ejecutor de pruebas
En `build.gradle`, la tarea de ejecución de pruebas delega directamente a JUnit Platform:
```groovy
tasks.test {
    useJUnitPlatform()
}
```

---

## Contratos (si existen)
Actualmente **no existen contratos de API formales** (especificaciones OpenAPI/Swagger en archivos YAML/JSON, esquemas JSON Schema o contratos CDC con herramientas como Pact) definidos de manera local en el repositorio.

* **Inferencia de contrato:** A partir del nombre asignado al proyecto (`PetStoreAutomation`) y la estructura de directorios `Feature/Create_user/`, se infiere que las pruebas tendrán como objetivo el servicio público de Swagger Petstore, específicamente el recurso de administración de usuarios (`/v2/user` o `/v3/user`). Sin embargo, no se dispone de un archivo de especificación de esquema local al momento de este análisis.

---

## Módulos de datos
A la fecha **no existen modelos de datos, DTOs (Data Transfer Objects) ni POJOs implementados** en el código fuente.

* **Capacidades instaladas para datos:**
  * `com.fasterxml.jackson.core:jackson-databind:2.14.2` está instalado para mapear cargas útiles (*payloads*) JSON hacia clases Java.
  * `com.opencsv:opencsv:5.7.1` está instalado para admitir lectura de conjuntos de datos de prueba tabulares desde archivos CSV.
  * `org.apache.commons:commons-lang3:3.0` está integrado para la generación dinámica de datos de prueba (nombres, identificadores, cadenas aleatorias).

---

## Estándares y convenciones del código
* **Convención de paquetes:** `org.example` como espacio de nombres raíz inicial.
* **Organización del proyecto:** Cumple la disposición estándar de directorios de Gradle (`src/main/java`, `src/test/java`, `src/test/resources`).
* **Nomenclatura identificada:**
  * **Estructura BDD:** Se identifica una combinación heterogénea en la ruta de recursos: `Feature/Create_user/CreateUser.feature` (uso de PascalCase en la carpeta contenedora `Feature`, Snake_case / Lowercase en `Create_user`, y PascalCase en el archivo `.feature`).
  * **Clases Java:** Uso de PascalCase para clases (`Main.java`) y camelCase para métodos (`main`).
  * **Scripts de construcción:** `build.gradle` utiliza sintaxis mixta Groovy DSL (notación con paréntesis `implementation '...'` conviviendo con `testImplementation group: '...', name: '...'`).
* **Herramientas de calidad y estilo:** No se encuentran integrados plugins de control de estilo, linter o análisis estático de código (por ejemplo, Checkstyle, Spotless, PMD o SonarQube).

---

## Riesgos, supuestos y limitaciones

### Riesgos técnicos
1. **Coexistencia y conflicto entre JUnit 5 y TestNG:**
   Se encuentran definidas de forma simultánea las dependencias de `junit-jupiter` y `org.testng:testng`. Dado que la tarea de prueba en Gradle está configurada únicamente con `useJUnitPlatform()`, cualquier prueba escrita bajo anotaciones de TestNG no será descubierta ni ejecutada por defecto a través del comando `gradle test`. Se recomienda unificar el motor de ejecución en JUnit 5.
2. **Disparidad de versiones en Cucumber BOM vs dependencias directas:**
   En `build.gradle` se declara `io.cucumber:cucumber-bom:7.13.0` y al mismo tiempo se especifican versiones directas `7.18.0` para `cucumber-core`, `cucumber-java` y `cucumber-junit`. Esta disparidad puede provocar resolución inconsistente de dependencias transitivas. Se debe estandarizar a una única versión (preferentemente 7.18.0 o mediante su correspondiente BOM).
3. **Versión preliminar inestable en Vavr:**
   Se incluye `io.vavr:vavr:1.0.0-alpha-4`. El uso de una versión `alpha` en entornos de automatización representa riesgo de inestabilidad o cambios de firma respecto a la versión estable (`0.10.x`).
4. **Falta de modularización entre pruebas API y UI:**
   La inclusión concurrente de Selenium Java y REST Assured sin una estructura de paquetes definida corre el riesgo de generar acoplamiento entre la lógica de interfaz de usuario y la lógica de pruebas de servicios si no se delimitan claramente los módulos o responsabilidades arquitectónicas.

### Supuestos
1. Se asume que el destino de las pruebas será la API de Swagger Petstore, concentrándose en el flujo de creación de usuario documentado en la feature `CreateUser.feature`.
2. Se asume que el runner principal se implementará sobre JUnit Platform Suite (`@Suite` de JUnit 5) consumiendo `cucumber-junit-platform-engine`.

### Limitaciones
1. **Ausencia de código ejecutable de pruebas:**
   El proyecto se encuentra en un estado estrictamente preliminar. No existen archivos de pasos (*step definitions*), ni clases de orquestación (*runners*), ni utilitarios de conexión HTTP o WebDriver.
2. **Ausencia de parametrización y gestión de entornos:**
   No existen archivos de configuración ambiental (`cucumber.properties`, `allure.properties`, `application.properties` o similares) para definir `baseUrl`, timeouts o credenciales de forma dinámica o parametrizable.
3. **Ausencia de control de versiones Git:**
   El proyecto local no posee un repositorio Git inicializado (`.git` ausente), limitando el rastreo de cambios históricos y la integración continua (CI/CD) hasta que se configure el repositorio remoto.
