import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { AlertCircle, CheckCircle } from "lucide-react";
import { collection, addDoc, query, where, getDocs } from "firebase/firestore";
import { db } from "../firebase";
import BackButton from './BackButton';
import Interests from "./Interests";

const SignUp = () => {
  const [formData, setFormData] = useState({
    firstname: "",
    lastname: "",
    pronouns: "",
    ageRange: "",
    genderIdentity: "",
    interests: [],
    email: "",
    password: "",
    confirmPassword: "",
    languages: "",
  });

  const [errors, setErrors] = useState({});
  const [isSubmitted, setIsSubmitted] = useState(false);
  const navigate = useNavigate();

  const ageRanges = ["18-24", "25-34", "35-44", "45-54", "55+"];
  const genderOptions = ["Man", "Woman", "Non-binary", "Other"];
  const pronounOptions = ["he/him", "she/her", "they/them", "Other"];

  // Handle input
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
    if (errors[name]) {
      setErrors({
        ...errors,
        [name]: "",
      });
    }
  };

  // Update interests
  const updateInterests = (newInterests) => {
    setFormData((prevData) => ({
      ...prevData,
      interests: newInterests,
    }));
  };

  // Validate the form
  const validateForm = () => {
    let tempErr = {};
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!formData.firstname.trim())
      tempErr.firstname = "First name is required";
    if (!formData.ageRange) tempErr.ageRange = "Age range is required";
    if (!formData.email) {
      tempErr.email = "Email is required";
    } else if (!emailRegex.test(formData.email)) {
      tempErr.email = "Invalid email format";
    }
    if (!formData.password) {
      tempErr.password = "Password is required";
    } else if (formData.password.length < 8) {
      tempErr.password = "Password must be at least 8 characters";
    }
    if (!formData.confirmPassword) {
      tempErr.confirmPassword = "Please confirm your password";
    } else if (formData.password !== formData.confirmPassword) {
      tempErr.confirmPassword = "Passwords do not match";
    }

    setErrors(tempErr);
    return Object.keys(tempErr).length === 0;
  };

  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    const isValid = validateForm();

    if (isValid) {
      try {
        // Check if a user with the same email already exists
        const usersCollection = collection(db, "users");
        const emailQuery = query(usersCollection, where("email", "==", formData.email));
        const querySnapshot = await getDocs(emailQuery);

        if (!querySnapshot.empty) {
          setErrors((prevErrors) => ({
            ...prevErrors,
            email: "Email already exists",
          }));
          return;
        }

        // Create JSON object to be sent to Firestore
        const userData = {
          firstname: formData.firstname,
          lastname: formData.lastname || null,
          pronouns: formData.pronouns || null,
          ageRange: formData.ageRange,
          genderIdentity: formData.genderIdentity || null,
          interests: formData.interests || [],
          email: formData.email,
          languages: formData.languages ? formData.languages.split(",") : [],
        };

        // Add document to Firestore
        await addDoc(usersCollection, userData);

        setIsSubmitted(true);
        // Navigate to the login page
        navigate("/");
      } catch (error) {
        console.error("Error creating user:", error);
      }
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100 bg-gradient-to-r from-lavender-pink to-light-cyan">
      <div className="max-w-2xl w-full bg-white p-8 rounded-lg shadow-lg">
      <BackButton /> {/* Add the BackButton here at the top */}
        <h2 className="text-3xl font-bold mb-6 text-center">Create Account</h2>
        <h3 className="text-2xl mb-6 text-center">Step into a Promenade</h3>
        {isSubmitted && (
          <div className="mb-4 p-4 bg-green-100 text-green-700 rounded-lg flex items-center">
            <CheckCircle className="mr-2" size={20} />
            Profile created successfully!
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Personal Information Section */}
          <div className="bg-gray-50 p-6 rounded-lg bg-opacity-55">
            <h3 className="text-xl font-semibold mb-4">Personal Information</h3>
            <div className="grid grid-cols-1 md:grid-cols-1 gap-4">
              {/* First Name */}
              <div>
                <label className="block mb-1 font-medium">First Name</label>
                <input
                  type="text"
                  name="firstname"
                  value={formData.firstname}
                  onChange={handleChange}
                  className={`w-full p-2 border border-wenge rounded ${
                    errors.firstname ? "border-red-500" : "border-gray-300"
                  }`}
                />
                {errors.firstname && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.firstname}
                  </div>
                )}
              </div>

              {/* Last Name */}
              <div>
                <label className="block mb-1 font-medium">Last Name</label>
                <input
                  type="text"
                  name="lastname"
                  value={formData.lastname}
                  onChange={handleChange}
                  className="w-full p-2 border rounded border-wenge"
                />
              </div>

              {/* Pronouns */}
              <div>
                <label className="block mb-1 font-medium">Pronouns</label>
                <select
                  name="pronouns"
                  value={formData.pronouns}
                  onChange={handleChange}
                  className="w-full p-2 border rounded border-wenge"
                >
                  <option value="">Select pronouns</option>
                  {pronounOptions.map((option) => (
                    <option key={option} value={option}>
                      {option}
                    </option>
                  ))}
                </select>
              </div>

              {/* Age Range (Required) */}
              <div>
                <label className="block mb-1 font-medium">Age Range</label>
                <select
                  name="ageRange"
                  value={formData.ageRange}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.ageRange ? "border-red-500" : "border-wenge"
                  }`}
                >
                  <option value="">Select age range</option>
                  {ageRanges.map((range) => (
                    <option key={range} value={range}>
                      {range}
                    </option>
                  ))}
                </select>
                {errors.ageRange && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.ageRange}
                  </div>
                )}
              </div>

              {/* Gender Identity */}
              <div>
                <label className="block mb-1 font-medium">Gender Identity</label>
                <select
                  name="genderIdentity"
                  value={formData.genderIdentity}
                  onChange={handleChange}
                  className="w-full p-2 border rounded border-wenge"
                >
                  <option value="">Select gender</option>
                  {genderOptions.map((option) => (
                    <option key={option} value={option}>
                      {option}
                    </option>
                  ))}
                </select>
              </div>

              {/* Interests */}
              <div>
                <label className="block mb-1 p-2 font-medium">Interests</label>
                <Interests
                  selectedInterests={formData.interests}
                  onInterestsChange={updateInterests}
                />
              </div>

              {/* Languages */}
              <div>
                <label className="block mb-1 font-medium">Languages</label>
                <input
                  type="text"
                  name="languages"
                  value={formData.languages}
                  onChange={handleChange}
                  className="w-full p-2 border rounded border-wenge"
                  placeholder="Languages (comma-separated)"
                />
              </div>
            </div>
          </div>

          {/* Account Information Section */}
          <div className="bg-gray-50 p-6 rounded-lg bg-opacity-55">
            <h3 className="text-xl font-semibold mb-4">Account Information</h3>
            <div className="space-y-4 border-wenge">
              {/* Email (Required) */}
              <div>
                <label className="block mb-1 font-medium">Email</label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.email ? "border-red-500" : "border-wenge"
                  }`}
                />
                {errors.email && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.email}
                  </div>
                )}
              </div>

              {/* Password (Required) */}
              <div>
                <label className="block mb-1 font-medium">Password</label>
                <input
                  type="password"
                  name="password"
                  value={formData.password}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.password ? "border-red-500" : "border-wenge"
                  }`}
                />
                {errors.password && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.password}
                  </div>
                )}
              </div>

              {/* Confirm Password */}
              <div>
                <label className="block mb-1 font-medium">Confirm Password</label>
                <input
                  type="password"
                  name="confirmPassword"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.confirmPassword ? "border-red-500" : "border-wenge"
                  }`}
                />
                {errors.confirmPassword && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.confirmPassword}
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className="text-center">
            <button
              type="submit"
              className="font-inter h-12 w-80 rounded-xl bg-opacity-45 bg-gray-200"
            >
              Create Account
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default SignUp;
