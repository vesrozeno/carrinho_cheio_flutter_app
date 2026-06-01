enum UiEventType {
  success,
  error,
  warning,
  info,
}

class UiEvent {
  final UiEventType type;
  final String message;

  const UiEvent({
    required this.type,
    required this.message,
  });
}
