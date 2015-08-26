package com.next.nivell.alerts.persistence;


import com.next.nivell.alerts.model.alert.Alert;
import com.next.nivell.alerts.model.AlertPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.ActivationConfigProperty;
import javax.ejb.MessageDriven;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@MessageDriven(activationConfig = {
        @ActivationConfigProperty(propertyName = "destinationLookup",
                propertyValue = "java:global/jms/ClassicQueue"),
        @ActivationConfigProperty(propertyName = "destinationType",
                propertyValue = "javax.jms.Queue"),
})
public class AlertsSaver implements MessageListener {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @PersistenceContext(unitName = AlertPersistenceUnit.NAME)
    EntityManager entityManager;

    @Override
    public void onMessage(Message message) {

        try {

            Alert alert = message.getBody(Alert.class);
            LOGGER.info("Read alert from queue : {} : ", alert);

            entityManager.persist(alert);
            LOGGER.info("Alert persisted");

        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
}
