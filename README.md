# PMSB4

Versão independente do projeto PMSB para desenvolvimento dos môdulos Gestor de tarefas (Kanban) e Sintese (indicadores) usando controle de estados com Redux.

A integração do PMSB3 com esta versão, PMSB4 em Redux, será analisada futuramente.

# Definições neste projeto

## Em ingles
* Código Dart e Flutter em ingles
* Coleções e campos novos do Firebase em ingles

## Em portugues
* coleções velhas em portugues (nao compensa mudar)
* dados para usuario em portugues (cliente em potencial)
* git em portugues. para quem nao escreve em ingles.
* TODOs em portugues. para quem nao escreve em ingles.
* Issues em portugues. para quem nao escreve em ingles.

# Pastas
Considerando um projeto basico do counter do flutter

+ actions
	- counter_action.dart
+ container
	+ components
		- counter_value.dart
	+ counter
		- counter_page.dart
+ middlewares
	+ firebase
		- firebase_model.dart
		+ counter
			- counter_model.dart
			- counter_middleware.dart
+ presentation
	+ components
		- counter_value_ui.dart
		- counter_text_comp.dart
	+ counter
		- counter_button_comp.dart
		- counter_page_ui.dart
+ reducers
	- app_reducer.dart
	- counter_reducer.dart
+ selectors
	- counter_selector.dart
+ states
	- app_state.dart
	- counter_state.dart
- main.dart
- routes.dart


# keys
Ainda falta analisar melhor este material: https://developer.android.com/studio/publish/app-signing

Instruçẽos abaixo foram feitas do firebase no registro do app:
keytool -exportcert -list -v \
-alias pmsb4 -keystore pmsb4.keystore

Gerado com o comando:
keytool -genkey -v -keystore pmsb4.keystore -alias pmsb4 -keyalg RSA -keysize 2048 -validity 10000

Senha: pmsb44bsmp

Listado com:
catalunha@stack:~/flutter-projects$ keytool -list -v -alias pmsb4 -keystore pmsb4.keystore 
Enter keystore password:  
Alias name: pmsb4
Creation date: Jun 12, 2020
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=pmsbto 4, OU=uft, O=uft, L=palmas, ST=to, C=br
Issuer: CN=pmsbto 4, OU=uft, O=uft, L=palmas, ST=to, C=br
Serial number: 2fff74944f7fbaaa
Valid from: Fri Jun 12 15:11:41 BRT 2020 until: Tue Oct 29 15:11:41 BRT 2047
Certificate fingerprints:
	 SHA1: 87:A0:CD:CF:13:6D:D2:69:BC:40:F2:99:EB:DB:2B:0C:61:8F:F8:FE
	 SHA256: C2:06:7E:BD:F8:EC:AB:6C:51:38:DF:A9:33:BD:E9:CD:12:02:64:2D:31:D1:20:9C:2A:2D:16:ED:41:8B:23:41
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 3

Extensions: 

#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
KeyIdentifier [
0000: 1F 2B DD F0 C0 AB 7D 1A   55 FC D2 9D 73 44 39 BD  .+......U...sD9.
0010: 68 83 68 47                                        h.hG
]
]

catalunha@stack:~/flutter-projects$ 
