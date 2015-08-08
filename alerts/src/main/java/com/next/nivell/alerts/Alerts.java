package com.next.nivell.alerts;


import com.next.nivell.alerts.model.Alert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.math.BigDecimal;
import java.util.Date;

@Path("/alerts")
@Consumes({ "application/json" })
@Produces({ "application/json" })
@Stateless
public class Alerts {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    @Inject
    private AlertPersistenceService service;

    public Alerts() {
    }

    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    public String count() {
        return "OK";
    }

    @POST
    @Path("/add")
    public Response add() {

        LOGGER.info("saving  alerts");
        Alert alert = new Alert(java.util.UUID.randomUUID(), "tankReference", new BigDecimal(12), new Date());
        service.save(alert);
        return Response.ok(alert.toString()).build();
    }

}
