import { db } from './firebase';
import { collection, addDoc } from 'firebase/firestore';
import jsonData from './sample.json';

const uploadDataToFirestore = async () => {
  try {
    const usersCollection = collection(db, 'users'); // Adjust collection name if needed

    // Loop over each item in the JSON data array and add it to Firestore
    for (const user of jsonData) {
      await addDoc(usersCollection, user);
    }

    console.log('Data uploaded successfully');
  } catch (error) {
    console.error('Error uploading data:', error);
  }
};

export default uploadDataToFirestore;
