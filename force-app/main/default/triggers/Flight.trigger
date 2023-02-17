trigger Flight on Flight__c (after insert) {
    TriggerHandlerManager.instance().execute(Flight__c.sObjectType);
}