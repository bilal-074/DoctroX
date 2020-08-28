import React from 'react';
import {
  ActivityIndicator,
  Button,
  Clipboard,
  Image,
  Share,
  StatusBar,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import Constants from 'expo-constants';
import * as ImagePicker from 'expo-image-picker';
import * as Permissions from 'expo-permissions';



export default class PhotoPickerScreen extends React.Component {

  
  state = {
    image: null,
    uploading: false,
  };
 
  render() {
    
    return (
      
      <View style={styles.container}>
        
       

        <Text style={ styles.text}>
         Enter X-Ray Image
        </Text>

        {this._maybeRenderControls()}
        {this._maybeRenderUploadingIndicator()}
        {this._maybeRenderImage()}

        <StatusBar barStyle="default" />
      </View>
    );
  }

  _maybeRenderUploadingIndicator = () => {
    if (this.state.uploading) {
      return <ActivityIndicator animating size="large" />;
    }
  };

  _maybeRenderControls = () => {
    if (!this.state.uploading) {
      return (

        <View style={styles.container}>


          <TouchableOpacity style={styles.galHolder} onPress={this._pickImage}>
			      <Text style={styles.galText} >Upload Image </Text>
		      </TouchableOpacity>

        {/*  <TouchableOpacity style={styles.camHolder} onPress={this._takePhoto}>
			      <Text style={styles.camText} >Camera </Text>
		      </TouchableOpacity>
      */}
{/*
          <View style={{ marginVertical: 8 }}>
          <Button
              onPress={this._pickImage}
              title="Gallery"/>
          </View>
          <View style={{ marginVertical: 8 }}>
            <Button onPress={this._takePhoto} title="CAMERA" />
          </View>

*/}

        </View>
      );
    }
  };

  _maybeRenderImage = () => {
    if (this.state.image) {
      return (
        <View
          style={{
            marginTop: 30,
            width: 250,
            borderRadius: 3,
            elevation: 2,
            shadowColor: 'rgba(0,0,0,1)',
            shadowOpacity: 0.2,
            shadowOffset: { width: 4, height: 4 },
            shadowRadius: 5,
          }}>
          <View
            style={{
              borderTopRightRadius: 3,
              borderTopLeftRadius: 3,
              overflow: 'hidden',
            }}>
            <Image
              source={{ uri: this.state.image }}
              style={{ width: 250, height: 250 }}
            />
          </View>

          <Text
            onPress={this._copyToClipboard}
            onLongPress={this._share}
            style={{ paddingVertical: 10, paddingHorizontal: 10 }}>
            {this.state.image}
          </Text>
        </View>
      );
    }
  };

//  _share = () => {
//    Share.share({
//      message: this.state.image,
//      title: 'Check out this photo',
//      url: this.state.image,
//    });
//  };
//
//  _copyToClipboard = () => {
//    Clipboard.setString(this.state.image);
//    alert('Copied image URL to clipboard');
//  };

  _askPermission = async (type, failureMessage) => {
    const { status, permissions } = await Permissions.askAsync(type);

    if (status === 'denied') {
      alert(failureMessage);
    }
  };

  _takePhoto = async () => {
    await this._askPermission(
      Permissions.CAMERA,
      'We need the camera permission to take a picture...'
    );
    await this._askPermission(
      Permissions.CAMERA_ROLL,
      'We need the camera-roll permission to read pictures from your phone...'
    );
    let pickerResult = await ImagePicker.launchCameraAsync({
      allowsEditing: true,
      aspect: [4, 5],
      quality: 0.5
    });

    this._uploadImage(pickerResult.uri);
  };

  _pickImage = async () => {
    await this._askPermission(
      Permissions.CAMERA_ROLL,
      'We need the camera-roll permission to read pictures from your phone...'
    );
    let pickerResult = await ImagePicker.launchImageLibraryAsync({
      allowsEditing: true,
      aspect:  [4, 5],
      quality: 1
    });
    this._uploadImage(pickerResult.uri);
    //this._handleImagePicked(pickerResult);
  };

// _handleImagePicked = async pickerResult => {
//   let uploadResponse, uploadResult;
//
//   try {
//     this.setState({ uploading: true });
//
//     if (!pickerResult.cancelled) {
//       uploadImage(pickerResult.uri);
//       //uploadResult = await uploadResponse.json();
//       //console.log(uploadResponse)
//       //this.setState({ image: uploadResult.location });
//     }
//   } catch (e) {
//     console.log({ uploadResponse });
//     console.log({ uploadResult });
//     console.log({ e });
//     alert('Upload failed, sorry :(');
//   } finally {
//     this.setState({ uploading: false });
//   }
// };



  //

  _uploadImage = async (image_url) => {
      let base_url = IP+'/flow/images/';
      this.setState({uploading: true});
      let uploadData = new FormData();
      uploadData.append('submit' , 'ok');
      uploadData.append('file' , {
      type: 'image/png', 
      uri: image_url, 
      name: 'uploadedimagetmp.png'})
      console.log("BEFORE FETCH")
      fetch(base_url , {
      method: 'post',
      body: uploadData})
      .then(response => response.json())
      .then(response => {
        if(response.status){
          console.log(response)
          this.setState({uploading: false});
        } else {
          this.setState({uploading: false});
          Alert.alert('Error',response.message);
        }
         }).catch(()=>{
          this.setState({uploading: false});
            console.log('FETCH CATCH')
      })
    }
  }
  
  const styles = StyleSheet.create({
    container: {
      flex: 1,
      //alignItems: 'center',
      //backgroundColor: 'green',
      justifyContent: 'center',
      
      
      
      
    },
   
    text: {
      //backgroundColor: 'red',

      fontSize: 26,
      marginHorizontal: 5,
      marginVertical: 20,
      padding: 10,
      textAlign: 'center',
      
    },

    galText:{

      fontSize: 25,
      margin: 10,
      padding: 12,
      paddingHorizontal: 60,
      textAlign: 'center',
      marginHorizontal: 15,
    },

    galHolder: {
      //backgroundColor: 'red',
      borderColor: '#0dacf6',
      borderWidth: 1,
      borderRadius: 10,
      backgroundColor: '#0dacf6',
      margin: 10,
     
    },

    camText:{

      fontSize: 25,
      margin: 10,
      padding: 12,
      paddingHorizontal: 60,
      textAlign: 'center',
      marginHorizontal: 15,
      
    },

    camHolder: {
      //backgroundColor: 'red',
      borderColor: '#ffaadd',
      borderWidth: 1,
      borderRadius: 10,
      backgroundColor: '#e5f0ff',
      margin: 10,
      marginBottom: 100,
     
     
    }
    
  });
  