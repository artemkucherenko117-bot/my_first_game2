extends Area2D # Область використовується як зона наближення до дверей.
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D # Отримуємо візуальну анімацію дверей.
@onready var obstacle: StaticBody2D = $Obstacle # Отримуємо фізичну перешкоду дверей.
@onready var obstacle_collision: CollisionShape2D = $Obstacle/CollisionShape2D # Отримуємо колізію стіни.
var is_opened := false # Не дозволяємо відкривати двері повторно.
func _ready() -> void: # Виконуємо початкові налаштування дверей.
    body_entered.connect(_on_body_entered) # Підключаємо сигнал входження гравця.
    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("closed"): # Перевіряємо закритий стан.
        animated_sprite.play("closed") # Показуємо закриті двері.
func _on_body_entered(body: Node2D) -> void: # Обробляємо наближення фізичного тіла.
    if not body is Player or is_opened: # Реагуємо лише на Player і лише один раз.
        return # Завершуємо обробник без змін.
    is_opened = true # Фіксуємо відкритий стан дверей.
    obstacle_collision.set_deferred("disabled", true) # Вимикаємо колізію стіни безпечно.
    obstacle.set_deferred("collision_layer", 0) # Прибираємо перешкоду з фізичного шару.
    obstacle.set_deferred("collision_mask", 0) # Прибираємо маску перешкоди.
    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("open"): # Перевіряємо анімацію відкриття.
        animated_sprite.play("open") # Показуємо відкриття дверей.
    print("Дверь открыта, путь свободен") # Виводимо лог у консоль.
