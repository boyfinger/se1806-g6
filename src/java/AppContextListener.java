import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize resources
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup resources
        AbandonedConnectionCleanupThread.checkedShutdown();
    }
}
