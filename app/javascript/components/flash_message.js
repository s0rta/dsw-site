import Bindable from 'utensils/bindable';

export default class FlashMessage {
  constructor(el) {
    this.el = el;

    this.closeFlashMessage = this.closeFlashMessage.bind(this);

    this.initialize();
  }

  initialize() {
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.el.on('click', this.closeFlashMessage);
  }

  removeListeners() {
    this.el.off('click');
  }

  closeFlashMessage() {
    this.el.parents('.FlashMessage').addClass('is-closed');
  }
}

Bindable.register('flash_message', FlashMessage);
