package com.next.nivell.alerts;


import akka.actor.ActorRef;
import com.next.nivell.alerts.actors.Saver;
import com.next.nivell.alerts.model.Alert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.inject.Inject;

@Stateless
public class AlertPersistenceService {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @Inject @Saver
    private ActorRef saverActor;

    public AlertPersistenceService() { }

    public void save(Alert alert) {
        saverActor.tell(alert, ActorRef.noSender());
    }

}