Audio Transcription Tool
A full-stack application that uses Whisper JAX to transcribe audio files and YouTube videos. The project features a clean, responsive front end served via GitHub Pages and a Python-based backend (using FastAPI) that handles real transcription tasks with Whisper JAX.

Features
Audio File Transcription: Upload audio files (MP3, WAV, M4A, FLAC) and get accurate transcriptions.
YouTube Video Transcription: Provide a YouTube URL, and the backend will extract the audio using yt-dlp and transcribe it.
Timestamps Support: Option to include timestamps in the transcription.
Modern UI: Simple, clean, and responsive interface.
API Integration: A FastAPI backend that leverages Whisper JAX for fast and accurate transcriptions.
Repository Structure
perl
Copy
my-transcription-tool/
├── backend/
│   ├── main.py             # FastAPI backend code using Whisper JAX
│   └── requirements.txt    # Python dependencies for the backend
└── frontend/
    └── index.html          # Front end code served via GitHub Pages
Prerequisites
Backend
Python 3.9+
A machine with sufficient compute (GPU/TPU recommended) to run Whisper JAX.
JAX and jaxlib installed.
Required Python packages (see backend/requirements.txt).
yt-dlp for YouTube audio extraction.
Whisper JAX installed via pip:
bash
Copy
pip install git+https://github.com/sanchit-gandhi/whisper-jax.git
Frontend
A modern web browser.
Static hosting (GitHub Pages is recommended).
Installation and Deployment
Setting Up the Backend
Clone the Repository & Navigate:

bash
Copy
git clone https://github.com/yourusername/my-transcription-tool.git
cd my-transcription-tool/backend
Install Dependencies:

bash
Copy
pip install -r requirements.txt
Run the Server Locally:

bash
Copy
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
Your backend API will be available at http://localhost:8000/transcribe.

Deploying to Production:

Deploy the backend to your preferred cloud provider (AWS, GCP, etc.) or a VPS.
Ensure the public URL (e.g., https://yourbackend.example.com/transcribe) is accessible.
Update the API_URL in the frontend code accordingly.
Setting Up the Frontend (GitHub Pages)
Prepare Your Frontend:

Navigate to the frontend directory.
Ensure the file is named index.html.
Push to GitHub:

Create a new GitHub repository (or use an existing one) and push the contents of the frontend folder.
Enable GitHub Pages:

Go to your repository's Settings.
Scroll down to the Pages section.
Select the branch (typically main) and the root (/) folder.
Click Save. GitHub will provide a URL like https://yourusername.github.io/your-repo-name.
Update API Endpoint:

In index.html, update the API_URL variable in the JavaScript section to point to your deployed backend endpoint (e.g., https://yourbackend.example.com/transcribe).
How to Use
Access the Frontend:

Open the GitHub Pages URL in your browser.
Transcribing Audio Files:

Click the "Audio File" tab.
Upload an audio file.
Choose whether to include timestamps and click "Transcribe Audio".
The transcription result will be displayed with options to copy or download the text.
Transcribing YouTube Videos:

Click the "YouTube Video" tab.
Enter a YouTube video URL.
Choose whether to include timestamps and click "Transcribe Video".
The backend will extract the audio from the video, transcribe it, and display the result.
Customization
UI Customization: Modify frontend/index.html to adjust styles or add features.
Backend Enhancements: Update backend/main.py to adjust the transcription process, model parameters, or add new endpoints.
Security: For production, consider adding proper authentication to your API and securing access to your backend.
Contributing
Feel free to fork the repository and submit pull requests for improvements or bug fixes. For major changes, please open an issue first to discuss what you would like to change.

License
This project is licensed under the MIT License.
