import Bindable from 'utensils/bindable';

export default class FloatingInput {
  constructor(el) {
    this.el = el;

    this.addFloat = this.addFloat.bind(this);
    this.handleBlur = this.handleBlur.bind(this);

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
    this.formField.on('blur', this.handleBlur);
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

  handleBlur() {
    if (!this.formField.val()) {
      this.label.removeClass('is-float');
    } else {
      this.addFloat();
    }
  }
}

Bindable.register('floating_input', FloatingInput);
