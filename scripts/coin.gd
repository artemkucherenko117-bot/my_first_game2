extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var collected := false



func _ready() -> void:

    body_entered.connect(_on_body_entered)

    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("spin"):

        animated_sprite.play("spin")



func _on_body_entered(body: Node2D) -> void:

    if not body is Player or collected:

        return

    collected = true

    collision_shape.set_deferred("disabled", true)

    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("collect"):

        animated_sprite.play("collect")

        await animated_sprite.animation_finished

    queue_free()

