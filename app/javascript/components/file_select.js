import Bindable from 'utensils/bindable';

export default class ShowFileSize {
  constructor(el) {
    this.el = el;
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    return this.el.change(this.checkFileSize);
  }

  removeListeners() {
    this.el.off('change');
  }

  checkFileSize() {
    var input, file;

    if (!window.FileReader) {
      alert("The file API isn't supported on this browser yet.");
      return;
    }

    input = document.getElementById('user_avatar');
    if (!input) {
      alert("Um, couldn't find the fileinput element.");
    } else if (!input.files) {
      alert(
        "This browser doesn't seem to support the `files` property of file inputs."
      );
    } else if (input.files[0]) {
      file = input.files[0];
      if (file.size > 2097152) {
        input.value = null;
        alert('File  size is more than 2 mb!');
      }
      if (!file.type.match('image*')) {
        input.value = null;
        alert('Only images are supported');
      }

      const nameElement = document.getElementById('file-select-name-js');
      nameElement.innerHTML = file.name;
    }
  }
}

Bindable.register('showfilesize', ShowFileSize);
