package page;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import java.util.HashMap;
import java.util.Map;

public class RegisterNowPage extends BasePage {

    // Diccionario que vincula el texto en la tabla de Gherkin con el selector HTML real
    private final Map<String, By> formLocators = new HashMap<>() {{
        put("User ID", By.name("username"));
        put("New password", By.name("password"));
        put("Repeat password", By.name("repeatedPassword"));
        put("First name", By.name("firstName"));
        put("Last name", By.name("lastName"));
        put("Email", By.name("email"));
        put("Phone", By.name("phone"));
        put("Address 1", By.name("address1"));
        put("Address 2", By.name("address2"));
        put("City", By.name("city"));
        put("State", By.name("state"));
        put("Zip", By.name("zip"));
        put("Country", By.name("country"));
    }};

    private final By clickBoton = By.xpath("//*[@id=\"Catalog\"]/form/input");

    public RegisterNowPage(WebDriver driver) {

        super(driver);
    }

    public void accessURL(String url) {

        navigateTo(url);
    }

    public void llenarFormulario(Map<String, String> datosFormulario) {
        fillFormFields(datosFormulario, formLocators);
    }

    public void darClicK(String boton) {

        click(clickBoton);
    }
}