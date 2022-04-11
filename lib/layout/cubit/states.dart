abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopHomeLoadingState extends ShopHomeStates {}

class ShopHomeSuccessState extends ShopHomeStates {}

class ShopHomeErrorState extends ShopHomeStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ChangeScreen extends ShopHomeStates {}

class ShopHomeCategoriesSuccessState extends ShopHomeStates {}

class ShopHomeCategoriesErrorState extends ShopHomeStates {
  final String error;

  ShopHomeCategoriesErrorState(this.error);
}






class ShopHomeFavouritesSuccessState extends ShopHomeStates {}

class ShopHomeFavouritesErrorState extends ShopHomeStates {
  final String error;

  ShopHomeFavouritesErrorState(this.error);
}




class ShopHomeChangeFavouritesIconSuccessState extends ShopHomeStates {}

class ShopHomeChangeFavouritesIconErrorState extends ShopHomeStates {
  final String error;

  ShopHomeChangeFavouritesIconErrorState(this.error);
}




class ShopHomeSettingLoadingState extends ShopHomeStates {}

class ShopHomeSettingSuccessState extends ShopHomeStates {}

class ShopHomeSettingErrorState extends ShopHomeStates {
  final String error;

  ShopHomeSettingErrorState(this.error);
}


class ShopHomeUpdateProfileLoadingState extends ShopHomeStates {}

class ShopHomeUpdateProfileSuccessState extends ShopHomeStates {}

class ShopHomeUpdateProfileErrorState extends ShopHomeStates {
  final String error;

  ShopHomeUpdateProfileErrorState(this.error);
}

class ShopHomeChangePasswordLoadingState extends ShopHomeStates {}

class ShopHomeChangePasswordSuccessState extends ShopHomeStates {}

class ShopHomeChangePasswordErrorState extends ShopHomeStates {
  final String error;

  ShopHomeChangePasswordErrorState(this.error);
}




class ShopHomeLogoutLoadingState extends ShopHomeStates {}

class ShopHomeLogoutSuccessState extends ShopHomeStates {}

class ShopHomeLogoutErrorState extends ShopHomeStates {
  final String error;

  ShopHomeLogoutErrorState(this.error);
}



class ShopHomeSearchLoadingState extends ShopHomeStates {}

class ShopHomeSearchSuccessState extends ShopHomeStates {}

class ShopHomeSearchErrorState extends ShopHomeStates {
  final String error;

  ShopHomeSearchErrorState(this.error);
}