import Bindable from 'utensils/bindable';
import throttle from 'lodash.throttle';

// From David Walsh: https://davidwalsh.name/javascript-debounce-function
function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this,
      args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
}

export default class AjaxLoadMore {
  constructor(el, data) {
    this.appendMore = this.appendMore.bind(this);
    this.handleScroll = debounce(this.handleScroll.bind(this), 1000, true);
    this.el = el;
    this.data = data ? data : this.el.data();
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.el.on('ajax:success', 'a#load-more', this.appendMore);
    this.throttledScroll = throttle(this.handleScroll, 250, {
      trailingEdge: false
    });
    $(window).on('scroll', this.throttledScroll);
  }

  removeListeners() {
    this.el.off('ajax:success', 'a#load-more', this.appendMore);
    $(window).off('scroll', this.throttledScroll);
  }

  appendMore(event, data) {
    $(document)
      .find('#' + this.data.target)
      .append(data.fragment);
    this.el.find('a').attr('href', data.next_url);

    if (data.fragment.length === 0 || data.last_page) {
      this.el.hide();
    }
  }

  handleScroll(event) {
    if (
      $(window).scrollTop() >
      $(document).height() - $(window).height() - 120
    ) {
      return $.ajax({
        url: this.el.find('a').attr('href'),
        dataType: 'json'
      }).then(json => this.appendMore(event, json));
    }
  }
}

Bindable.register('ajax-load-more', AjaxLoadMore);
