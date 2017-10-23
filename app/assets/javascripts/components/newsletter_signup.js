import Bindable from 'utensils/bindable'

export default class NewsletterSignup {
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
    const email = this.el.find("input[type='text']").val();
    if (!email) {
      return this.button.val('Please supply a valid e-mail address.');
    } else {
      return $.ajax({
        url: this.el.attr('action'),
        type: 'POST',
        dataType: 'json',
        data: {
          newsletter_signup: {
            email
          }
        },
        success: () => {
          this.button.val('Thanks! You are signed up for updates.');
          this.button.prop('disabled', true);
        },
        error: () => {
          this.button.val('An error occurred - please try again later!');
        }
      });
    }
  }
};

Bindable.register('newsletter-signup', NewsletterSignup);
