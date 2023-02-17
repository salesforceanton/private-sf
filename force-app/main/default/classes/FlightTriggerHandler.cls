public inherited sharing class FlightTriggerHandler extends TriggerHandlerManager.Handler {
    public override void afterInsert(TriggerContext triggerContext, Map<Id, SObject> newMap) {
        TicketService.generateTicketsForNewFlights((List<Flight__c>)newMap.values());
    }
}