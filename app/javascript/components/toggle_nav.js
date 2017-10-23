import Bindable from 'utensils/bindable'

export default class ToggleNav {
  constructor(el) {
    this.handleScroll = this.handleScroll.bind(this);
    this.el = el;
    this.$el = $(this.el);
    this.addListeners();
    this.handleScroll();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.$el.find('#menu-icon').on('click', this.handleClick);
    this.$el.find('.close').on('click', this.close);
    $(window).on('scroll', this.handleScroll);
  }

  removeListeners() {
    this.$el.find('#menu-icon').off('click', this.handleClick);
    this.$el.find('.close').off('click', this.close);
    $(window).off('scroll', this.handleScroll);
  }

  handleScroll() {
    if (window.scrollY >= 10) {
      return this.$el.addClass('shrink');
    } else {
      return this.$el.removeClass('shrink');
    }
  }

  handleClick() {
    return $('.outer-modal-container').toggleClass('nav-open');
  }


  close() {
    return $('.outer-modal-container').removeClass('nav-open');
  }
}

Bindable.register('toggle-nav', ToggleNav);
