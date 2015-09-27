package com.next.nivell.alerts;

import com.mysema.query.jpa.impl.JPAQuery;

import com.next.nivell.alerts.model.user.QUser;
import com.next.nivell.alerts.model.user.User;
import com.next.nivell.alerts.model.user.UserPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.annotation.security.PermitAll;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.validation.constraints.NotNull;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;


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
    public Response create() {
        return Response.ok(true).header("Access-Control-Allow-Origin", "http://0.0.0.0:3000/")
                .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
                .header("Access-Control-Allow-Credentials", "true")
                .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
                .header("Access-Control-Max-Age", "1209600").build();
    }

    @GET
    @Path("/")
    @Consumes("*/*")
    @Produces(MediaType.APPLICATION_JSON)
    @PermitAll
    public Response getUser(@QueryParam("login") @NotNull String login) {

        User user = new JPAQuery(entityManager)
                .from(QUser.user)
                .where(QUser.user.login.eq(login))
                .singleResult(QUser.user);

      return Response.ok(user).header("Access-Control-Allow-Origin", "http://0.0.0.0:3000")
                .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization, X-Requested-With")
                .header("Access-Control-Allow-Credentials", "true")
                .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
                .header("Access-Control-Max-Age", "1209600").build();
    }

    @OPTIONS
    @Path("/")
    @Consumes("*/*")
    @Produces(MediaType.APPLICATION_JSON)
    @PermitAll
    public Response user(@QueryParam("login") @NotNull String login) {

        User user = new JPAQuery(entityManager)
                .from(QUser.user)
                .where(QUser.user.login.eq(login))
                .singleResult(QUser.user);

        return Response.ok(user).header("Access-Control-Allow-Origin", "http://0.0.0.0:3000")
                .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization, X-Requested-With")
                .header("Access-Control-Allow-Credentials", "true")
                .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
                .header("Access-Control-Max-Age", "1209600").build();
    }
}