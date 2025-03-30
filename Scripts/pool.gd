extends Node2D
class_name Pool

#inner class (com si fos una struct)
class Poolable:
	var availability : bool
	var element : Node
	func _init(_element : Node, _availability : bool) -> void:
		availability = _availability
		element = _element

var _pool : Array[Poolable] = []

#S'instancien tots els elements de la pool.
#Com no s'afegeixen a cap arbre, aquests no estan dins el MainLoop
func initialize(scene : PackedScene, size : int) -> void:
	assert(scene != null, "Pool: provided scene is null")
	assert(size > 0, "Pool: provided size is invalid")
	assert(_pool.size() == 0, "Pool: initializing a non-empty pool")
	for i : int in size:
		_pool.append(Poolable.new(scene.instantiate(), true))

#Es retorna el primer element disponible.
#L'element retornat no pertany a cap escena, és per tant responsabilitat de qui l'agafa d'afegir-lo.
#És responsabilitat de qui el demana el fet de retornar-lo.
func get_element() -> Node:
	for poolable : Poolable in _pool:
		if poolable.availability:
			poolable.availability = false
			return poolable.element
	assert(false, "Pool->get_element: no elements available")
	return null
	
#Es retorna l'element al pool.
#És responsabilitat de qui l'ha retornat que aquest ja no formi part de l'arbre principal.
func return_element(element: Node) -> void:
	for poolable : Poolable in _pool:
		if poolable.element == element:
			assert(not poolable.availability, "Pool->return_element: returned element was already available")
			poolable.availability = true
			return
	assert(false, "Pool->get_element: returned element does not belong to current pool")
	
#S'eliminen tots els elements del pool estiguin actius o no.
#Tant la Pool com el Poolable internament es declaren com a RefCounted
#per tant, s'auto eliminen al perdre les referències.
#Tot i això, cal alliberar els Nodes i buidar l'Array per a eliminar aquestes
#referències.
func dispose() -> void:
	for poolable : Poolable in _pool:
		poolable.element.queue_free()
	_pool.clear()
