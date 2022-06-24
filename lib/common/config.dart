const perPixel = 0.0025641025641026;
bool isDrawerOpen = false;
bool isAboutOpen = false;
bool isHomeOpen = true;
bool isSettingsOpen = false;
bool isFavouriteOpen=false;
bool openedAfterDbUpdate = false;
bool isCameraOpen=false;
const Map<String, int> Menu = {
  'home':0,
  'favourite':1,
  'camera':2,
  'login':-1,
  'about':3,
  'setting':4,
  'news':5,
};
const version='0.0.1';
