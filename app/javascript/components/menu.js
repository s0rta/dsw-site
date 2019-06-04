import Bindable from 'utensils/bindable';

const BODY_MENU_CLASS = 'Body-menu-open';
const MENU_OPEN_CLASS = 'is-open';
const MENU_ID = '#menu-js';
const MENU_CLOSE_ID = '#menu-close-button-js';
const MENU_OPEN_ID = '#menu-open-button-js';
const MENU_OPEN_SECONDARY_NAV_ID = '#open-secondary-nav-js';
const MENU_CLOSE_SECONDARY_NAV_ID = '#close-secondary-nav-js';
const MENU_PRIMARY_NAV_ID = '#primary-nav-js';
const MENU_SECONDARY_NAV_SUFFIX_ID = 'secondary-nav-js';
const SITE_HEADER_ID = '#site-header-js';
const HEADER_MENU_CLASS = 'menu-open';

export default class Menu {
  constructor(el) {
    this.openMenu = this.openMenu.bind(this);
    this.closeMenu = this.closeMenu.bind(this);
    this.openSecondaryNavClick = this.openSecondaryNavClick.bind(this);
    this.openSecondaryNav = this.openSecondaryNav.bind(this);
    this.closeSecondaryNavClick = this.closeSecondaryNavClick.bind(this);

    this.initialize(el);
  }

  initialize(el) {
    this.addListeners();

    const startingNav = el.data().starting_nav;
    if (startingNav) {
      this.openSecondaryNav(startingNav);
    }
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
      .on('click', this.openSecondaryNavClick);

    $(document)
      .find(MENU_CLOSE_SECONDARY_NAV_ID)
      .on('click', this.closeSecondaryNavClick);
  }

  removeListeners() {}

  openMenu() {
    $(document)
      .find(MENU_ID)
      .addClass(MENU_OPEN_CLASS);
    $(document.body).addClass(BODY_MENU_CLASS);

    $(document)
      .find(SITE_HEADER_ID)
      .addClass(HEADER_MENU_CLASS);
  }

  closeMenu() {
    $(document)
      .find(MENU_ID)
      .removeClass(MENU_OPEN_CLASS);
    $(document.body).removeClass(BODY_MENU_CLASS);

    $(document)
      .find(SITE_HEADER_ID)
      .removeClass(HEADER_MENU_CLASS);
  }

  openSecondaryNavClick(event) {
    this.openSecondaryNav(event.target.dataset.menu);
  }

  openSecondaryNav(nav) {
    $(document)
      .find(MENU_PRIMARY_NAV_ID)
      .addClass('is-closed');

    $(document)
      .find(`#${nav}-${MENU_SECONDARY_NAV_SUFFIX_ID}`)
      .addClass('is-open');
  }

  closeSecondaryNavClick(event) {
    // have to use currentTarget here because of nested SVG in the button
    const secondaryNav = event.currentTarget.dataset.menu;
    $(document)
      .find(MENU_PRIMARY_NAV_ID)
      .removeClass('is-closed');

    $(document)
      .find(`#${secondaryNav}-${MENU_SECONDARY_NAV_SUFFIX_ID}`)
      .removeClass('is-open');
  }
}

Bindable.register('menu', Menu);
