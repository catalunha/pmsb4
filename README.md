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
		+ authentication
			- authentication_middleware.dart
		- firebase_model.dart
		+ counter
			- counter_model.dart
			- counter_middleware.dart
+ presentation
	+ components
		- counter_value_ds.dart
		- counter_text_comp.dart
	+ counter
		- counter_button_comp.dart
		- counter_page_ds.dart
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


# Web

## url
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="/__/firebase/7.15.1/firebase-app.js"></script>

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->

<!-- Initialize Firebase -->
<script src="/__/firebase/init.js"></script>


## CDN
<body>
  <!-- Insert these scripts at the bottom of the HTML, but before you use any Firebase services -->

  <!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>

  <!-- Add Firebase products that you want to use -->
  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-auth.js"></script>
  <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-firestore.js"></script>
</body>

npm install -g firebase-tools
firebase login
firebase init
firebase deploy --only hosting:pmsbto

firebase deploy --only hosting:pmsbto

catalunha@stack:~/flutter-projects/pmsb4$ flutter build web
catalunha@stack:~/flutter-projects/pmsb4$ flutter run -d chrome



# public / html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome to Firebase Hosting</title>

    <!-- update the version number as needed -->
    <script defer src="/__/firebase/7.15.1/firebase-app.js"></script>
    <!-- include only the Firebase features as you need -->
    <script defer src="/__/firebase/7.15.1/firebase-auth.js"></script>
    <script defer src="/__/firebase/7.15.1/firebase-database.js"></script>
    <script defer src="/__/firebase/7.15.1/firebase-messaging.js"></script>
    <script defer src="/__/firebase/7.15.1/firebase-storage.js"></script>
    <!-- initialize the SDK after all desired features are loaded -->
    <script defer src="/__/firebase/init.js"></script>

    <style media="screen">
      body { background: #ECEFF1; color: rgba(0,0,0,0.87); font-family: Roboto, Helvetica, Arial, sans-serif; margin: 0; padding: 0; }
      #message { background: white; max-width: 360px; margin: 100px auto 16px; padding: 32px 24px; border-radius: 3px; }
      #message h2 { color: #ffa100; font-weight: bold; font-size: 16px; margin: 0 0 8px; }
      #message h1 { font-size: 22px; font-weight: 300; color: rgba(0,0,0,0.6); margin: 0 0 16px;}
      #message p { line-height: 140%; margin: 16px 0 24px; font-size: 14px; }
      #message a { display: block; text-align: center; background: #039be5; text-transform: uppercase; text-decoration: none; color: white; padding: 16px; border-radius: 4px; }
      #message, #message a { box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24); }
      #load { color: rgba(0,0,0,0.4); text-align: center; font-size: 13px; }
      @media (max-width: 600px) {
        body, #message { margin-top: 0; background: white; box-shadow: none; }
        body { border-top: 16px solid #ffa100; }
      }
    </style>
  </head>
  <body>
    <div id="message">
      <h2>Welcome</h2>
      <h1>Firebase Hosting Setup Complete</h1>
      <p>You're seeing this because you've successfully setup Firebase Hosting. Now it's time to go build something extraordinary!</p>
      <a target="_blank" href="https://firebase.google.com/docs/hosting/">Open Hosting Documentation</a>
    </div>
    <p id="load">Firebase SDK Loading&hellip;</p>

    <script>
      document.addEventListener('DOMContentLoaded', function() {
        // // 🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥
        // // The Firebase SDK is initialized and available here!
        //
        // firebase.auth().onAuthStateChanged(user => { });
        // firebase.database().ref('/path/to/ref').on('value', snapshot => { });
        // firebase.messaging().requestPermission().then(() => { });
        // firebase.storage().ref('/path/to/ref').getDownloadURL().then(() => { });
        //
        // // 🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥

        try {
          let app = firebase.app();
          let features = ['auth', 'database', 'messaging', 'storage'].filter(feature => typeof app[feature] === 'function');
          document.getElementById('load').innerHTML = `Firebase SDK loaded with ${features.join(', ')}`;
        } catch (e) {
          console.error(e);
          document.getElementById('load').innerHTML = 'Error loading the Firebase SDK, check the console.';
        }
      });
    </script>
  </body>
</html>
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]