import { DirectUpload } from '@rails/activestorage';

export default class Uploader {
  constructor(file, input, form) {
    const { dataset: { directUploadUrl } } = input;

    this.directUpload = new DirectUpload(file, directUploadUrl, this);
    this.targetForm = form;
    this.file = file;
    this.input = input;
  }

  start() {
    this.directUpload.create((error, blob) => {
      if (error) {
        console.log(error);
      } else {
        createHiddenBlobInput(blob, this.input, this.targetForm);
      }
    });
  }
}

const createHiddenBlobInput = (blob, input, form) => {
  const hiddenField = document.createElement('input');
  hiddenField.setAttribute('type', 'hidden');
  hiddenField.setAttribute('value', blob.signed_id);
  hiddenField.name = input.name;
  form.appendChild(hiddenField);
};