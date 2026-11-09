package steps;

import driver.DriverManager;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import page.HomePage;
import page.RegisterNowPage;

import java.util.Map;

public class CreateUserStep {

    HomePage homePage = new HomePage(DriverManager.getDriver()); // Objeto HomePage
    RegisterNowPage registerNowPage = new RegisterNowPage(DriverManager.getDriver()); // Objeto RegisterNowPage

    @Given("que el usuario navega a la página de registro de PetStore {string}")
    public void queElUsuarioNavegaALaPáginaDeRegistroDePetStore(String url) {

        registerNowPage.accessURL(url);
    }

    @When("completa el formulario de registro con los siguientes datos requeridos:")
    public void completaElFormularioDeRegistroConLosSiguientesDatosRequeridos(io.cucumber.datatable.DataTable dataTable) {

        // Convierte la tabla de 2 columnas (| campo | valor |) en un Map<String, String>
        Map<String, String> datos = dataTable.asMap(String.class, String.class);

        // Manejo de valores dinámicos si aplica (ej: User ID o Email en tiempo de ejecución)

        registerNowPage.llenarFormulario(datos);
    }

    @And("verifica que las opciones de perfil se encuentran en su estado predeterminado:")
    public void verificaQueLasOpcionesDePerfilSeEncuentranEnSuEstadoPredeterminado() {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @And("hace clic en el botón {string}")
    public void haceClicEnElBotón(String boton) {
        registerNowPage.darClicK(boton);
    }

    @Then("el sistema procesa el registro exitosamente y redirige a la página principal {string}")
    public void elSistemaProcesaElRegistroExitosamenteYRedirigeALaPáginaPrincipal(String arg0) {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @And("la URL actual del navegador contiene {string}")
    public void laURLActualDelNavegadorContiene(String arg0) {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @And("la cabecera superior confirma que la sesión no fue iniciada automáticamente al no mostrar el enlace {string} ni el saludo de bienvenida")
    public void laCabeceraSuperiorConfirmaQueLaSesiónNoFueIniciadaAutomáticamenteAlNoMostrarElEnlaceNiElSaludoDeBienvenida(String arg0) {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @And("personaliza las opciones de perfil con los siguientes valores:")
    public void personalizaLasOpcionesDePerfilConLosSiguientesValores() {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @And("la cabecera superior confirma que la sesión permanece en estado anónimo al no existir sesión iniciada")
    public void laCabeceraSuperiorConfirmaQueLaSesiónPermaneceEnEstadoAnónimoAlNoExistirSesiónIniciada() {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Given("que existe una cuenta recién registrada exitosamente en el sistema con credenciales activas")
    public void queExisteUnaCuentaReciénRegistradaExitosamenteEnElSistemaConCredencialesActivas() {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @When("el usuario navega a la página de inicio de sesión {string}")
    public void elUsuarioNavegaALaPáginaDeInicioDeSesión(String arg0) {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @And("ingresa las credenciales de la cuenta recién registrada en el formulario de autenticación:")
    public void ingresaLasCredencialesDeLaCuentaReciénRegistradaEnElFormularioDeAutenticación() {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }
}
