package com.next.nivell.system;


import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.ext.Provider;
import java.io.IOException;


@Provider
public class RESTCorsDevResponseFilter implements ContainerResponseFilter {

    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {

        requestContext.getHeaders().add( "Access-Control-Allow-Origin", "http://0.0.0.0:3000" );
        requestContext.getHeaders().add( "Access-Control-Allow-Headers", "origin, content-type, accept, authorization" );
        requestContext.getHeaders().add( "Access-Control-Allow-Credentials", "true" );
        requestContext.getHeaders().add( "Access-Control-Allow-Methods", "HEAD, GET, POST, DELETE, PUT" );

    }
}
