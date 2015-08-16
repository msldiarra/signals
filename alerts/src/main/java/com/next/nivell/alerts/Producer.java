package com.next.nivell.alerts;


import akka.actor.*;
import akka.japi.Creator;
import com.next.nivell.alerts.actors.Saver;
import com.next.nivell.alerts.actors.SaverActor;
import com.next.nivell.alerts.actors.Store;
import com.next.nivell.alerts.actors.StoreActor;
import com.next.nivell.alerts.model.AlertPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import scala.sys.Prop;

import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class Producer {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @PersistenceContext(unitName = AlertPersistenceUnit.NAME)
    EntityManager entityManager;

    private ActorSystem system = ActorSystem.create("Store");

    @Produces @Saver
    public ActorRef producesSaverActor(){

        LOGGER.info("producing actor");
        LOGGER.info(String.valueOf(entityManager));

        system.actorOf(Props.create(StoreActor.class), "store");

        return system.actorOf(Props.create(SaverActor.class, entityManager), "saver");
    }


}
