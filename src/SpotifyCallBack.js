// src/SpotifyCallback.js
import React, { useEffect } from 'react';
import axios from 'axios';

const SpotifyCallback = () => {
  useEffect(() => {
    const code = new URLSearchParams(window.location.search).get('code');
    if (code) {
      const getAccessToken = async () => {
        try {
          const response = await axios.post('https://accounts.spotify.com/api/token', null, {
            params: {
              grant_type: 'authorization_code',
              code: code,
              redirect_uri: 'http://localhost:3000/callback', // Your Redirect URI
              client_id: 'YOUR_SPOTIFY_CLIENT_ID',
              client_secret: 'YOUR_SPOTIFY_CLIENT_SECRET',
            },
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          });
          
          const accessToken = response.data.access_token;
          // Save the access token to the user profile in Firebase or React state
          console.log('Access Token:', accessToken);
        } catch (error) {
          console.error('Error getting access token:', error);
        }
      };
      getAccessToken();
    }
  }, []);

  return <div>Authenticating with Spotify...</div>;
};

export default SpotifyCallback;
