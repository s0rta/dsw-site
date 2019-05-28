import Bindable from 'utensils/bindable';

const BODY_MENU_CLASS = 'Body-menu-open';
const MENU_OPEN_CLASS = 'is-open';
const MENU_ID = '#menu-js';
const MENU_CLOSE_ID = '#menu-close-button-js';
const MENU_OPEN_ID = '#menu-open-button-js';

export default class Menu {
  constructor() {
    this.addListeners();
    this.openMenu = this.openMenu.bind(this);
    this.closeMenu = this.closeMenu.bind(this);
  }

  addListeners() {
    $(document)
      .find(MENU_CLOSE_ID)
      .on('click', this.closeMenu);

    $(document)
      .find(MENU_OPEN_ID)
      .on('click', this.openMenu);
  }

  removeListeners() {}

  openMenu() {
    $(document)
      .find(MENU_ID)
      .addClass(MENU_OPEN_CLASS);
    $(document.body).addClass(BODY_MENU_CLASS);
  }

  closeMenu() {
    $(document)
      .find(MENU_ID)
      .removeClass(MENU_OPEN_CLASS);
    $(document.body).removeClass(BODY_MENU_CLASS);
  }

  dispose() {
    this.removeListeners();
  }
}

Bindable.register('menu', Menu);
