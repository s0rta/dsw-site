import Bindable from 'utensils/bindable';

export default class AjaxVoter {
  constructor(el, data) {
    this.el = el;
    this.data = data ? data : this.el.data();
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    this.el.on('ajax:success', 'a.register-vote-js', this.countVote);
  }

  removeListeners() {
    return this.el.off('ajax:success', 'a.register-vote-js', this.countVote);
  }

  countVote(event, data) {
    const a = $(event.target);
    const countEl = a.siblings('.vote-count-js');
    const noun = data.count === 1 ? 'vote' : 'votes';
    return countEl.html(`${data.count} ${noun}`);
  }
}

Bindable.register('ajax-voter', AjaxVoter);
