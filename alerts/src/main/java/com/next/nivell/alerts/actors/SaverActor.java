package com.next.nivell.alerts.actors;

import akka.actor.UntypedActor;
import com.next.nivell.alerts.model.Alert;
import com.next.nivell.alerts.model.AlertPersistenceUnit;

import javax.ejb.Stateless;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.logging.Logger;

@Stateless
public class SaverActor extends UntypedActor {

    private EntityManager entityManager;

    private final Logger LOGGER = Logger.getLogger(SaverActor.class.getName());

    public static enum Msg {
        SAVED;
    }

    public SaverActor() {
    }

    public SaverActor(EntityManager entityManager) {
        LOGGER.info("new actor");
        this.entityManager = entityManager;
    }

    @Override
    public void onReceive(Object message) {

        if (message instanceof Alert) {

            save((Alert) message);
            getSender().tell(Msg.SAVED, getSelf());
        } else {
            unhandled(message);
        }
    }


    private void save(Alert alert) {
        LOGGER.info("Saving alert...");
        entityManager.persist(alert);
    }
}