import { getAuth, onAuthStateChanged, signInWithPopup, signOut } from "firebase/auth";
import React, { useEffect, useContext, createContext, useState } from "react";
import { app } from "../../firebase";
import PropTypes from "prop-types";

export const AuthContext = createContext(null);

const AuthProvider = ({ children }) => {
    const [currentUser, setCurrentUser] = useState(null);
    const [userLoggedIn, setUserLoggedIn] = useState(false);
    const [loading, setLoading] = useState(true);
    const auth = getAuth();

    const createGoogleUser = (provider) => {
        setLoading(true);
        return signInWithPopup(auth, provider);
    }

    const logOut = () => {
        setLoading(true);
        return signOut(auth);
    };

    useEffect(() => {
        const unsubscribe = onAuthStateChanged(auth, initializeUser); // used for clean up, unmounts auth provider
        return unsubscribe; 
    }, []);

    async function initializeUser(user) {
        if (user) {
            setCurrentUser({ ...user }); // stores all the user's property's
            setUserLoggedIn(true);
        } else { // for logged out users
            setCurrentUser(null);
            setUserLoggedIn(false);
        }
        setLoading(false);
    }

    const value = {
        currentUser,
        createGoogleUser,
        userLoggedIn,
        loading,
        logOut
    }

    return (
        <AuthContext.Provider value={value}>
            {children}
        </AuthContext.Provider>
    )
};

AuthProvider.propTypes = {
    children: PropTypes.node.isRequired,
};

export default AuthProvider;