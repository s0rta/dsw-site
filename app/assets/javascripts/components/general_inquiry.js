import Bindable from 'utensils/bindable'

export default class GeneralInquiry {
  constructor(el, data) {
    this.formWasSubmitted = this.formWasSubmitted.bind(this);
    this.el = el;
    this.data = data ? data : this.el.data();
    this.button = this.el.find('input[type="submit"]');
    this.addListeners();
  }

  dispose() {
    return this.removeListeners();
  }

  addListeners() {
    return this.el.bind('submit', this.formWasSubmitted);
  }

  removeListeners() {
    return this.el.unbind('submit', this.formWasSubmitted);
  }

  formWasSubmitted(e) {
    e.preventDefault();
    const email = this.el.find("#general_inquiry_contact_email").val();
    const name = this.el.find("#general_inquiry_contact_name").val();
    const interest = this.el.find("#general_inquiry_interest").val();
    const notes = this.el.find("#general_inquiry_notes").val();
    if (!email || !name) {
      return this.button.val('Please supply your name and e-mail address.');
    } else {
      return $.ajax({
        url: this.el.attr('action'),
        type: 'POST',
        dataType: 'json',
        data: {
          general_inquiry: {
            contact_email: email,
            contact_name: name,
            interest,
            notes
          }
        },
        success: () => {
          this.button.val('Thanks! We will be in touch shortly');
          return this.button.prop('disabled', true);
        },
        error: () => {
          return this.button.val('An error occurred - please try again later!');
        }
      });
    }
  }
};

Bindable.register('general-inquiry', GeneralInquiry);
