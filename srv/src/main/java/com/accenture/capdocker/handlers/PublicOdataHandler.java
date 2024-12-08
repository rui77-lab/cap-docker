package com.accenture.capdocker.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.publicodata.PublicOdata;
import cds.gen.publicodataservice.PublicOdataService_;

@ServiceName(PublicOdataService_.CDS_NAME)
@Component
public class PublicOdataHandler implements EventHandler {

    @Autowired
    PublicOdata publicOdataService;

    @On(entity = "*", event = CqnService.EVENT_READ)
    public void onRequest(CdsReadEventContext cdsReadEventContext) {
        cdsReadEventContext.setResult(publicOdataService.run(cdsReadEventContext.getCqn()));
    }

}
