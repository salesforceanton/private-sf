public class TriggerHandlerManager {
    private Map<SObjectType, Type> handlerByClassNameMap = new Map<SObjectType, Type>{
    };

    private TriggerHandlerManager() {
    }

    private static TriggerHandlerManager classInstance;
    private static TriggerContext triggerContext = new TriggerContext();

    public static TriggerHandlerManager instance() {
        if (classInstance == null) {
            classInstance = new TriggerHandlerManager();
        }
        return classInstance;
    }

    public static TriggerContext getContext() {
        return triggerContext;
    }

    public void execute(SObjectType objectType) {
        if (!triggerContext.isTriggerEnabled(objectType)) {
            return;
        }

        Type handlerType = handlerByClassNameMap.get(objectType);
        if (handlerType == null) {
            return;
        }

        Handler handler = (Handler) handlerType.newInstance();

        switch on Trigger.OperationType {
            when BEFORE_INSERT {
                handler.beforeInsert(triggerContext, Trigger.new);
            }
            when BEFORE_UPDATE {
                handler.beforeUpdate(triggerContext, Trigger.newMap, Trigger.oldMap);
            }
            when AFTER_INSERT {
                handler.afterInsert(triggerContext, Trigger.newMap);
            }
            when AFTER_UPDATE {
                handler.afterUpdate(triggerContext, Trigger.newMap, Trigger.oldMap);
            }
            when BEFORE_DELETE {
                handler.beforeDelete(triggerContext, Trigger.oldMap);
            }
            when AFTER_DELETE {
                handler.afterDelete(triggerContext, Trigger.oldMap);
            }
            when AFTER_UNDELETE {
                handler.afterUndelete(triggerContext, Trigger.oldMap);
            }
        }
    }

    public abstract class Handler {
        public virtual void beforeInsert(TriggerContext context, SObject[] newList) {
        }

        public virtual void beforeUpdate(TriggerContext context, Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        }

        public virtual void beforeDelete(TriggerContext context, Map<Id, SObject> oldMap) {
        }

        public virtual void afterInsert(TriggerContext context, Map<Id, SObject> newMap) {
        }

        public virtual void afterUpdate(TriggerContext context, Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        }

        public virtual void afterDelete(TriggerContext context, Map<Id, SObject> oldMap) {
        }

        public virtual void afterUndelete(TriggerContext context, Map<Id, SObject> oldMap) {
        }
    }
}
