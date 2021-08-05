'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a890c3d707bcb18cc9641dd58393d4f2",
"assets/assets/fonts/Dancing_Candy.ttf": "1d318a2761974cf4577c76d9a709ae06",
"assets/assets/fonts/Segoe_UI.ttf": "0e7e9a9b5c4abaadef7bc8f4e4574084",
"assets/assets/fonts/Segoe_UI_Bold.ttf": "65099f98c7cb19b3dac57b15a6a708cf",
"assets/assets/fonts/Stay_Classy.ttf": "780d9dd76dba068538194e687e1954c9",
"assets/assets/images/birth.jpg": "ed3dce8f4dda8c3bbb71332ca9ec56e0",
"assets/assets/images/call.png": "393d64a54d2d36eaf586889f5013ac2c",
"assets/assets/images/clincking_glasses_96px.png": "67d8581a6fa0f36fde88a55d2943e437",
"assets/assets/images/deco_mixte.jpg": "e03235ed263f538e23160d2648bb58ab",
"assets/assets/images/deco_moderne.jpg": "683cef755203075a715466dbeee26b0d",
"assets/assets/images/did.png": "e2bce81799e0589bd7d2c72b2c4f59f7",
"assets/assets/images/dj.png": "a417c678738e7577ec879425a8d25dd4",
"assets/assets/images/ent.png": "7f944d4c9664d0ab202e7f3ca44566b9",
"assets/assets/images/event_entreprise.jpg": "db6659a68aeac708492a0183f73a9b84",
"assets/assets/images/facebook.png": "6541bd9612b5e5a9e36dd55cea510a66",
"assets/assets/images/fb_login.png": "d9b00bdd53a2fe70c7b5e37ca4fc1fb7",
"assets/assets/images/first.jpg": "3b78aa8a16afe23a53b4d0e08ee77f6a",
"assets/assets/images/first.png": "94727a85f36f9dd24cf6ab7273e4afa3",
"assets/assets/images/funerailles.jpg": "f9426681e3b59dda7472dd30b0738a4b",
"assets/assets/images/google.png": "55510d53cd8713ff60679241aea77f51",
"assets/assets/images/graphistes.jpg": "2d536c0848daf7514b8894b2a40527a3",
"assets/assets/images/hotesse.jpeg": "0b01b2f27901f321da1c73380288490a",
"assets/assets/images/im.png": "46e991861eacb821830bc3004c89d2fd",
"assets/assets/images/instagram.png": "30072b84b2f208a14b902d845a93213f",
"assets/assets/images/logo_prox.png": "f5f7d154dc9460b22fae87d525789749",
"assets/assets/images/logo_prox1.jpg": "c14dacc024cab5e44151075127475616",
"assets/assets/images/logo_prox3.jpg": "9aa44d40d4444e0579cad0fd7c246999",
"assets/assets/images/logo_prox_w.png": "39bbc201f636d673e039e2497c0e1d43",
"assets/assets/images/logo_prox_w1.png": "b27b8d6cac5928dc0a1f987a9821aae8",
"assets/assets/images/mail.png": "cfd8e5285c557692ee58be09b1c26762",
"assets/assets/images/makeup.jpg": "175fea266ba8207b01ab1d52567a45ac",
"assets/assets/images/mar1.jpg": "17d93367c021a65bc698f0e76e32491d",
"assets/assets/images/mar2.jpg": "2076ddc5e58fbee3fa9d006061c3b361",
"assets/assets/images/mar3.jpg": "238ef81e59c9617b8bcbe1265bf1b362",
"assets/assets/images/mar4.png": "c2cb9222c7dc457dc15913bb58f2c53f",
"assets/assets/images/mar_out.jpg": "b9efda3e8619e3f3063c98aa5a9a49b4",
"assets/assets/images/other.jpg": "476381cdbb3f27e2971538c09405f794",
"assets/assets/images/out_event.jpg": "1b0276321bc21bc18130afde6a5a1e26",
"assets/assets/images/people.png": "915026cda460b287940fc758a999c462",
"assets/assets/images/photographes.jpg": "7a41f2dd3dc18151a5c5e8013fcf8f85",
"assets/assets/images/pp.png": "e5cbed1a011f7759c80c4cbd956a6298",
"assets/assets/images/r_pick.png": "87c16358ebbb624daa25e2e4985bf23e",
"assets/assets/images/salle.jpg": "6e522b381a1908a78901bfcffd841501",
"assets/assets/images/second.png": "2104bdd756a39cfaad28fe492539ad7c",
"assets/assets/images/serve.jpg": "5153f605544f0447e208d10432a0f935",
"assets/assets/images/stand.jpg": "e41abb9cfaf30cadb71896126efc7e11",
"assets/assets/images/state.png": "b267033cf1a8f87f29dc447931739df0",
"assets/assets/images/team.jpg": "787e8920a0f38fdc4de959f0804f835b",
"assets/assets/images/traiteur.jpg": "1bf5778fcd9e6759a501aa043251523d",
"assets/assets/images/traiteur2.jpg": "805315615d50980e3e63cb4e17ca659d",
"assets/assets/images/valentine.jpg": "83fba734e73cee4b4b143bf7c8e879a6",
"assets/assets/images/whatsapp.png": "1d520abbcfbb0bf50cf446157c308d4e",
"assets/assets/images/wheel.png": "92e37511ff6a14d94a72d5a4e2710430",
"assets/assets/images/wine.jpg": "af0d5a388d01283ceebd55dbc5d4d6dd",
"assets/FontManifest.json": "c10b4f5c0820804bfe44c75d0b5c7ec2",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "30ec1bb3543b076db9c34e9196808300",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192%20-%20Copie.png": "67d8581a6fa0f36fde88a55d2943e437",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "a5ab02a34a65307e28c6f604c1950f70",
"/": "a5ab02a34a65307e28c6f604c1950f70",
"main.dart.js": "5d6d5b8f7d4cd7af875628d19783bbda",
"manifest.json": "3ed743221fd8fe823235c336cb281567",
"version.json": "10ccd6d5b29148caed48bdde0c5ba3ef"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
