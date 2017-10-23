import Bindable from 'utensils/bindable'

export default class BookingDropdown {
  constructor(el, data) {
    this.el = el;
    this.data = data ? data : this.el.data();
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }


// PROTECTED #

  addListeners() {
    this.el.bind('submit', this.formWasSubmitted);
  }

  removeListeners() {
    this.el.unbind('submit', this.formWasSubmitted);
  }

  formWasSubmitted(e) {
    e.preventDefault();
    const url = $(e.target).find('select').val();
    window.location.href = url;
  }
}

Bindable.register('booking-dropdown', BookingDropdown);
