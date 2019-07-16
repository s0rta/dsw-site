import Bindable from 'utensils/bindable';

const ANIMATION_DURATION = 1000;
const OPEN_DURATION = 5000;

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
    setTimeout(() => {
      this.closeFlashMessage();
    }, OPEN_DURATION);
  }

  removeListeners() {
    this.el.off('click');
  }

  closeFlashMessage() {
    this.el.parents('.FlashMessage').addClass('is-closing');
    setTimeout(() => {
      this.hideFlashMessage();
    }, ANIMATION_DURATION);
  }

  hideFlashMessage() {
    this.el.parents('.FlashMessage').addClass('is-closed');
  }
}

Bindable.register('flash_message', FlashMessage);
