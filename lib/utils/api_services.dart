class ApiServices {

  static const String BASE_URL = 'http://demo.restaurant.techisland.xyz/';
  // static const String BASE_URL = 'http://192.168.0.107:5000/';

  static const String GET_TOKEN = BASE_URL + 'api/admin/auth/get/token';
  static const String RECOMMENDED_ITEM_LIST = BASE_URL + 'api/customer/recommended/item/list';
  static const String CATEGORY_LIST = BASE_URL + 'api/admin/category/list';
  static const String ITEM_LIST = BASE_URL + 'api/customer/category/wise/item/list';
  static const String ADD_TO_CART = BASE_URL + 'api/customer/add/to/cart';
  static const String GET_CART_ITEM_LIST = BASE_URL + 'api/customer/get/cart/item/list';
  static const String GET_CART_ITEM_NUMBER = BASE_URL + 'api/customer/get/cart/item/number';
  static const String GET_ORDER_TYPE_LIST = BASE_URL + 'api/admin/order/type/list';
  static const String UPDATE_CART_ITEM = BASE_URL + 'api/customer/update/cart/item';
  static const String DELETE_CART_ITEM = BASE_URL + 'api/customer/delete/cart/item';
  static const String CONFIRM_ORDER = BASE_URL + 'api/customer/confirm/order';
  static const String APPLY_PROMO_CODE = BASE_URL + 'api/customer/apply/promo/code';
  static const String GET_ORDER_LIST = BASE_URL + 'api/customer/get/order/list';
  static const String GET_CURRENT_ORDER_LIST = BASE_URL + 'api/customer/get/current/order/list';
}
