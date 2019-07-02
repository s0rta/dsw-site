import Bindable from 'utensils/bindable';
import Awesomplete from 'awesomplete';

export default class Autocompleter {
  constructor(el, data) {
    this.el = el;
    this.data = data ? data : this.el.data();
    this.replaceOverride = this.replaceOverride.bind(this);
    this.awesomplete = new Awesomplete(this.el[0], {
      minChars: 1,
      autoFirst: true
    });

    if (this.data.valuefield) {
      this.awesomplete.replace = this.replaceOverride;
    }

    this.addListeners();
  }

  replaceOverride(suggestion) {
    this.awesomplete.input.value = suggestion.label;
    const valueInput = document.getElementById(this.data.valuefield);
    valueInput.value = suggestion.value;
  }

  dispose() {
    this.removeListeners();
    this.awesomplete.destroy();
  }

  addListeners() {
    this.el.on('keyup', () => {
      $.ajax({
        url: this.data.source,
        data: { term: this.value },
        type: 'GET',
        dataType: 'json'
      }).done(data => {
        this.awesomplete.list = data.results;
      });
    });
  }

  removeListeners() {
    this.el.off('keyup');
  }
}

Bindable.register('autocompleter', Autocompleter);
