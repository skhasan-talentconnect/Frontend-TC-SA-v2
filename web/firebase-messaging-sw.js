// Import the Firebase scripts needed for messaging
importScripts("https://www.gstatic.com/firebasejs/9.23.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.23.0/firebase-messaging-compat.js");

// Your Firebase config (copy from firebase_options.dart for web)
firebase.initializeApp({

      apiKey: 'AIzaSyBNj6EFv8fXvutEO3DUgwZvLFHwsb30FHk',
      appId: '1:574038035729:web:d6f3f792c5868cb60490b0',
      messagingSenderId: '574038035729',
      projectId: 'tc-sa-c6a26',
      storageBucket: 'tc-sa-c6a26.firebasestorage.app',
      authDomain: 'tc-sa-c6a26.firebaseapp.com',
      measurementId: 'G-4W9TJKGBDJ',
});

// Initialize messaging
const messaging = firebase.messaging();
