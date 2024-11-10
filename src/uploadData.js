import { db } from './firebase';
import { collection, addDoc } from 'firebase/firestore';
import jsonData from './backend/sample.json';
import jsonDataloc from './backend/locations.json';

const uploadDataToFirestore = async () => {
  try {
    const usersCollection = collection(db, 'users');
    const locationsCollection = collection(db, 'locations');

    // Loop over each user in the JSON data array and add it to Firestore
    for (const user of jsonData) {
      await addDoc(usersCollection, user);
    }

    // Loop over each category in jsonDataloc (e.g., stations, parks_downtown)
    for (const category in jsonDataloc) {
      const locations = jsonDataloc[category];
      for (const locationName of locations) {
        // Create a location document with the name and category information
        await addDoc(locationsCollection, {
          name: locationName,
          category: category
        });
      }
    }

    console.log('Data uploaded successfully');
  } catch (error) {
    console.error('Error uploading data:', error);
  }
};

export default uploadDataToFirestore;
