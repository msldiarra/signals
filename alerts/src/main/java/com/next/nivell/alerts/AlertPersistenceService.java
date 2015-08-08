package com.next.nivell.alerts;
/*
import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Props;*/

import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Props;
import akka.actor.dsl.Creators;
import com.next.nivell.alerts.actors.Saver;
import com.next.nivell.alerts.actors.Store;
import com.next.nivell.alerts.model.Alert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class AlertPersistenceService {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private ActorSystem system;
    private ActorRef saver;

    public AlertPersistenceService() {
        system = ActorSystem.create("Store");
        system.actorOf(Props.create(Store.class), "store");
        saver = system.actorOf(Props.create(Saver.class), "saver");
    }

    public void save(Alert alert) {

        saver.tell(alert, ActorRef.noSender());
        LOGGER.info("Alert saved : " + alert);
    }
    /*public void performAsyncComputation(DeferredResult<List<String>> result) {

        LOGGER.debug("Creating new Actor System...");

        ActorSystem system = ActorSystem.create("asyncTest");

        LOGGER.debug("Creating StringCollector to process request...");

        system.actorOf(Props.create(StringCollector.class), "stringCollector").tell(result, ActorRef.noSender());


    }*/

}