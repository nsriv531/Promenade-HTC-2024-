import React, { useState, useEffect } from "react";
import { db } from "../firebase";
import { collection, getDocs } from "firebase/firestore";
import { useNavigate } from "react-router-dom";
import BackButton from './BackButton';

const LocationList = () => {
  const [filterInput, setFilterInput] = useState("");
  const [dataList, setDataList] = useState([]);
  const [startLocation, setStartLocation] = useState(null);
  const [endLocation, setEndLocation] = useState(null);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const navigate = useNavigate(); // React Router hook to navigate

  const handleNavigate = (path) => {
    setIsTransitioning(true);
    setTimeout(() => navigate(path), 1000); // Navigate after animation
  }

  useEffect(() => {
    const fetchData = async () => {
      try {
        const snapshot = await getDocs(collection(db, "locations"));
        setDataList(
          snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }))
        );
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);

  const handleSelectStart = (data) => {
    setStartLocation(data);
    localStorage.setItem("startLocation", JSON.stringify(data));
  };

  const handleSelectEnd = (data) => {
    setEndLocation(data);
    localStorage.setItem("endLocation", JSON.stringify(data));
  };

  const handleContinue = () => {
    if (startLocation && endLocation) {
      handleNavigate("/matched-users", { state: { startLocation, endLocation } });
    }
  };

  const filteredData = dataList.filter(
    (data) =>
      data.name.toLowerCase().includes(filterInput.toLowerCase()) ||
      filterInput === ""
  );

  return (
    <div className="container mx-auto p-6 bg-gray-100 rounded-lg shadow-md bg-gradient-to-r from-lavender-pink to-light-cyan">
      <BackButton />
      <p className="mb-4">
        <input
          id="filter"
          name="filter"
          type="text"
          placeholder="Enter a location"
          value={filterInput}
          onChange={(e) => setFilterInput(e.target.value)}
          className="w-full p-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </p>
      <ul className="space-y-2">
        {filteredData.map((data) => (
          <li
            key={data.id}
            className={`bg-opacity-45 flex items-center justify-between p-2 bg-white rounded border hover:bg-gray-50 ${isTransitioning ? "animate-RslideOut" : "animate-RslideIn"}`}>
            <span className="font-inter-medium">{data.name}</span>
            <div className="grid grid-rows-2 gap-1">
              <button
                onClick={() => handleSelectStart(data)}
                className="px-3 py-1 bg-wenge text-white rounded">
                Set as Start
              </button>
              <button
                onClick={() => handleSelectEnd(data)}
                className="px-3 py-1 bg-green-500 text-white rounded">
                Set as End
              </button>
            </div>
          </li>
        ))}
      </ul>

      {/* Display the selected start and end locations */}
      <div className={`mt-6 p-4 bg-white rounded shadow ${isTransitioning ? "animate-RslideOut" : "animate-RslideIn"}`}>
        <h2 className="text-lg font-bold mb-3">Selected Locations</h2>
        {startLocation && (
          <p className="mb-2">
            <strong className="text-blue-500">Start Location:</strong>{" "}
            {startLocation.name} <br />
            <span className="text-gray-600">
              <strong>Details:</strong>{" "}
              {startLocation.details || "No details available"}
            </span>
          </p>
        )}
        {endLocation && (
          <p>
            <strong className="text-green-500">End Location:</strong>{" "}
            {endLocation.name} <br />
            <span className="text-gray-600">
              <strong>Details:</strong>{" "}
              {endLocation.details || "No details available"}
            </span>
          </p>
        )}
      </div>

      {/* Continue Button */}
      <div className="mt-4">
        <button
          onClick={handleContinue}
          disabled={!startLocation || !endLocation}
          className={`w-full px-4 py-2 text-white rounded ${
            startLocation && endLocation
              ? "bg-blue-500 hover:bg-blue-600"
              : "bg-gray-400 cursor-not-allowed"
          }`}>
          Continue
        </button>
      </div>
    </div>
  );
};

export default LocationList;
