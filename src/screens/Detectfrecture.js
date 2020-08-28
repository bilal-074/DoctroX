import React, { memo } from "react";
import Background from "../components/Background";
import Logo from "../components/Logo";
import Header from "../components/Header";
import Paragraph from "../components/Paragraph";
import Button from "../components/Button";
import { logoutUser } from "../api/auth-api";

const Detectfrecture = ({navigation}) => (

  <Background>
    <Logo />
    <Header>DoctroX Media Screen</Header>

    <Paragraph>
      Making Life Easier
    </Paragraph>
    <Button mode="contained" onPress={() => navigation.navigate("MediaScreen")}>
    Detect frecture
    </Button>
    <Button mode="outlined" onPress={() => logoutUser()}>
      Logout
    </Button>
  </Background>
  
    
  
);

export default memo(Detectfrecture);
