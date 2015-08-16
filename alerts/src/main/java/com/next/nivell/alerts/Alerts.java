package com.next.nivell.alerts;


import com.next.nivell.alerts.model.Alert;
import com.next.nivell.alerts.model.AlertPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.enterprise.inject.*;
import javax.inject.Inject;
import javax.jms.*;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.math.BigDecimal;
import java.util.Date;

@Path("/alerts")
@Consumes({"application/json"})
@Produces({"application/json"})
@Stateless
public class Alerts {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @Inject
    private JMSContext jmsContext;

    @Resource(mappedName = "java:global/jms/ClassicQueue")
    Queue demoQueue;

    public Alerts() {
    }

    @POST
    public Response create(Alert alert) {

        jmsContext.createProducer().send(demoQueue, alert);

        LOGGER.info("Pushing  alert in queue : {} : ", alert);

        return Response.ok(alert.toString()).build();
    }

}