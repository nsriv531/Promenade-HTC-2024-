import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { AlertCircle, CheckCircle } from "lucide-react";

const SignUp = () => {
  // Adding state management
  const [formData, setFormData] = useState({
    firstname: "",
    lastname: "",
    pronouns: "",
    ageRange: "",
    genderIdentity: "",
    intrests: "",
    email: "",
    password: "",
    confirmPassword: "",
    languages: "",
  });

  const [errors, setErrors] = useState({});
  const [isSubmitted, setIsSubmitted] = useState(false);

  const ageRanges = ["18-24", "25-34", "35-44", "45-54", "55+"];
  const genderOptions = ["Man", "Woman", "Non-binary", "Other"];
  const pronounOptions = ["he/him", "she/her", "they/them", "Other"];

  const navigate = useNavigate();

  const handleLogin = () => {
    // Perform login logic here, then navigate
    navigate("/interests"); // Replace "/home" with your desired route
  };

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

  // Validate the form
  const validateForm = () => {
    let tempErr = {};
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!formData.firstname.trim())
      tempErr.firstname = "First name is required";
    if (!formData.lastname.trim()) tempErr.lastname = "Last name is required";
    if (!formData.ageRange) tempErr.ageRange = "Age range is required";
    if (!formData.genderIdentity) tempErr.genderIdentity = "Gender is required";

    // Email validation
    if (!formData.email) {
      tempErr.email = "Email is required";
    } else if (!emailRegex.test(formData.email)) {
      tempErr.email = "Invalid email format";
    }

    // Password validation
    if (!formData.password) {
      tempErr.password = "Password is required";
    } else if (formData.password.length < 8) {
      tempErr.password = "Password must be at least 8 characters";
    }

    // Confirm password
    if (!formData.confirmPassword) {
      tempErr.confirmPassword = "Please confirm your password";
    } else if (formData.password !== formData.confirmPassword) {
      tempErr.confirmPassword = "Passwords do not match";
    }

    setErrors(tempErr);
    return Object.keys(tempErr).length === 0;
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();
    const isValid = validateForm();

    if (isValid) {
      console.log("Form submitted: ", formData);
      setIsSubmitted(true);
    }
  };

  // Return JSX
  //   return (
  //     <div className="max-w-2xl mx-auto p-6">
  //       <h2 className="text-3xl font-bold mb-6">Create Your Profile</h2>

  //       {isSubmitted && (
  //         <div className="mb-4 p-4 bg-green-100 text-green-700 rounded-lg flex items-center">
  //           <CheckCircle className="mr-2" size={20} />
  //           Profile created successfully!
  //         </div>
  //       )}

  //       <form onSubmit={handleSubmit} className="space-y-6">
  //         {/* Personal Information Section */}
  //         <div className="bg-gray-50 p-6 rounded-lg">
  //           <h3 className="text-xl font-semibold mb-4">Personal Information</h3>
  //           <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
  //             {/* First Name */}
  //             <div>
  //               <label className="block mb-1 font-medium">First Name</label>
  //               <input
  //                 type="text"
  //                 name="firstname"
  //                 value={formData.firstname}
  //                 onChange={handleChange}
  //                 className={`w-full p-2 border rounded ${
  //                   errors.firstname ? "border-red-500" : "border-gray-300"
  //                 }`}
  //               />
  //               {errors.firstname && (
  //                 <div className="mt-1 text-red-500 text-sm flex items-center">
  //                   <AlertCircle className="mr-1" size={16} />
  //                   {errors.firstname}
  //                 </div>
  //               )}
  //             </div>

  //             {/* Last Name */}
  //             <div>
  //               <label className="block mb-1 font-medium">Last Name</label>
  //               <input
  //                 type="text"
  //                 name="lastname"
  //                 value={formData.lastname}
  //                 onChange={handleChange}
  //                 className={`w-full p-2 border rounded ${
  //                   errors.lastname ? "border-red-500" : "border-gray-300"
  //                 }`}
  //               />
  //               {errors.lastname && (
  //                 <div className="mt-1 text-red-500 text-sm flex items-center">
  //                   <AlertCircle className="mr-1" size={16} />
  //                   {errors.lastname}
  //                 </div>
  //               )}
  //             </div>

  //             {/* Age Range */}
  //             <div>
  //               <label className="block mb-1 font-medium">Age Range</label>
  //               <select
  //                 name="ageRange"
  //                 value={formData.ageRange}
  //                 onChange={handleChange}
  //                 className={`w-full p-2 border rounded ${
  //                   errors.ageRange ? "border-red-500" : "border-gray-300"
  //                 }`}>
  //                 <option value="">Select age range</option>
  //                 {ageRanges.map((range) => (
  //                   <option key={range} value={range}>
  //                     {range}
  //                   </option>
  //                 ))}
  //               </select>
  //               {errors.ageRange && (
  //                 <div className="mt-1 text-red-500 text-sm flex items-center">
  //                   <AlertCircle className="mr-1" size={16} />
  //                   {errors.ageRange}
  //                 </div>
  //               )}
  //             </div>

  //             {/* Gender Identity */}
  //             <div>
  //               <label className="block mb-1 font-medium">Gender Identity</label>
  //               <select
  //                 name="genderIdentity"
  //                 value={formData.genderIdentity}
  //                 onChange={handleChange}
  //                 className="w-full p-2 border rounded border-gray-300">
  //                 <option value="">Select gender identity</option>
  //                 {genderOptions.map((option) => (
  //                   <option key={option} value={option}>
  //                     {option}
  //                   </option>
  //                 ))}
  //               </select>
  //             </div>

  //             {/* Pronouns */}
  //             <div>
  //               <label className="block mb-1 font-medium">Pronouns</label>
  //               <select
  //                 name="pronouns"
  //                 value={formData.pronouns}
  //                 onChange={handleChange}
  //                 className="w-full p-2 border rounded border-gray-300">
  //                 <option value="">Select pronouns</option>
  //                 {pronounOptions.map((option) => (
  //                   <option key={option} value={option}>
  //                     {option}
  //                   </option>
  //                 ))}
  //               </select>
  //             </div>

  //             {/* Interests */}
  //             <div>
  //               <label className="block mb-1 font-medium">Interests</label>
  //               <textarea
  //                 name="interests"
  //                 value={formData.interests}
  //                 onChange={handleChange}
  //                 className="w-full p-2 border rounded border-gray-300"
  //                 placeholder="Tell us about your interests..."
  //                 rows="3"
  //               />
  //             </div>
  //           </div>
  //         </div>

  //         {/* Account Information Section */}
  //         <div className="bg-gray-50 p-6 rounded-lg">
  //           <h3 className="text-xl font-semibold mb-4">Account Information</h3>
  //           <div className="space-y-4">
  //             {/* Email */}
  //             <div>
  //               <label className="block mb-1 font-medium">Email</label>
  //               <input
  //                 type="email"
  //                 name="email"
  //                 value={formData.email}
  //                 onChange={handleChange}
  //                 className={`w-full p-2 border rounded ${
  //                   errors.email ? "border-red-500" : "border-gray-300"
  //                 }`}
  //               />
  //               {errors.email && (
  //                 <div className="mt-1 text-red-500 text-sm flex items-center">
  //                   <AlertCircle className="mr-1" size={16} />
  //                   {errors.email}
  //                 </div>
  //               )}
  //             </div>

  //             {/* Password */}
  //             <div>
  //               <label className="block mb-1 font-medium">Password</label>
  //               <input
  //                 type="password"
  //                 name="password"
  //                 value={formData.password}
  //                 onChange={handleChange}
  //                 className={`w-full p-2 border rounded ${
  //                   errors.password ? "border-red-500" : "border-gray-300"
  //                 }`}
  //               />
  //               {errors.password && (
  //                 <div className="mt-1 text-red-500 text-sm flex items-center">
  //                   <AlertCircle className="mr-1" size={16} />
  //                   {errors.password}
  //                 </div>
  //               )}
  //             </div>

  //             {/* Confirm Password */}
  //             <div>
  //               <label className="block mb-1 font-medium">Confirm Password</label>
  //               <input
  //                 type="password"
  //                 name="confirmPassword"
  //                 value={formData.confirmPassword}
  //                 onChange={handleChange}
  //                 className={`w-full p-2 border rounded ${
  //                   errors.confirmPassword ? "border-red-500" : "border-gray-300"
  //                 }`}
  //               />
  //               {errors.confirmPassword && (
  //                 <div className="mt-1 text-red-500 text-sm flex items-center">
  //                   <AlertCircle className="mr-1" size={16} />
  //                   {errors.confirmPassword}
  //                 </div>
  //               )}
  //             </div>
  //           </div>
  //         </div>

  //         <button
  //           type="submit"
  //           className="w-full bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600 transition-colors font-medium">
  //           Create Profile
  //         </button>
  //       </form>
  //     </div>
  //   );

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="max-w-2xl w-full bg-white p-8 rounded-lg shadow-lg">
        <h2 className="text-3xl font-bold mb-6 text-center">Create Account</h2>
        <h3 className="text-2xl  mb-6 text-center">Step into a Promenade</h3>

        {isSubmitted && (
          <div className="mb-4 p-4 bg-green-100 text-green-700 rounded-lg flex items-center">
            <CheckCircle className="mr-2" size={20} />
            Profile created successfully!
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Personal Information Section */}
          <div className="bg-gray-50 p-6 rounded-lg">
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
                  className={`w-full p-2 border rounded ${
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
                  className={`w-full p-2 border rounded ${
                    errors.lastname ? "border-red-500" : "border-gray-300"
                  }`}
                />
                {errors.lastname && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.lastname}
                  </div>
                )}
              </div>

              {/* gender */}
              <div>
                <label className="block mb-1 font-medium">Gender</label>
                <select
                  name="genderIdentity"
                  value={formData.genderIdentity}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.genderIdentity ? "border-red-500" : "border-gray-300"
                  }`}>
                  <option value="">Select Options</option>
                  {genderOptions.map((range) => (
                    <option key={range} value={range}>
                      {range}
                    </option>
                  ))}
                </select>
                {errors.genderIdentity && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.genderIdentity}
                  </div>
                )}
              </div>

              {/* pronouns */}
              <div>
                <label className="block mb-1 font-medium">
                  Pronouns (Optional)
                </label>
                <select
                  name="pronouns"
                  value={formData.pronouns}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded`}>
                  <option value="">Select Options</option>
                  {pronounOptions.map((range) => (
                    <option key={range} value={range}>
                      {range}
                    </option>
                  ))}
                </select>
              </div>

              {/* Age Range */}
              <div>
                <label className="block mb-1 font-medium">Age Range</label>
                <select
                  name="ageRange"
                  value={formData.ageRange}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.ageRange ? "border-red-500" : "border-gray-300"
                  }`}>
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

              {/* Languages */}
              <div>
                <label className="block mb-1 font-medium">
                  Languages (Optional)
                </label>
                <input
                  type="text"
                  name="languages"
                  value={formData.languages}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded`}
                  placeholder="Languages (separated by commas)"
                />
              </div>

              {/* Other fields remain unchanged */}
            </div>
          </div>

          {/* Account Information Section */}
          <div className="bg-gray-50 p-6 rounded-lg">
            <h3 className="text-xl font-semibold mb-4">Account Information</h3>
            <div className="space-y-4">
              {/* Email */}
              <div>
                <label className="block mb-1 font-medium">Email</label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.email ? "border-red-500" : "border-gray-300"
                  }`}
                />
                {errors.email && (
                  <div className="mt-1 text-red-500 text-sm flex items-center">
                    <AlertCircle className="mr-1" size={16} />
                    {errors.email}
                  </div>
                )}
              </div>

              {/* Password */}
              <div>
                <label className="block mb-1 font-medium">Password</label>
                <input
                  type="password"
                  name="password"
                  value={formData.password}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.password ? "border-red-500" : "border-gray-300"
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
                <label className="block mb-1 font-medium">
                  Confirm Password
                </label>
                <input
                  type="password"
                  name="confirmPassword"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  className={`w-full p-2 border rounded ${
                    errors.confirmPassword
                      ? "border-red-500"
                      : "border-gray-300"
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
            className="font-inter text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan"
            onClick={handleLogin}>
            Next
          </button>
        

          </div>
          </form>
      </div>
    </div>
  );
};

export default SignUp;
