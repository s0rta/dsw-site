import Bindable from 'utensils/bindable';

export default class TextAreaAutosize {
  constructor(el) {
    this.el = el;

    this.handleEnterPressed = this.handleEnterPressed.bind(this);
    this.adjustRows = this.adjustRows.bind(this);
    this.addRow = this.addRow.bind(this);
    this.handlePaste = this.handlePaste.bind(this);

    this.initialize();
  }

  initialize() {
    this.adjustRows();
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.el.on('keydown', this.handleEnterPressed);
    this.el.on('paste', this.handlePaste);
  }

  handlePaste() {
    setTimeout(() => {
      this.adjustRows();
    });
  }

  adjustRows() {
    if (this.el[0].scrollHeight > this.el[0].offsetHeight) {
      this.addRow();
      this.adjustRows();
    }
  }

  handleEnterPressed(e) {
    if (e.key === 'Enter') {
      this.addRow();
    }
  }

  addRow() {
    this.el.attr('rows', this.el[0].rows + 1);
  }

  removeListeners() {
    this.el.off('keydown');
    this.el.off('paste');
  }
}

Bindable.register('text_area_autosize', TextAreaAutosize);
