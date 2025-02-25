import os
import tempfile
from fastapi import FastAPI, UploadFile, File, Form, HTTPException
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from whisper_jax import FlaxWhisperPipline
import jax.numpy as jnp
import yt_dlp

app = FastAPI()

# Enable CORS so that our GitHub Pages frontend can call this API.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, restrict this to your domain.
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize the Whisper JAX pipeline.
# Adjust the model name, dtype, and batch_size as needed for your hardware.
pipeline = FlaxWhisperPipline("openai/whisper-large-v2", dtype=jnp.bfloat16, batch_size=16)

def download_youtube_audio(url: str, output_template: str) -> str:
    """
    Downloads audio from a YouTube URL using yt_dlp.
    The file will be saved using the provided output_template.
    Returns the path to the downloaded file.
    """
    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': output_template,
        'noplaylist': True,
        'quiet': True,
    }
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([url])
    # yt_dlp appends the extension to the template. Look for common extensions:
    base, _ = os.path.splitext(output_template)
    for ext in ['.m4a', '.mp3', '.webm', '.wav', '.flac']:
        candidate = base + ext
        if os.path.exists(candidate):
            return candidate
    raise Exception("Downloaded audio file not found.")

@app.post("/transcribe")
async def transcribe_audio(
    youtube_url: str = Form(None),
    timestamps: bool = Form(True),
    file: UploadFile = File(None)
):
    """
    Accepts either an uploaded audio file or a YouTube URL.
    If a YouTube URL is provided, downloads the audio.
    Then transcribes the audio using Whisper JAX and returns the text.
    """
    if not youtube_url and not file:
        raise HTTPException(status_code=400, detail="Either a YouTube URL or an audio file must be provided.")
    
    audio_file_path = None

    if file:
        # Save the uploaded file to a temporary location.
        try:
            with tempfile.NamedTemporaryFile(delete=False, suffix=".mp3") as tmp:
                contents = await file.read()
                tmp.write(contents)
                audio_file_path = tmp.name
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error saving file: {e}")
    elif youtube_url:
        try:
            # Create a temporary directory to download the file.
            with tempfile.TemporaryDirectory() as tmpdirname:
                output_template = os.path.join(tmpdirname, "downloaded_audio.%(ext)s")
                downloaded_file = download_youtube_audio(youtube_url, output_template)
                # Copy the downloaded file to a persistent temporary file.
                with tempfile.NamedTemporaryFile(delete=False, suffix=os.path.splitext(downloaded_file)[1]) as tmp_file:
                    with open(downloaded_file, "rb") as src:
                        tmp_file.write(src.read())
                    audio_file_path = tmp_file.name
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error downloading YouTube audio: {e}")

    if not audio_file_path or not os.path.exists(audio_file_path):
        raise HTTPException(status_code=500, detail="Audio file not found after processing.")
    
    try:
        if timestamps:
            outputs = pipeline(audio_file_path, task="transcribe", return_timestamps=True)
            text = outputs["text"]
        else:
            text = pipeline(audio_file_path)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error during transcription: {e}")
    finally:
        # Clean up the temporary file.
        if audio_file_path and os.path.exists(audio_file_path):
            os.remove(audio_file_path)
    
    return JSONResponse(content={"text": text})

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
