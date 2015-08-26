package com.next.nivell.system;

import com.next.nivell.alerts.Alerts;
import com.next.nivell.alerts.Users;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

@ApplicationPath("/rs")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> classes = new HashSet<>();
        classes.add(Alerts.class);
        classes.add(Users.class);
        return classes;
    }
}
