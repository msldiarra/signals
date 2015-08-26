package com.next.nivell.alerts;

import com.next.nivell.alerts.model.user.UserPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.annotation.security.PermitAll;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

@Path("/users")
@Stateless
public class Users {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @PersistenceContext(unitName = UserPersistenceUnit.NAME)
    private EntityManager entityManager;

    @Resource
    private SessionContext sessionContext;

    public Users() {
    }

    @HEAD
    @Path("/")
    @Consumes("*/*")
    @Produces(MediaType.APPLICATION_JSON)
    @PermitAll
    public Boolean create() {
        return true;
    }

}