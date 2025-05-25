package listeners;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.SessionTrackingMode;

import java.util.Collections;

@WebListener
public class SessionTrackingDisabler implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Chỉ cho phép session bằng cookie
        sce.getServletContext().setSessionTrackingModes(
            Collections.singleton(SessionTrackingMode.COOKIE)
        );
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // nothing
    }
}
