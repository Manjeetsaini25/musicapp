# 🎵 MusicApp

A full-stack music streaming application based on MVVM architecture and built with **Flutter** and a **Python (FastAPI)** backend. Users can stream music in real-time, search for songs, manage playlists, and enjoy a clean UI/UX experience.

---

## 🚀 Features

- 🔐 User Authentication & Signup
- 🎧 Real-time music streaming
- 🎧 Upload song
- 📂 Playlist creation and management
- 🌐 Fast and responsive Flutter UI
- 🗄️ Backend API with database integration
- ☁️ Media hosting using Cloudinary

---

## 🛠️ Technologies Used

### 📱 Frontend (Mobile/Desktop)
- **Flutter**
- **Riverpod & Provider** for state management
- **audio_service** for background audio playback

### 🧠 Backend
- **Python FastAPI**
- **PostgreSQL**
- **Cloudinary**
- **python-dotenv**


Steps to run this application :
### 🧾 Clone the repository

```bash
git clone https://github.com/Manjeetsaini25/musicapp.git
cd musicapp

⚙️ Setup the Backend (FastAPI)

Step 1: Move to the backend directory
    cd server
    Step 2: activate virtual environment
    venv/bin/activate
    Step 3: Install dependencies
    pip install -r requirements.txt
    Step 4: Create .env file
    cp .env.example .env
    Edit .env and add:
    API_KEY=your_api_key
    DB_URL=postgresql://username:password@localhost:5432/musicdb
    CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name
    Step 5: Run the backend server
    uvicorn main:app --reload
    The server runs at: http://127.0.0.1:8000

📱 Setup the Flutter App
    cd client
    flutter pub get
    flutter run

