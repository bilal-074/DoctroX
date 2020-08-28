import React, { memo } from "react";
import Background from "../components/Background";
import Logo from "../components/Logo";
import Header from "../components/Header";
import Paragraph from "../components/Paragraph";
import Button from "../components/Button";
import { logoutUser } from "../api/auth-api";

const Dashboard = ({navigation}) => (

  <Background>
    <Logo />
    <Header>DoctroX Dashboard</Header>

    <Paragraph>
      Making Life Easier
    </Paragraph>
    <Button mode="contained" onPress={() => navigation.navigate("Detectfrecture")}>
    Detect frecture
    </Button>
    <Button mode="outlined" onPress={() => logoutUser()}>
      Logout
    </Button>
  </Background>
  
    
  
);

export default memo(Dashboard);
