package com.next.nivell.alerts;


import com.next.nivell.alerts.model.alert.Alert;
import com.next.nivell.alerts.model.user.UserPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

@Path("/users")
@Consumes({"application/json"})
@Produces({"application/json"})
@Stateless
public class Users {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @PersistenceContext(unitName = UserPersistenceUnit.NAME)
    private EntityManager entityManager;

    @Resource
    private SessionContext sessionContext;

    public Users() {
    }

    @POST
    public Response create(Alert alert) {



        LOGGER.info("Pushing  alert in queue : {} : ", alert);

        return Response.ok(alert.toString()).build();
    }

}