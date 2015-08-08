package com.next.nivell.alerts.actors;

import akka.actor.ActorRef;
import akka.actor.Props;
import akka.actor.UntypedActor;
import com.next.nivell.alerts.model.Alert;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Logger;

public class Store extends UntypedActor {

    private final Logger LOGGER = Logger.getLogger(Store.class.getName());

    @Override
    public void onReceive(Object msg) {
        if (msg == Saver.Msg.SAVED) {
            // when the greeter is done, stop this actor and with it the application
            LOGGER.info("stopping actor");
            getContext().stop(getSelf());
        } else
            unhandled(msg);
    }
}