class_name FileReader

static func read(path,default_data):
	var data = default_data
	var file = File.new()
	file.open(path,File.READ)
	var content :String = file.get_as_text()
	if not content.empty():
		data = str2var(content)
	file.close()
	return data
