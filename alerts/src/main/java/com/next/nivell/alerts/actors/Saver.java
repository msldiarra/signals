package com.next.nivell.alerts.actors;

import akka.actor.UntypedActor;
import com.next.nivell.alerts.model.Alert;

import java.util.logging.Logger;

public class Saver extends UntypedActor {

    private final Logger LOGGER = Logger.getLogger(Saver.class.getName());

    public static enum Msg {
        SAVED;
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
        LOGGER.info("Alert saved");
    }
}