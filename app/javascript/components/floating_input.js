import Bindable from 'utensils/bindable';

export default class FloatingInput {
  constructor(el) {
    this.el = el;

    this.addFloat = this.addFloat.bind(this);
    this.removeFloat = this.removeFloat.bind(this);

    this.label = el.children('label');
    this.initialize();
  }

  initialize() {
    this.setFormField();
    this.setInitialFloat();
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.formField.on('focus', this.addFloat);
    this.formField.on('blur', this.removeFloat);
  }

  removeListeners() {
    this.formField.off('focus');
    this.formField.off('blur');
  }

  setFormField() {
    const input = this.el.children('input');
    const select = this.el.children('select');

    if (input.length) {
      this.formField = input;
    }

    if (select.length) {
      this.formField = select;
    }
  }

  setInitialFloat() {
    if (this.formField.val()) {
      this.addFloat();
    }
  }

  addFloat() {
    this.label.addClass('is-float');
  }

  removeFloat() {
    if (!this.formField.val()) {
      this.label.removeClass('is-float');
    }
  }
}

Bindable.register('floating_input', FloatingInput);
