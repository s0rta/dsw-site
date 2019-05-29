import Bindable from 'utensils/bindable';

const BODY_MENU_CLASS = 'Body-menu-open';
const MENU_OPEN_CLASS = 'is-open';
const MENU_ID = '#menu-js';
const MENU_CLOSE_ID = '#menu-close-button-js';
const MENU_OPEN_ID = '#menu-open-button-js';
const MENU_OPEN_SECONDARY_NAV_ID = '#open-secondary-nav-js';
const MENU_CLOSE_SECONDARY_NAV_ID = '#close-secondary-nav-js';
const MENU_PRIMARY_NAV_ID = '#primary-nav-js';
const MENU_SECONDAY_NAV_SUFFIX_ID = 'secondary-nav-js';

export default class Menu {
  constructor() {
    this.addListeners();
    this.openMenu = this.openMenu.bind(this);
    this.closeMenu = this.closeMenu.bind(this);
    this.openSecondaryNav = this.openSecondaryNav.bind(this);
    this.closeSecondaryNav = this.closeSecondaryNav.bind(this);
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    $(document)
      .find(MENU_CLOSE_ID)
      .on('click', this.closeMenu);

    $(document)
      .find(MENU_OPEN_ID)
      .on('click', this.openMenu);

    $(document)
      .find(MENU_OPEN_SECONDARY_NAV_ID)
      .on('click', this.openSecondaryNav);

    $(document)
      .find(MENU_CLOSE_SECONDARY_NAV_ID)
      .on('click', this.closeSecondaryNav);
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

  openSecondaryNav(event) {
    const secondaryNav = event.target.dataset.menu;
    $(document)
      .find(MENU_PRIMARY_NAV_ID)
      .addClass('is-closed');

    $(document)
      .find(`#${secondaryNav}-${MENU_SECONDAY_NAV_SUFFIX_ID}`)
      .addClass('is-open');
  }

  closeSecondaryNav(event) {
    // have to use currentTarget here because of nested SVG in the button
    const secondaryNav = event.currentTarget.dataset.menu;
    $(document)
      .find(MENU_PRIMARY_NAV_ID)
      .removeClass('is-closed');

    $(document)
      .find(`#${secondaryNav}-${MENU_SECONDAY_NAV_SUFFIX_ID}`)
      .removeClass('is-open');
  }
}

Bindable.register('menu', Menu);
