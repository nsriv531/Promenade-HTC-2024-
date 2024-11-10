import React from "react";
import Chip from "@material-ui/core/Chip";

const Interests = ({ selectedInterests = [], onInterestsChange }) => {
  // Define your available interest options
  const interestOptions = [
    "Technology",
    "Sports",
    "Music",
    "Travel",
    "Reading",
    "Gaming",
    "Cooking",
    "Art",
    "Fitness",
    "Movies",
  ];

  // Handle chip click to toggle selection
  const handleChipClick = (interest) => {
    if (selectedInterests.includes(interest)) {
      // If the interest is already selected, remove it
      onInterestsChange(selectedInterests.filter((i) => i !== interest));
    } else {
      // Otherwise, add the interest to the selected list
      onInterestsChange([...selectedInterests, interest]);
    }
  };

  return (
    <div className="flex flex-wrap gap-2">
      {interestOptions.map((interest) => (
        <Chip
          key={interest}
          label={interest}
          onClick={() => handleChipClick(interest)}
          color={selectedInterests.includes(interest) ? "primary" : "default"}
          variant={selectedInterests.includes(interest) ? "filled" : "outlined"}
          className="cursor-pointer"
        />
      ))}
    </div>
  );
};

export default Interests;
