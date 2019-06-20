import Bindable from 'utensils/bindable';

const DEFAULT_UPLOAD_SIZE = 2097152; // 2mb
const BYTES_IN_MB = 1000000;

export default class ShowFileSize {
  constructor(el) {
    this.el = el;
    this.input = this.el[0];

    this.onFileChange = this.onFileChange.bind(this);
    this.hasFileReader = this.hasFileReader.bind(this);
    this.validInputFiles = this.validInputFiles.bind(this);
    this.validFileSize = this.validFileSize.bind(this);
    this.validFileType = this.validFileType.bind(this);
    this.displayFilename = this.displayFilename.bind(this);

    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    return this.el.change(this.onFileChange);
  }

  removeListeners() {
    this.el.off('change');
  }

  onFileChange() {
    if (!this.hasFileReader()) return;

    if (!this.validInputFiles()) return;

    if (!this.validFileSize()) return;

    if (!this.validFileType()) return;

    this.displayFilename();
  }

  hasFileReader() {
    if (!window.FileReader) {
      alert("The file API isn't supported on this browser yet.");
      return false;
    }
    return true;
  }

  validInputFiles() {
    if (!this.input.files) {
      alert(
        "This browser doesn't seem to support the `files` property of file inputs."
      );
      return false;
    }
    return true;
  }

  validFileSize() {
    const file = this.input.files[0];
    if (file.size > DEFAULT_UPLOAD_SIZE) {
      alert(this.getSizeError(DEFAULT_UPLOAD_SIZE));
      return false;
    }
    return true;
  }

  validFileType() {
    const file = this.input.files[0];
    if (!file.type.match('image*')) {
      this.input.value = null;
      alert('Only images are supported');
      return false;
    }
    return true;
  }

  displayFilename() {
    const file = this.input.files[0];
    const nameElement = document.getElementById('file-select-name-js');
    nameElement.innerHTML = file.name;
  }

  removeFilename() {
    const nameElement = document.getElementById('file-select-name-js');
    nameElement.innerHTML = '';
  }

  getSizeError(sizeInBytes) {
    return `File size is more than ${parseInt(sizeInBytes / BYTES_IN_MB)} mb!`;
  }
}

Bindable.register('showfilesize', ShowFileSize);
