extends Control

func _ready():
	$FileMenu.get_popup().add_item("Open File")
	$FileMenu.get_popup().add_item("Open Folder(inop)")
	$FileMenu.get_popup().add_item("Save As File")
	$FileMenu.get_popup().add_item("Quit")
	
	$HelpMenu.get_popup().add_item("About")
	
	$FileMenu.get_popup().connect("id_pressed", self, "_on_fileitem_pressed")
	$HelpMenu.get_popup().connect("id_pressed", self, "_on_helpitem_pressed")
	
	





func _on_fileitem_pressed(id):
	var item_name = $FileMenu.get_popup().get_item_text(id)
	match item_name:
		"Open File":$openFileDialog.popup()
		"Open Folder(inop)":pass
		"Save As File":$saveAsFileDialog.popup()
		"Quit":get_tree().quit()

func _on_helpitem_pressed(id):
	var item_name = $HelpMenu.get_popup().get_item_text(id)
	match item_name:
		"About":$AboutDialog.popup()

func _on_OpenFileButton_pressed() -> void:
	$openFileDialog.popup()


func _on_SaveAsFileButton_pressed() -> void:
	$saveAsFileDialog.popup()


func _on_openFileDialog_file_selected(path: String):
	print(path)
	var f = File.new()
	f.open(path, 1)
	$TextEditor.text = f.get_as_text()
	f.close()


func _on_saveAsFileDialog_file_selected(path: String):
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEditor.text)
	f.close()
