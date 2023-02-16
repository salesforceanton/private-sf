public class TriggerContext {
    private Set<SObjectType> disabledTriggers = new Set<SObjectType>();

    public Boolean isTriggerEnabled(SObjectType key) {
        return !this.disabledTriggers.contains(key);
    }

    public void disableTrigger(SObjectType key) {
        if (!this.disabledTriggers.contains(key)) {
            this.disabledTriggers.add(key);
            return;
        }
    }

    public void enableTrigger(SObjectType key) {
        if (this.disabledTriggers.contains(key)) {
            this.disabledTriggers.remove(key);
            return;
        }
    }
}
