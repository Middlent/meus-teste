extends Control

var nome = false
var host_port = false
var conn_port = false

func _check_host():
	if nome and host_port:
		$Host.disabled = false
	else:
		$Host.disabled = true

func _check_conn():
	if nome and conn_port:
		$Connect.disabled = false
	else:
		$Connect.disabled = true

func _on_nome_text_changed(new_text):
	if new_text != "":
		nome = true
	if new_text == "":
		nome = false
	_check_host()
	_check_conn()

func _on_host_port_text_changed(new_text):
	if new_text != "":
		host_port = true
	if new_text == "":
		host_port = false
	_check_host()


func _on_con_port_text_changed(new_text):
	if new_text != "":
		conn_port = true
	if new_text == "":
		conn_port = false
	_check_conn()
