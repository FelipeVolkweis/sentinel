extends Node3D

# DebugVisualizer: Plota esferas de debug em posições específicas
# Uso:
# 	var viz = DebugVisualizer.new()
# 	add_child(viz)
# 	viz.plot_sphere(Vector3(1,2,3), 0.1, Color(1,0,0), 5.0)

func plot_sphere(position: Vector3, radius: float=0.1, color: Color=Color(1,0,0), duration: float=0.1) -> void:
	# Cria um MeshInstance3D com SphereMesh
	var mesh_instance := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = radius
	sphere.height = radius * 2
	sphere.radial_segments = 16
	sphere.rings = 8
	mesh_instance.mesh = sphere

	# Material simples
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.flags_unshaded = true
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mesh_instance.material_override = mat

	# Define posição global e adiciona à cena principal (não segue o DebugVisualizer)
	var root := get_tree().current_scene
	root.add_child(mesh_instance)
	mesh_instance.global_transform.origin = position

	# Se duration > 0, agenda remoção > 0, agenda remoção
	if duration > 0.0:
		var timer := Timer.new()
		timer.wait_time = duration
		timer.one_shot = true
		# Conecta usando Callable.bind para passar parâmetros corretamente
		var cb := Callable(self, "_on_timer_timeout").bind(mesh_instance, timer)
		timer.timeout.connect(cb)
		add_child(timer)
		timer.start()

func _on_timer_timeout(mesh_instance: MeshInstance3D, timer: Timer) -> void:
	if mesh_instance and mesh_instance.is_inside_tree():
		mesh_instance.queue_free()
	timer.queue_free()
