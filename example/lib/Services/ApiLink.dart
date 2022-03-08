



class ApiLink{

 static String host="https://caterme.azurewebsites.net/api/";
// static String host="https://66a5-185-142-40-150.ngrok.io/api/";
 static String hostlocal="http://192.168.0.1/api/";//elna
 static String devicetoken  ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBldGVyQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJwZXRlckBnbWFpbC5jb20iLCJVSUQiOiJhYTlhZTU0OS03ZGJlLTRkZDctYTI4MS02NDNlNjQ4ZWJjMjIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJhYTlhZTU0OS03ZGJlLTRkZDctYTI4MS02NDNlNjQ4ZWJjMjIiLCJuYmYiOjE2NDMxMjEzNjMsImV4cCI6MTY0NTcxMzM2MywiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMTAiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo0NDMxMCJ9.qeg6OJrOzi90Xpz9V3ZPAC7Lk-m50qDK8G8RtWQ6-AK";



 static String Createnotification=host+"Notifications/SendNotification";
 static String notification=host+"Notifications/GetAllNotifications";
 static String login=host+"Accounts/login";
 static String Register=host+"Accounts/Register/1";
 static String GetPackages=host+'HomePage/GetHomePage';
 static String GetPackagesorder=host+'Orders/OrderPage';
 static String Getcusinibyid=host+'Items/GetCategoryItems/';
 static String Gettimespan=host+'Orders/getTimeSpan/';

 static String categoryTypeId=host+'Items/GetCuisineCategories/';
 static String AddAddress=host+'Addresses/CreateAddress';
 static String GetAllCountry=host+'Addresses/GetAllCountries';
 static String GetAllAddress=host+'Addresses/GetAllAddresses';
 static String GetOrdersSetting=host+'Settings/GetOrderSettings';
 static String GetAllCity=host+'Addresses/GetAllCities/';
 static String AddRegular=host+'Settings/GetOrderSettings';
 static String favoriteitem=host+'Favorites/ToggleFavorite/';
 static String GetAllFriends=host+'Friends/GetAllFriends';
 static String DeleteFriends=host+'Friends/DeleteFriend';
 static String GetAllFavorite=host+'Favorites/GetAllFavorites';
 static String GetAllOrders=host+"Orders/GetUserOrders";
 static String GetAllOrdersById=host+"Orders/GetUserOrderById";
 static String CreateOccasions=host+"Occasions/CreateOccasion";
 static String GetAllOccasionsType=host+"Occasions/GetOccasionTypes";
 static String GETALLPACKAGEORDER=host+"Orders/GetPackageByOrder/";
 static String GETALLADDONSEORDER=host+"Orders/GetPackageByOrder/";
 static String GetOrderStatus=host+"Orders/CheckOrderStatus";
 static String GetItemByCuisine=host+"Orders/GetItemByCuisine/";
 static String GetItemByadd=host+"Orders/GetItemByAddons/";
 static String Createfriends=host+"Friends/CreateFriend";
 static String Updatefriends=host+"Friends/UpdateFriend";
 static String GetPersonalInfo=host+"Accounts/GetUser";
 static String UpdateProfle=host+"Accounts/UpdateProfile";
 static String Getalloccasions=host+"Occasions/GetAllOccasions";
 static String Updateoccasions=host+"Occasions/UpdateOccasion";
 static String Deleteoccasions=host+"Occasions/DeleteOccasion";
 static String UpdatePersonalInfo=host+"Accounts/UpdateProfile";
 static String ResetPassword=host+"Accounts/ResetPassword";
 static String DeleteAddress=host+"Addresses/DeleteAddress";
 static String makeorder=host+"Orders/PlaceOrder";
 static String GetAllCreditCards=host+"Checkout/GetAllCreditCards";
 static String DeleteCreditCards=host+"Checkout/DeleteCreditCard";
 static String AddCreditCards=host+"Checkout/AddCreditCard";
 static String UpdateAddress=host+"Addresses/UpdateAddress";
 static String SeenNotification=host+"Notifications/MarkAsSeen";
 static String DonateFood=host+"Orders/DonateOrder";
 static String DonateFoodss=host+"Orders/DonateOrder";
 static String ForgetPassword=host+"Accounts/ForgetPassword";
 static String getAllPackages = host+"Orders/GetAllPackages";




}