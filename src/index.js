import { createAppContainer } from "react-navigation";
import { createStackNavigator } from "react-navigation-stack";



import {
  HomeScreen,
  LoginScreen,
  RegisterScreen,
  ForgotPasswordScreen,
  AuthLoadingScreen,
  Dashboard,
  Detectfrecture,
  MediaScreen
} from "./screens";

const Router = createStackNavigator(
  {
    HomeScreen,
    LoginScreen,
    RegisterScreen,
    ForgotPasswordScreen,
    Dashboard,
    Detectfrecture,
    AuthLoadingScreen,
    MediaScreen
    
  },
  {
    initialRouteName: "AuthLoadingScreen",
    headerMode: "none"
  }
);

export default createAppContainer(Router);
