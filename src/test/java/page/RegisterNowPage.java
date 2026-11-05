package page;

import org.openqa.selenium.WebDriver;

public class RegisterNowPage extends BasePage{

    public RegisterNowPage(WebDriver driver) {
        super(driver);
    }

    public void accessURL(String url) {
        navigateTo(url);
    }
}
