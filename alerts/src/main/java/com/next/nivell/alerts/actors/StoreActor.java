package com.next.nivell.alerts.actors;

import akka.actor.UntypedActor;

import java.util.logging.Logger;

public class StoreActor extends UntypedActor {

    private final Logger LOGGER = Logger.getLogger(StoreActor.class.getName());

    @Override
    public void onReceive(Object msg) {
        if (msg == SaverActor.Msg.SAVED) {
            // when the greeter is done, stop this actor and with it the application
            LOGGER.info("stopping actor");
            getContext().stop(getSelf());
        } else
            unhandled(msg);
    }
}