# Language: en
@web @signup
Feature: Registro de Nueva Cuenta de Usuario (Sign Up) con Verificación de Persistencia
  Como un usuario nuevo de JPetStore
  Quiero registrar mis credenciales, datos de contacto, dirección y preferencias
  Para disponer de una cuenta activa en el sistema y poder iniciar sesión exitosamente en la tienda

  Background:
    Given que el usuario navega a la página de registro de PetStore "https://petstore.octoperf.com/account/new"

  # ---------------------------------------------------------------------------
  # FLUJOS POSITIVOS Y VERIFICACIÓN DE PERSISTENCIA
  # ---------------------------------------------------------------------------

  @smoke @positive
  Scenario: TC-SIGNUP-01 - Registro exitoso con valores por defecto en preferencias mediante tabla de datos sin inicio automático de sesión
    When completa el formulario de registro con los siguientes datos requeridos:
      | campo           | valor                                   |
      | User ID         | Agrojast18                              |
      | New password    | Passw0rd!+                              |
      | Repeat password | Passw0rd!+                              |
      | First name      | Carlos                                  |
      | Last name       | Tester                                  |
      | Email           | generado en tiempo de ejecución (único) |
      | Phone           | +123456789                              |
      | Address 1       | Av. Central 123                         |
      | Address 2       | [VACIO]                                 |
      | City            | Bogotá                                  |
      | State           | Cundinamarca                            |
      | Zip             | 110111                                  |
      | Country         | Colombia                                |
    And verifica que las opciones de perfil se encuentran en su estado predeterminado:
      | preferencia         | valor_esperado |
      | Language Preference | english        |
      | Favourite Category  | FISH           |
      | Enable MyList       | desmarcado     |
      | Enable MyBanner     | desmarcado     |
    And hace clic en el botón "Save Account Information"
    Then el sistema procesa el registro exitosamente y redirige a la página principal "/catalog"
    And la URL actual del navegador contiene "/catalog"
    And la cabecera superior confirma que la sesión no fue iniciada automáticamente al no mostrar el enlace "Sign Out" ni el saludo de bienvenida

  @regression @positive
  Scenario: TC-SIGNUP-02 - Registro exitoso personalizando idioma, categoría favorita, opciones de perfil y dirección complementaria mediante tabla de datos
    When completa el formulario de registro con los siguientes datos requeridos:
      | campo           | valor                                           |
      | User ID         | generado en tiempo de ejecución (10 caracteres) |
      | New password    | Secur3P@ss+                                     |
      | Repeat password | Secur3P@ss+                                     |
      | First name      | Laura                                           |
      | Last name       | Gomez                                           |
      | Email           | generado en tiempo de ejecución (único)         |
      | Phone           | 987654321                                       |
      | Address 1       | Calle 45 # 12-34                                |
      | Address 2       | Apto 302 Torre B                                |
      | City            | Lima                                            |
      | State           | Lima                                            |
      | Zip             | 15001                                           |
      | Country         | Perú                                            |
    And personaliza las opciones de perfil con los siguientes valores:
      | preferencia         | valor_seleccionado |
      | Language Preference | japanese           |
      | Favourite Category  | DOGS               |
      | Enable MyList       | marcado            |
      | Enable MyBanner     | marcado            |
    And hace clic en el botón "Save Account Information"
    Then el sistema procesa el registro exitosamente y redirige a la página principal "/catalog"
    And la URL actual del navegador contiene "/catalog"
    And la cabecera superior confirma que la sesión permanece en estado anónimo al no existir sesión iniciada

  @smoke @positive @signin
  Scenario: TC-SIGNUP-02b - Verificación de persistencia de cuenta recién registrada mediante inicio de sesión exitoso en Sign In
    Given que existe una cuenta recién registrada exitosamente en el sistema con credenciales activas
    When el usuario navega a la página de inicio de sesión "https://petstore.octoperf.com/account/signonForm"
    And ingresa las credenciales de la cuenta recién registrada en el formulario de autenticación:
      | campo    | valor                                     |
      | username | User ID de la cuenta recién registrada    |
      | password | Contraseña de la cuenta recién registrada |
    And hace clic en el botón "Login"
    Then el sistema autentica al usuario exitosamente y lo redirige al catálogo
    And la cabecera superior muestra el enlace "Sign Out" confirmando que la sesión está activa y la cuenta persistió en el backend
    And la cabecera superior muestra el enlace a "My Account"

  # ---------------------------------------------------------------------------
  # FLUJOS NEGATIVOS: UNICIDAD Y REGLAS DE NEGOCIO
  # ---------------------------------------------------------------------------

  @regression @negative
  Scenario: TC-SIGNUP-03 - Rechazo de registro por User ID duplicado de forma insensible a mayúsculas
    Given que existe una cuenta registrada previamente con User ID de referencia en mayúsculas
    When el usuario completa el formulario de registro utilizando el mismo User ID en minúsculas:
      | campo           | valor                                   |
      | User ID         | User ID de referencia en minúsculas     |
      | New password    | Passw0rd!+                              |
      | Repeat password | Passw0rd!+                              |
      | First name      | Roberto                                 |
      | Last name       | Duplicado                               |
      | Email           | generado en tiempo de ejecución (único) |
      | Phone           | +123456789                              |
      | Address 1       | Carrera 7 # 100-20                      |
      | Address 2       | [VACIO]                                 |
      | City            | Cali                                    |
      | State           | Valle                                   |
      | Zip             | 760001                                  |
      | Country         | Colombia                                |
    And hace clic en el botón "Save Account Information"
    Then el sistema rechaza la solicitud de registro y permanece en el formulario de cuenta
    And la página muestra un mensaje de error indicando que el User ID ya se encuentra en uso
    And el formulario conserva todos los datos ingresados en los campos de texto
    And los campos de contraseña y confirmación de contraseña se encuentran vacíos por seguridad

  @regression @negative
  Scenario: TC-SIGNUP-04 - Rechazo de registro por correo electrónico duplicado
    Given que existe una cuenta registrada previamente con correo electrónico de referencia
    When el usuario completa el formulario de registro utilizando el mismo correo electrónico de referencia:
      | campo           | valor                                           |
      | User ID         | generado en tiempo de ejecución (10 caracteres) |
      | New password    | Passw0rd!+                                      |
      | Repeat password | Passw0rd!+                                      |
      | First name      | Andrea                                          |
      | Last name       | EmailDup                                        |
      | Email           | correo electrónico de la cuenta de referencia   |
      | Phone           | +123456789                                      |
      | Address 1       | Av. Santander 45                                |
      | Address 2       | [VACIO]                                         |
      | City            | Manizales                                       |
      | State           | Caldas                                          |
      | Zip             | 170001                                          |
      | Country         | Colombia                                        |
    And hace clic en el botón "Save Account Information"
    Then el sistema rechaza la solicitud de registro y no crea la cuenta
    And la página muestra un mensaje de error informando que el correo electrónico ya se encuentra registrado
    And el formulario conserva todos los datos de texto ingresados
    And los campos de contraseña y confirmación de contraseña se vacían automáticamente

  @regression @negative
  Scenario: TC-SIGNUP-05 - Rechazo de registro por discrepancia entre contraseña y confirmación
    When completa el formulario con contraseñas que no coinciden:
      | campo           | valor                                           |
      | User ID         | generado en tiempo de ejecución (10 caracteres) |
      | New password    | Passw0rd!+                                      |
      | Repeat password | Passw0rdDifferent!+                             |
      | First name      | Mario                                           |
      | Last name       | Discordante                                     |
      | Email           | generado en tiempo de ejecución (único)         |
      | Phone           | +123456789                                      |
      | Address 1       | Calle 80 # 50-10                                |
      | Address 2       | [VACIO]                                         |
      | City            | Medellín                                        |
      | State           | Antioquia                                       |
      | Zip             | 050001                                          |
      | Country         | Colombia                                        |
    And hace clic en el botón "Save Account Information"
    Then el sistema no procesa el registro y permanece en el formulario
    And muestra un mensaje de validación indicando que las contraseñas no coinciden
    And ambos campos de contraseña se encuentran vacíos en el formulario

  # ---------------------------------------------------------------------------
  # CASOS BORDE Y ANÁLISIS DE VALORES LÍMITE (BVA)
  # ---------------------------------------------------------------------------

  @regression @boundary @negative
  Scenario Outline: TC-SIGNUP-06 - Validación de política de complejidad y longitud en el campo contraseña — casos inválidos
    When ingresa en el campo User ID un valor único generado en tiempo de ejecución
    And ingresa en el campo New password el valor no permitido "<password_invalida>"
    And ingresa en el campo Repeat password la confirmación "<password_invalida>"
    And completa los datos personales con nombre "Pedro", apellido "Borde", email único y teléfono "+123456789"
    And completa la dirección con "Calle 10", ciudad "Quito", estado "Pichincha", zip "170150" y país "Ecuador"
    And hace clic en el botón "Save Account Information"
    Then el sistema rechaza la solicitud y permanece en la página del formulario
    And muestra un mensaje de error que indica el incumplimiento de la política de contraseña "<regla_incumplida>"
    Examples:
      | password_invalida            | longitud | regla_incumplida                                             |
      | Pw1!a                        | 5        | Longitud inferior al mínimo permitido (menor a 8 caracteres) |
      | Passw0rd!                    | 7        | Límite inferior estricto no alcanzado (7 caracteres)         |
      | Passw0rdSuperLarg2026!+Extra | 21       | Longitud superior al límite máximo (21 caracteres)           |
      | password123!+                | 13       | Ausencia de al menos una letra mayúscula                     |
      | PASSWORD123!+                | 13       | Ausencia de al menos una letra minúscula                     |
      | PasswordExtra!+              | 15       | Ausencia de al menos un dígito numérico                      |
      | Passw0rd12345                | 13       | Ausencia de al menos un carácter especial del catálogo       |

  @regression @boundary @positive
  Scenario Outline: TC-SIGNUP-06b - Verificación de contraseñas válidas en los valores límite de longitud (8 y 20 caracteres)
    When ingresa en el campo User ID un valor único generado en tiempo de ejecución
    And ingresa en el campo New password la contraseña válida "<password_valida>"
    And ingresa en el campo Repeat password la confirmación idéntica "<password_valida>"
    And completa los datos personales con nombre "Ana", apellido "Frontera", email único y teléfono "+123456789"
    And completa la dirección con "Av. Frontera 100", ciudad "Arequipa", estado "Arequipa", zip "04001" y país "Perú"
    And hace clic en el botón "Save Account Information"
    Then el sistema procesa el registro exitosamente y redirige a la página principal "/catalog"
    And la URL actual del navegador contiene "/catalog"
    Examples:
      | password_valida      | longitud | tipo_frontera                                 |
      | Pw0rd!+a             | 8        | Frontera mínima válida exacta (8 caracteres)  |
      | Pw0rd!+abcdefghijk12 | 20       | Frontera máxima válida exacta (20 caracteres) |

  @regression @negative
  Scenario Outline: TC-SIGNUP-07 - Rechazo de registro granular por omisión individual de cada campo obligatorio
    When completa el formulario de registro pero omite deliberadamente el campo obligatorio "<campo_omitido>"
    And hace clic en el botón "Save Account Information"
    Then el sistema impide la creación de la cuenta y permanece en el formulario
    And muestra un mensaje de validación indicando que el campo es obligatorio
    Examples:
      | campo_omitido    |
      | username         |
      | password         |
      | repeatedPassword |
      | firstName        |
      | lastName         |
      | email            |
      | phone            |
      | address1         |
      | city             |
      | state            |
      | zip              |
      | country          |

  @regression @boundary @negative
  Scenario Outline: TC-SIGNUP-08 - Validación de valores límite y formatos en el campo Teléfono
    When ingresa en el formulario un User ID válido y contraseñas coincidentes
    And ingresa en el campo Phone el valor telefónico no permitido "<telefono_invalido>"
    And completa el resto de campos obligatorios con valores válidos
    And hace clic en el botón "Save Account Information"
    Then el sistema rechaza el valor del teléfono y permanece en el formulario
    And muestra un mensaje de error indicando que el formato de teléfono es inválido
    Examples:
      | telefono_invalido | descripcion_fallo                                                          |
      | 12345678          | Longitud de 8 dígitos numéricos (inferior al límite de 9)                  |
      | 1234567890        | Longitud de 10 dígitos numéricos sin prefijo (superior al límite)          |
      | +12345678         | Prefijo + con 8 dígitos numéricos (total 9 caracteres pero solo 8 dígitos) |
      | +1234567890       | Prefijo + con 10 dígitos numéricos (superior al límite)                    |
      | 123-456-789       | Contiene guiones intermedios no permitidos                                 |
      | 123 456 789       | Contiene espacios intermedios no permitidos                                |
      | 12345ABCD         | Contiene letras alfabéticas no permitidas                                  |

  @regression @boundary @negative
  Scenario Outline: TC-SIGNUP-09 - Validación de valores límite de longitud en User ID (exactamente diez caracteres)
    When ingresa en el campo User ID el valor inválido por longitud o formato "<userid_invalido>"
    And completa contraseñas válidas, datos personales y de dirección obligatorios
    And hace clic en el botón "Save Account Information"
    Then el sistema no procesa el alta de la cuenta y permanece en el formulario
    And muestra un mensaje de error indicando que el User ID debe tener exactamente 10 caracteres alfanuméricos
    Examples:
      | userid_invalido | longitud | motivo_invalidez                                               |
      | USERID009       | 9        | Longitud de 9 caracteres (frontera inferior a exactamente 10)  |
      | USERID00011     | 11       | Longitud de 11 caracteres (frontera superior a exactamente 10) |
      | USER_12345      | 10       | Contiene guion bajo (carácter especial no permitido)           |
      | USER 12345      | 10       | Contiene espacio intermedio no permitido                       |

  @regression @boundary @negative
  Scenario Outline: TC-SIGNUP-10 - Validación de valores límite de longitud en Código Postal / Zip
    When ingresa en el formulario datos obligatorios válidos
    And ingresa en el campo Zip el valor con longitud fuera de rango "<zip_invalido>"
    And hace clic en el botón "Save Account Information"
    Then el sistema no acepta el código postal y permanece en el formulario
    And muestra un mensaje de validación indicando longitud inválida de código postal

    Examples:
      | zip_invalido | longitud | motivo_invalidez                                      |
      | 12           | 2        | Longitud de 2 caracteres (menor al límite mínimo 3)   |
      | 12345678901  | 11       | Longitud de 11 caracteres (mayor al límite máximo 10) |

  # ---------------------------------------------------------------------------
  # EXPERIENCIA DE USUARIO (UX), PRESERVACIÓN DE ESTADO Y SEGURIDAD
  # ---------------------------------------------------------------------------

  @regression @ux
  Scenario: TC-SIGNUP-11 - Preservación granular de datos válidos en tabla y vaciado de contraseñas tras error de validación
    When completa el formulario con datos de contacto válidos pero introduce contraseñas discrepantes:
      | campo           | valor                                           |
      | User ID         | generado en tiempo de ejecución (10 caracteres) |
      | New password    | Passw0rd!+                                      |
      | Repeat password | Passw0rdNoMatch!+                               |
      | First name      | Fernando                                        |
      | Last name       | Preserva                                        |
      | Email           | generado en tiempo de ejecución (único)         |
      | Phone           | +123456789                                      |
      | Address 1       | Av. Las Flores 789                              |
      | Address 2       | Oficina 401                                     |
      | City            | Cuenca                                          |
      | State           | Azuay                                           |
      | Zip             | 010101                                          |
      | Country         | Ecuador                                         |
    And hace clic en el botón "Save Account Information"
    Then el sistema rechaza la solicitud mostrando el error correspondiente
    And los campos de texto del formulario retienen íntegramente los valores ingresados:
      | campo      | valor_retenido     |
      | First name | Fernando           |
      | Last name  | Preserva           |
      | Phone      | +123456789         |
      | Address 1  | Av. Las Flores 789 |
      | Address 2  | Oficina 401        |
      | City       | Cuenca             |
      | State      | Azuay              |
      | Zip        | 010101             |
      | Country    | Ecuador            |
    And el campo New password se encuentra completamente vacío
    And el campo Repeat password se encuentra completamente vacío

  @smoke @security
  Scenario: TC-SIGNUP-12 - Verificación de ausencia de sesión automática post-registro en la cabecera de la página de inicio
    When completa y envía el formulario de registro con datos válidos completos
    Then el sistema redirige al usuario a la URL "https://petstore.octoperf.com/actions/Catalog.action"
    And la cabecera superior de la página muestra el enlace "Sign In"
    And la cabecera superior no muestra el enlace "Sign Out"
    And la cabecera superior no muestra el enlace "My Account"
    And la cabecera superior no muestra ningún mensaje de bienvenida personalizado