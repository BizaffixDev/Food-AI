class Endpoints {
  Endpoints._();


  ///AUTH ENDPOINTS
  static const signupUser = '/Auth/user-signup';
  static const otpVerify = '/Auth/otp-verfication';
  static const login = '/Auth/user-login';
  static const forgetPassword = '/Auth/forget-password';
  static const newPassword = '/Auth/new-password';



  ///BUILD PROFILE
  static const getPreferences = '/PreferencesQa/Get';
  static const likeDislikeResponse = '/UserProfiling/Add';


  ///DISCOVER
  static const getCuisines = '/CuisineType/Get';
  static const getRestaurants = '/Restaurant/GetAll-Restaurants';
  static const getRestaurantDetails = '/Restaurant/Get-Restaurant-Details';
  static const getPreferencesCuisine = '/CuisinePref/Get';

  ///DINE IN
  static const addUserLocation = '/UserLocation/Add';
  static const nearestRestaurant = '/UserLocation/nearest-restaurant';


  ///CART
  static const addToCart = '/Cart/Add';
  static const getCart = '/Cart/Get';
  static const incrementItem = '/Cart/IncrementItem';
  static const decrementItem = '/Cart/DecrementItem';

  ///NOTIFICATION
  static const notification = '/Notify/Get';

}
