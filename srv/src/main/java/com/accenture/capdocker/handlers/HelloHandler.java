package com.accenture.capdocker.handlers;

import org.springframework.stereotype.Component;

import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.helloservice.HelloContext;
import cds.gen.helloservice.HelloService_;

@ServiceName(HelloService_.CDS_NAME)
@Component
public class HelloHandler implements EventHandler {

    @Before(entity = "*", event = CqnService.EVENT_READ)
    public void printMyUserName(CdsReadEventContext context) {
    }

    @On(event = HelloContext.CDS_NAME)
    public void onHello(HelloContext helloContext) {
        helloContext.setResult("Hello World");
    }

}
