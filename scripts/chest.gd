extends Area2D # Сундук виявляє гравця через область.
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D # Отримуємо вузол анімації сундука.
var is_opened := false # Зберігаємо стан, щоб відкрити сундук лише один раз.
func _ready() -> void: # Виконуємо початкове налаштування.
    body_entered.connect(_on_body_entered) # Підключаємо сигнал входження тіла.
    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("idle"): # Перевіряємо стан idle.
        animated_sprite.play("idle") # Запускаємо закритий стан сундука.
func _on_body_entered(body: Node2D) -> void: # Обробляємо входження тіла в зону сундука.
    if not body is Player or is_opened: # Пропускаємо лише Player і лише перше входження.
        return # Завершуємо обробник, якщо умова не виконана.
    is_opened = true # Фіксуємо, що сундук уже відкритий.
    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("open"): # Перевіряємо анімацію відкриття.
        animated_sprite.play("open") # Запускаємо неповторювану анімацію open.
    print("Сундук открыт! Получена награда!") # Виводимо повідомлення про нагороду.
