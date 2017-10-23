import Bindable from 'utensils/bindable'
import throttle from 'lodash.throttle'

export default class AjaxLoadMore {
  constructor(el, data) {
    this.appendMore = this.appendMore.bind(this);
    this.handleScroll = this.handleScroll.bind(this);
    this.el = el;
    this.data = data ? data : this.el.data();
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.el.on('ajax:success', 'a.load-more', this.appendMore);
    this.throttledScroll = throttle(this.handleScroll, 250, { trailingEdge: false });
    $(window).on('scroll', this.throttledScroll);
  }

  removeListeners() {
    this.el.off('ajax:success', 'a.load-more', this.appendMore);
    $(window).off('scroll', this.throttledScroll);
  }

  appendMore(event, data) {
    this.el.before(data.fragment);
    this.el.find('a').attr('href', data.next_url);
    if (data.fragment.length === 0) { this.el.hide(); }
  }

  handleScroll(event) {
    if ($(window).scrollTop() > ($(document).height() - $(window).height() - 120)) {
      return $.ajax({url: this.el.find('a').attr('href'), dataType: 'json'}).then(json => this.appendMore(event,json));
    }
  }
}

Bindable.register('ajax-load-more', AjaxLoadMore)
