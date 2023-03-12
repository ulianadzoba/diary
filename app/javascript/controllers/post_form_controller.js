import { Controller } from "@hotwired/stimulus";
import Uploader from '../utils/direct_uploader';

export default class extends Controller {
  static targets = ['audioInput', 'recordButton', 'audioPreview'];

  connect() {
    this.audio();
  }

  audioPreview() {
    this.clearAudioPreview();
    let file = this.audioInputTarget.files[0];
    const reader = new FileReader();
    this.createAudioFilePreview(file, reader);
  }

  createAudioFilePreview(file, reader) {
    reader.onload = () => {
      let element = this.constructAudioPreview(file, reader);
      element.src = reader.result;

      element.setAttribute('href', reader.result);
      element.setAttribute('target', '_blank');
      element.classList.add('audio-preview');

      this.audioPreviewTarget.appendChild(element);
    };
    
    reader.readAsDataURL(file);
  }

  constructAudioPreview(file, reader) {
    let cancelFunction = (e) => this.removeAudioPreview(e);
    let cancelUploadButton, element, wrapper;
    wrapper = document.createElement('div');
    wrapper.classList.add('flex', 'items-top');
    
    element = document.createElement('i');
    element.classList.add('bi', 'text-2xl', 'bi-file-earmark-music-fill');
    
    cancelUploadButton = document.createElement('i');
    cancelUploadButton.classList.add('bi', 'text-sm', 'bi-x-circle-fill', 'cursor-pointer');
    cancelUploadButton.onclick = cancelFunction;
    
    wrapper.appendChild(element)
    wrapper.appendChild(cancelUploadButton);
    wrapper.dataset.filename = file.name;

    return wrapper;
  }

  removeAudioPreview(event) {
    let fileInput = this.audioInputTarget;
    let hiddenInputField = this.element.querySelector("input[name='post[audio]'][type='hidden']");

    const dataTransfer = new DataTransfer();
    fileInput.files = dataTransfer.files;

    this.audioPreviewTarget.removeChild(this.audioPreviewTarget.firstChild)
    this.element.removeChild(hiddenInputField);
  }

  clearAudioPreview() {
    this.audioPreviewTarget.innerHTML = '';
  }

  audio() {
    let recordButton = this.recordButtonTarget;
    let audioInput = this.audioInputTarget;
    let form = this.element;
    let recording = false;

    if (navigator.mediaDevices.getUserMedia) {
      const constraints = { audio: true };
      let chunks = [];

      let onSuccess = function (stream) {
        const mediaRecorder = new MediaRecorder(stream);

        recordButton.onclick = function (event) {
          event.preventDefault();
          if (recording) {
            mediaRecorder.stop();
            recordButton.style.color = '';
          } else {
            mediaRecorder.start();
            recordButton.style.color = 'red';
          }
          recording = !recording;
        };

        mediaRecorder.onstop = function (event) {
          const audioType = 'audio/ogg';
          const blob = new Blob(chunks, { type: audioType });
          chunks = [];

          let file = new File([blob], 'audio-message.ogg', {
            type: audioType,
            lastModified: new Date().getTime(),
          });

          let container = new DataTransfer();
          container.items.add(file);
          
          const upload = new Uploader(file, audioInput, form);
          upload.start();
          
          audioInput.files = container.files;
          audioInput.dispatchEvent(new Event('change'));
        };

        mediaRecorder.ondataavailable = function (e) {
          chunks.push(e.data);
        };
      };

      let onError = function (err) {
        console.log('The following error occured: ' + err);
      };

      navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);
    } else {
      console.log('getUserMedia is not supported on your browser!');
    }
  }
}
