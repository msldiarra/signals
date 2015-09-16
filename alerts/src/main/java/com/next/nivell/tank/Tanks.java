package com.next.nivell.tank;


import com.mysema.query.jpa.impl.JPAQuery;
import com.next.nivell.alerts.model.tank.TankInAlert;
import static com.next.nivell.alerts.model.tank.QTankInAlert.tankInAlert;
import com.next.nivell.alerts.model.tank.TankInAlertPersistenceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.validation.constraints.NotNull;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/tanks")
@Produces({"application/json"})
@Stateless
public class Tanks {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @PersistenceContext(unitName = TankInAlertPersistenceUnit.NAME)
    private EntityManager entityManager;

    public Tanks() {
    }

    @GET
    @Consumes("*/*")
    @Path("/{customer}/alerted")
    public Response tanksInAlert(@PathParam("customer") @NotNull String customer) {

        List<TankInAlert> results = new JPAQuery(entityManager)
                .from(tankInAlert)
                .where(tankInAlert.customer.eq(customer))
                .list(tankInAlert);

        return Response.ok(results).build();
    }

}
