# Google Docs Clone

A full-stack Flutter application that replicates the core functionalities of Google Docs. This project utilizes Flutter for the frontend and Node.js with MongoDB for the backend.

## Features

- **Real-time Collaboration:** Leverages WebSockets for real-time editing and collaboration.
- **Authentication:** Uses JWT tokens for secure authentication and authorization.
- **Document Management:** Create, edit, and manage documents similar to Google Docs.
- **Persistent Storage:** Stores documents and user data in MongoDB.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Node.js](https://nodejs.org/en/download/)
- [MongoDB](https://www.mongodb.com/try/download/community)

### Installation

Follow these steps to get the application up and running:

1. **Clone the Repository:**

   Clone this repository to your local machine using Git.

   ```bash
   git clone https://github.com/your-username/google-docs-clone.git
   cd google-docs-clone
   ```

2. **Install Server Dependencies:**

   Navigate to the `server` directory and install the necessary dependencies using npm.

   ```bash
   cd server
   npm install
   ```

3. **Install Flutter Dependencies:**

   Navigate to the `client` directory and install the necessary Flutter packages.

   ```bash
   cd ../client
   flutter pub get
   ```

### Running the Application

To start the application, follow these steps:

1. **Start the Server:**

   Start the Node.js server by running the following command in the `server` directory:

   npm run dev

   The server will start and listen on port `3001` in the local environment.

2. **Run the Flutter App:**

   To run the Flutter web app in Chrome at port `3000`, use the following command in the `client` directory:

   flutter run -d chrome --web-port 3000

### Project Structure

The project is divided into two main parts:

- **client/** - Contains the Flutter frontend code.
- **server/** - Contains the Node.js backend code.

### Technologies Used

- **Frontend:** Flutter
- **Backend:** Node.js, Express, MongoDB, Mongoose, SocketIO
- **State Management:** Riverpod (for the Flutter client)
- **Authentication:** JWT (JSON Web Tokens)
- **Web Sockets:** Used for real-time collaboration

### Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch-name`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch-name`).
6. Open a pull request.

For major changes, please open an issue first to discuss what you would like to change.

### Contact

If you have any questions or suggestions, feel free to reach out:

- **Email:** [atyagiabhi210@gmail.com](atyagiabhi210@gmail.com)
- **LinkedIn:** [https://www.linkedin.com/in/abhishektyagi162/](https://www.linkedin.com/in/abhishektyagi162/)

---

Thank you for using Google Docs Clone! We hope you find it helpful and encourage you to contribute to the project.
