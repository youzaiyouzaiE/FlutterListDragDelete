import 'package:event_bus/event_bus.dart';


class EventBusInstance {

  static final EventBusInstance _gInstance = EventBusInstance._init();

  static EventBus _eventBus = EventBus();

  EventBusInstance._init() {
    ///
  }

  factory EventBusInstance() {
    return _gInstance;
  }

  ///
  EventBus get bus {
    return _eventBus; 
  }

}