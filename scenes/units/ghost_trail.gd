extends TextureRect

class_name GhostTrail

@export var ghost_interval: float = 0.05 # How often to spawn a shadow
@export var ghost_lifetime: float = 0.4 # How long it takes to fade out completely

const MOVE_IN_DURATION: float = 1.0
const MOVE_OUT_DURATION: float = 1.0
const MOVE_BACK_DURATION: float = 0.8
const MOVE_BACK_OFFSET: float = -200.0
const DISPLAY_DURATION: float = 0.05

var _timer: float = 0.0


func _process(delta: float) -> void:
    if not visible:
        return
    _timer += delta
    if _timer >= ghost_interval:
        spawn_ghost()
        _timer = 0.0


func spawn_ghost() -> void:
    print("Spawning ghost at position: ", position)
    var ghost: TextureRect = TextureRect.new()
    ghost.expand_mode = self.expand_mode
    ghost.stretch_mode = self.stretch_mode
    ghost.custom_minimum_size = self.custom_minimum_size
    ghost.texture = self.texture
    ghost.position = self.position
    ghost.z_index = z_index - 1
    ghost.top_level = true # Make sure the ghost is not affected by the parent node's transformations
    ghost.modulate = Color(1, 1, 1, 0.5)
    add_child(ghost)

    var tween = create_tween()
    tween.tween_property(ghost, "modulate:a", 0.0, ghost_lifetime) \
            .set_trans(Tween.TRANS_SINE) \
            .set_ease(Tween.EASE_OUT)
    tween.tween_callback(ghost.queue_free)
    return


func hide_tex() -> void:
    position.x = -size.x
    visible = false
    return


func play_movement() -> void:
    visible = true

    var tween = create_tween()
    var center_x = get_viewport_rect().size.x / 2.0 - size.x / 2.0
    var right_x = get_viewport_rect().size.x
    print("position.x: ", position.x, " center_x: ", center_x, " right_x: ", right_x)
    tween.tween_property(self, "position:x", center_x, MOVE_IN_DURATION) \
            .set_trans(Tween.TRANS_CUBIC) \
            .set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "position:x", center_x + MOVE_BACK_OFFSET, MOVE_BACK_DURATION) \
            .set_trans(Tween.TRANS_CUBIC) \
            .set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "position:x", right_x, MOVE_OUT_DURATION) \
            .set_trans(Tween.TRANS_CUBIC) \
            .set_ease(Tween.EASE_IN)
    tween.tween_callback(self.hide_tex)
    return
