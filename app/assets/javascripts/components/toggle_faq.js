import Bindable from 'utensils/bindable'

export default class ToggleFaq {
  constructor(el) {
    this.el = el;
    this.$el = $(this.el);
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    return this.$el.find('.accordion').on('click', this.handleClick);
  }

  removeListeners() {
    this.$el.find('.accordion').off('click', this.handleClick);
  }

  handleClick(e) {
    e.preventDefault();
    $(e.currentTarget).toggleClass('active');
    const selector = $(e.currentTarget).next('.panel');
    return $(selector).toggleClass('show');
  }
};

Bindable.register('toggle-faq', ToggleFaq);
