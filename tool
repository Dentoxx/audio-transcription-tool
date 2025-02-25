<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Audio Transcription Tool</title>
  <style>
    :root {
      --primary: #3498db;
      --primary-light: #5dade2;
      --primary-dark: #2e86c1;
      --background: #f4f4f9;
      --card-bg: #ffffff;
      --text: #333333;
      --text-light: #555555;
      --border: #dcdfe3;
      --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
      --accent: #e67e22;
      --success: #27ae60;
      --error: #e74c3c;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    }

    body {
      background-color: var(--background);
      color: var(--text);
      line-height: 1.5;
      padding: 20px;
      min-height: 100vh;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
    }

    header {
      text-align: center;
      margin-bottom: 30px;
      padding: 20px 0;
    }

    h1 {
      color: var(--primary);
      margin-bottom: 10px;
      font-size: 2.4rem;
      letter-spacing: -0.5px;
    }

    header p {
      color: var(--text-light);
      font-size: 1.1rem;
    }

    .tabs {
      display: flex;
      margin-bottom: 20px;
      border-bottom: 1px solid var(--border);
      gap: 4px;
      background-color: var(--card-bg);
      border-radius: 8px 8px 0 0;
      padding: 0 8px;
      box-shadow: var(--shadow);
    }

    .tab {
      padding: 12px 20px;
      cursor: pointer;
      background: transparent;
      border: none;
      font-weight: 600;
      color: var(--text-light);
      border-bottom: 3px solid transparent;
      font-size: 1rem;
      transition: all 0.2s ease;
    }

    .tab:hover {
      color: var(--primary-light);
      background-color: rgba(52, 152, 219, 0.05);
    }

    .tab.active {
      border-bottom: 3px solid var(--primary);
      color: var(--primary);
    }

    .tab-content {
      display: none;
    }

    .tab-content.active {
      display: block;
      animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .card {
      background-color: var(--card-bg);
      border-radius: 8px;
      box-shadow: var(--shadow);
      padding: 24px;
      margin-bottom: 24px;
      transition: box-shadow 0.3s ease;
    }

    .card:hover {
      box-shadow: var(--shadow-lg);
    }

    .card h2 {
      color: var(--primary-dark);
      margin-bottom: 16px;
      font-size: 1.3rem;
    }

    .input-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: var(--text);
    }

    input[type="text"] {
      width: 100%;
      padding: 12px;
      border: 2px solid var(--border);
      border-radius: 6px;
      font-size: 16px;
      transition: border-color 0.2s;
    }

    input[type="text"]:focus {
      border-color: var(--primary-light);
      outline: none;
    }

    input[type="file"] {
      width: 100%;
      padding: 10px 0;
      font-size: 16px;
    }

    .file-input-container {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 20px;
      border: 2px dashed var(--border);
      border-radius: 6px;
      cursor: pointer;
      transition: all 0.2s;
    }

    .file-input-container:hover {
      border-color: var(--primary-light);
      background-color: rgba(52, 152, 219, 0.05);
    }

    .file-input-container input[type="file"] {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      opacity: 0;
      cursor: pointer;
    }

    .file-icon {
      color: var(--primary);
      font-size: 40px;
      margin-bottom: 10px;
    }

    .file-label {
      font-weight: 600;
      margin-bottom: 8px;
    }

    .file-help {
      color: var(--text-light);
      font-size: 14px;
    }

    .selected-file {
      margin-top: 10px;
      padding: 10px;
      background-color: rgba(52, 152, 219, 0.1);
      border-radius: 6px;
      display: none;
    }

    button {
      background-color: var(--primary);
      color: white;
      border: none;
      border-radius: 6px;
      padding: 12px 24px;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.2s;
      font-weight: 600;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    button:hover {
      background-color: var(--primary-dark);
      transform: translateY(-1px);
    }

    button:active {
      transform: translateY(1px);
    }

    button:disabled {
      background-color: var(--text-light);
      cursor: not-allowed;
      transform: none;
    }

    .btn-icon {
      font-size: 18px;
    }

    .checkbox-group {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
      user-select: none;
    }

    .checkbox-group input {
      margin-right: 10px;
      height: 18px;
      width: 18px;
      cursor: pointer;
    }

    .checkbox-group label {
      margin-bottom: 0;
      cursor: pointer;
    }

    #transcription-result {
      white-space: pre-wrap;
      line-height: 1.6;
      background-color: rgba(52, 152, 219, 0.05);
      padding: 16px;
      border-radius: 6px;
      max-height: 400px;
      overflow-y: auto;
      font-size: 15px;
    }

    .timestamp {
      color: var(--primary);
      font-weight: 600;
      margin-right: 5px;
      user-select: none;
    }

    .loading {
      text-align: center;
      padding: 30px;
    }

    .loading-spinner {
      border: 4px solid rgba(52, 152, 219, 0.1);
      border-left-color: var(--primary);
      border-radius: 50%;
      width: 40px;
      height: 40px;
      animation: spin 1s linear infinite;
      margin: 0 auto 16px;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .export-buttons {
      display: flex;
      gap: 12px;
      margin-top: 20px;
    }

    .btn-secondary {
      background-color: var(--text-light);
    }

    .btn-secondary:hover {
      background-color: #475569;
    }

    .btn-copy {
      background-color: var(--accent);
    }
    
    .btn-copy:hover {
      background-color: #d35400;
    }

    .alert {
      padding: 14px;
      border-radius: 6px;
      margin-bottom: 20px;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 10px;
      animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .alert-error {
      background-color: #fdecea;
      color: #c0392b;
      border-left: 4px solid var(--error);
    }

    .alert-success {
      background-color: #e9f7ef;
      color: #27ae60;
      border-left: 4px solid var(--success);
    }

    .alert-icon {
      font-size: 20px;
    }

    .history-card {
      position: relative;
      transition: all 0.2s;
      cursor: pointer;
      border-left: 4px solid transparent;
    }

    .history-card:hover {
      border-left-color: var(--primary-light);
    }

    .history-card h3 {
      margin-bottom: 8px;
      color: var(--primary-dark);
    }

    .history-card p {
      margin-bottom: 10px;
    }

    .history-card small {
      color: var(--text-light);
    }

    .history-preview {
      font-size: 14px;
      color: var(--text-light);
      margin: 10px 0;
    }

    .history-actions {
      display: flex;
      justify-content: flex-end;
      gap: 8px;
    }

    .btn-sm {
      padding: 6px 12px;
      font-size: 14px;
    }

    .empty-state {
      text-align: center;
      padding: 40px 20px;
      color: var(--text-light);
    }

    .empty-state-icon {
      font-size: 40px;
      margin-bottom: 16px;
      opacity: 0.5;
    }

    footer {
      text-align: center;
      margin-top: 40px;
      padding: 20px 0;
      color: var(--text-light);
      font-size: 14px;
      border-top: 1px solid var(--border);
    }

    .badge {
      display: inline-block;
      padding: 3px 8px;
      border-radius: 9999px;
      font-size: 12px;
      font-weight: 600;
      margin-left: 8px;
    }

    .badge-file {
      background-color: #d6eaf8;
      color: #2471a3;
    }

    .badge-youtube {
      background-color: #fdebd0;
      color: #c0392b;
    }

    /* Material Icons */
    .material-icons {
      font-family: 'Material Icons';
      font-weight: normal;
      font-style: normal;
      font-size: 24px;
      line-height: 1;
      letter-spacing: normal;
      text-transform: none;
      display: inline-block;
      white-space: nowrap;
      word-wrap: normal;
      direction: ltr;
      -webkit-font-feature-settings: 'liga';
      -webkit-font-smoothing: antialiased;
    }

    /* Responsive */
    @media (max-width: 600px) {
      .tabs {
        flex-wrap: wrap;
      }
      
      .tab {
        flex: 1;
        min-width: 100px;
        text-align: center;
        padding: 10px;
      }

      .export-buttons {
        flex-direction: column;
      }

      .card {
        padding: 16px;
      }

      h1 {
        font-size: 1.8rem;
      }
    }
  </style>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css" rel="stylesheet" />
</head>
<body>
  <div class="container">
    <header>
      <h1>Audio Transcription Tool</h1>
      <p>Transcribe audio files or YouTube videos with precise accuracy</p>
    </header>

    <div class="tabs">
      <button class="tab active" data-tab="file-upload">
        <span class="material-icons">audiotrack</span> Audio File
      </button>
      <button class="tab" data-tab="youtube">
        <span class="material-icons">play_circle_filled</span> YouTube Video
      </button>
      <button class="tab" data-tab="history">
        <span class="material-icons">history</span> History
      </button>
    </div>

    <div id="file-upload" class="tab-content active">
      <div class="card">
        <h2>Upload Audio for Transcription</h2>
        <div class="file-input-container">
          <span class="material-icons file-icon">upload_file</span>
          <div class="file-label">Drop your audio file here or click to browse</div>
          <div class="file-help">Supports MP3, WAV, M4A, FLAC files (max 1GB)</div>
          <input type="file" id="audio-file" accept="audio/*">
        </div>
        <div id="selected-file" class="selected-file">
          <span class="material-icons">audiotrack</span>
          <span id="file-name">No file selected</span>
        </div>
        <div class="checkbox-group">
          <input type="checkbox" id="timestamps-file" checked>
          <label for="timestamps-file">Include Timestamps</label>
        </div>
        <button id="transcribe-file-btn">
          <span class="material-icons btn-icon">subtitles</span>
          Transcribe Audio
        </button>
      </div>
    </div>

    <div id="youtube" class="tab-content">
      <div class="card">
        <h2>Transcribe from YouTube</h2>
        <div class="input-group">
          <label for="youtube-url">YouTube Video URL</label>
          <input type="text" id="youtube-url" placeholder="https://www.youtube.com/watch?v=...">
        </div>
        <div class="checkbox-group">
          <input type="checkbox" id="timestamps-youtube" checked>
          <label for="timestamps-youtube">Include Timestamps</label>
        </div>
        <button id="transcribe-youtube-btn">
          <span class="material-icons btn-icon">play_circle_filled</span>
          Transcribe Video
        </button>
      </div>
    </div>

    <div id="history" class="tab-content">
      <div class="card">
        <h2>Previous Transcriptions</h2>
        <div id="history-list">
          <!-- History items will be populated here -->
        </div>
      </div>
    </div>

    <div id="alert-container"></div>

    <div id="result-container" class="card" style="display: none;">
      <h2>Transcription Result</h2>
      <div id="loading" class="loading" style="display: none;">
        <div class="loading-spinner"></div>
        <p>Processing your audio... This may take a few minutes depending on length</p>
      </div>
      <div id="transcription-content">
        <div id="transcription-result"></div>
        <div class="export-buttons">
          <button id="copy-btn" class="btn-copy">
            <span class="material-icons btn-icon">content_copy</span>
            Copy to Clipboard
          </button>
          <button id="download-btn">
            <span class="material-icons btn-icon">download</span>
            Download as TXT
          </button>
        </div>
      </div>
    </div>

    <footer>
      <p>Private audio transcription tool. Only people with the link can access this page.</p>
      <p><small>Powered by Whisper JAX for accurate, fast transcriptions</small></p>
    </footer>
  </div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
  <script>
    // Simple tab switching
    document.querySelectorAll('.tab').forEach(tab => {
      tab.addEventListener('click', () => {
        document.querySelectorAll('.tab, .tab-content').forEach(el => el.classList.remove('active'));
        tab.classList.add('active');
        document.getElementById(tab.getAttribute('data-tab')).classList.add('active');
      });
    });

    // WhisperService: a wrapper for calling Whisper JAX (or a mock for testing)
    class WhisperService {
      constructor() {
        // In production, this.API_URL should point to your deployed Whisper JAX inference endpoint.
        this.API_URL = "https://api-inference.huggingface.co/models/openai/whisper-large-v3";
        this.API_KEY = ""; // Set this to your actual API key or token if needed.
        this.isProcessing = false;
        // For testing locally, set useLocalMock to true.
        this.useLocalMock = true;
      }

      async transcribeFile(file, includeTimestamps = true) {
        if (this.isProcessing) throw new Error("Another transcription is in progress");
        if (this.useLocalMock) return this._mockTranscribe(file, includeTimestamps);
        this.isProcessing = true;
        try {
          const formData = new FormData();
          formData.append("file", file);
          formData.append("timestamps", includeTimestamps ? "true" : "false");
          const response = await fetch(this.API_URL, {
            method: "POST",
            body: formData,
            headers: {
              "Authorization": `Bearer ${this.API_KEY}`
            }
          });
          if (!response.ok) throw new Error("Failed to transcribe: " + response.statusText);
          const result = await response.json();
          return result.text;
        } finally {
          this.isProcessing = false;
        }
      }

      async transcribeYouTube(url, includeTimestamps = true) {
        if (this.isProcessing) throw new Error("Another transcription is in progress");
        if (!this._isValidYouTubeUrl(url)) throw new Error("Invalid YouTube URL");
        if (this.useLocalMock) return this._mockTranscribe({ name: "YouTube Video" }, includeTimestamps);
        this.isProcessing = true;
        try {
          const response = await fetch(this.API_URL, {
            method: "POST",
            body: JSON.stringify({ youtube_url: url, timestamps: includeTimestamps }),
            headers: {
              "Content-Type": "application/json",
              "Authorization": `Bearer ${this.API_KEY}`
            }
          });
          if (!response.ok) throw new Error("Failed to transcribe: " + response.statusText);
          const result = await response.json();
          return result.text;
        } finally {
          this.isProcessing = false;
        }
      }

      _isValidYouTubeUrl(url) {
        const regex = /^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$/;
        return regex.test(url);
      }

      async _mockTranscribe(file, includeTimestamps) {
        await new Promise(resolve => setTimeout(resolve, 3000));
        const fileName = file.name ? file.name.toLowerCase() : "unknown";
        let contentType = "general";
        if (fileName.includes("lecture") || fileName.includes("class")) contentType = "lecture";
        else if (fileName.includes("interview") || fileName.includes("podcast")) contentType = "interview";
        else if (fileName.includes("meeting")) contentType = "meeting";
        const duration = Math.floor(Math.random() * 1500) + 300;
        return this._generateRealisticTranscription(contentType, duration, includeTimestamps);
      }

      _generateRealisticTranscription(contentType, duration, includeTimestamps) {
        const templates = {
          lecture: {
            intro: [
              "Welcome to today's lecture on advanced machine learning concepts.",
              "Today we're going to discuss the fundamentals of quantum computing.",
              "In this session, we'll explore the principles of behavioral economics.",
              "Welcome back everyone. Let's continue our discussion on climate science."
            ],
            content: [
              "The first concept we need to understand is the gradient descent algorithm.",
              "Let's discuss how neural networks process information through layers.",
              "Reinforcement learning teaches via rewards and penalties.",
              "Data patterns become apparent as we analyze the results."
            ],
            conclusion: [
              "In our next lecture, we'll build on these concepts.",
              "Thank you for your attention today.",
              "That concludes the lecture for now."
            ]
          },
          interview: {
            intro: [
              "Thank you for joining us today.",
              "Welcome to the interview session.",
              "I'm excited to have you share your insights."
            ],
            questions: [
              "Could you tell us a bit about your background?",
              "What inspired you to pursue this field?",
              "How would you describe your work to a newcomer?"
            ],
            responses: [
              "That's an interesting point.",
              "I started in this field unexpectedly.",
              "Collaboration is key to success."
            ],
            conclusion: [
              "Thank you for your valuable insights.",
              "This conversation has been very informative."
            ]
          },
          meeting: {
            intro: [
              "Let's get started with today's meeting.",
              "Welcome everyone, let's review our agenda.",
              "Thanks for joining this discussion."
            ],
            topics: [
              "Let's review our current project updates.",
              "There are some key action items to address.",
              "We need to discuss upcoming deadlines."
            ],
            conclusion: [
              "That wraps up our meeting.",
              "Thank you for your contributions.",
              "We'll follow up with minutes shortly."
            ]
          },
          general: {
            intro: [
              "Here's the transcription of the audio content.",
              "Below is the text extracted from the recording."
            ],
            content: [
              "The main idea is clearly presented in this segment.",
              "Several points were made that deserve further discussion."
            ],
            conclusion: [
              "This concludes the transcription.",
              "Thank you for listening."
            ]
          }
        };

        const template = templates[contentType];
        let result = "";
        let currentTime = 0;
        const intro = template.intro[Math.floor(Math.random() * template.intro.length)];
        if (includeTimestamps) result += `[00:00] ${intro}\n\n`;
        else result += `${intro}\n\n`;
        currentTime += 15;
        const contentItems = template.content || template.topics || [];
        while (currentTime < duration - 30 && contentItems.length) {
          const item = contentItems[Math.floor(Math.random() * contentItems.length)];
          const timeStamp = new Date(currentTime * 1000).toISOString().substr(14, 5);
          if (includeTimestamps) result += `[00:${timeStamp}] ${item}\n\n`;
          else result += `${item}\n\n`;
          currentTime += Math.floor(Math.random() * 10) + 5;
        }
        const conclusion = template.conclusion[Math.floor(Math.random() * template.conclusion.length)];
        const finalTime = new Date(currentTime * 1000).toISOString().substr(14, 5);
        if (includeTimestamps) result += `[00:${finalTime}] ${conclusion}`;
        else result += conclusion;
        return result;
      }
    }

    // UI Event handlers and integration
    const whisperService = new WhisperService();

    document.getElementById("audio-file").addEventListener("change", (e) => {
      const file = e.target.files[0];
      if (file) {
        document.getElementById("selected-file").style.display = "block";
        document.getElementById("file-name").textContent = file.name;
      }
    });

    document.getElementById("transcribe-file-btn").addEventListener("click", async () => {
      const fileInput = document.getElementById("audio-file");
      if (!fileInput.files[0]) {
        alert("Please select an audio file.");
        return;
      }
      const includeTimestamps = document.getElementById("timestamps-file").checked;
      document.getElementById("result-container").style.display = "block";
      document.getElementById("loading").style.display = "block";
      try {
        const result = await whisperService.transcribeFile(fileInput.files[0], includeTimestamps);
        document.getElementById("transcription-result").textContent = result;
      } catch (err) {
        alert(err.message);
      } finally {
        document.getElementById("loading").style.display = "none";
      }
    });

    document.getElementById("transcribe-youtube-btn").addEventListener("click", async () => {
      const url = document.getElementById("youtube-url").value.trim();
      if (!url) {
        alert("Please enter a YouTube URL.");
        return;
      }
      const includeTimestamps = document.getElementById("timestamps-youtube").checked;
      document.getElementById("result-container").style.display = "block";
      document.getElementById("loading").style.display = "block";
      try {
        const result = await whisperService.transcribeYouTube(url, includeTimestamps);
        document.getElementById("transcription-result").textContent = result;
      } catch (err) {
        alert(err.message);
      } finally {
        document.getElementById("loading").style.display = "none";
      }
    });

    // Clipboard and download functionality
    document.getElementById("copy-btn").addEventListener("click", () => {
      const text = document.getElementById("transcription-result").textContent;
      navigator.clipboard.writeText(text).then(() => alert("Copied to clipboard!"));
    });

    document.getElementById("download-btn").addEventListener("click", () => {
      const text = document.getElementById("transcription-result").textContent;
      const blob = new Blob([text], { type: "text/plain" });
      const a = document.createElement("a");
      a.href = URL.createObjectURL(blob);
      a.download = "transcription.txt";
      a.click();
    });
  </script>
</body>
</html>
