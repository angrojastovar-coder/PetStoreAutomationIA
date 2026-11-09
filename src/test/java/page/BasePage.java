package page;

import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.Map;

public class BasePage {

    protected WebDriver driver;
    protected WebDriverWait wait;

    public BasePage(WebDriver driver) {
        this.driver = driver;
        this.wait = new WebDriverWait(driver, Duration.ofSeconds(15));
    }

    public void navigateTo(String url) {

        driver.get(url);
    }

    public WebElement find(By locator) {

        return wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
    }

    public void click(By locator) {

        find(locator).click();
    }

    /**
     * Escritura Robusta: Asegura visibilidad, scroll, limpieza total y escritura.
     * Si el clear() estándar no limpia, aplica combinación de teclas CTRL+A + DELETE.
     */
    public void typeSmart(By locator, String text) {
        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(locator));

        // 1. Scroll suave al elemento para garantizar que esté a la vista
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView({block: 'center'});", element);

        // 2. Clic para enfocar el elemento
        element.click();

        // 3. Limpieza profunda (evita concatenaciones indeseadas)
        element.clear();
        if (!element.getAttribute("value").isEmpty()) {
            element.sendKeys(Keys.chord(Keys.CONTROL, "a"), Keys.BACK_SPACE);
        }
        // 4. Escritura
        if (text != null && !text.isEmpty() && !text.equalsIgnoreCase("[VACIO]")) {
            element.sendKeys(text);
        }
    }

    /**
     * MÉTODO CLAVE: Llena un formulario completo a partir de un Map (clave -> valor de Cucumber)
     * usando un diccionario de localizadores propios de la página.
     *
     * @param formValues Mapa con pares {Nombre Campo en Gherkin -> Valor a ingresar}
     * @param fieldLocators Mapa con {Nombre Campo en Gherkin -> By locator HTML}
     */
    public void fillFormFields(Map<String, String> formValues, Map<String, By> fieldLocators) {
        formValues.forEach((fieldName, value) -> {
            // Ignora la fila de encabezado si viene presente en la tabla
            if ("campo".equalsIgnoreCase(fieldName.trim())) {
                return;
            }
            By locator = fieldLocators.get(fieldName.trim());
            if (locator != null) {
                typeSmart(locator, value);
            } else {
                throw new IllegalArgumentException("No se encontró el localizador para el campo: '" + fieldName + "'");
            }
        });
    }

    public String getText(By locator) {
        return find(locator).getText();
    }

    public boolean isDisplayed(By locator) {
        try {
            return find(locator).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
}
