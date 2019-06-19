import Bindable from "utensils/bindable";

export default class ToggleAccordion {
  constructor(el) {
    this.el = el;
    this.$el = $(this.el);
    this.addListeners();
  }

  dispose() {
    this.removeListeners();
  }

  addListeners() {
    return this.$el
      .find(".AccordionListItem-accordion")
      .on("click", this.handleClick);
  }

  removeListeners() {
    this.$el
      .find(".AccordionListItem-accordion")
      .off("click", this.handleClick);
  }

  handleClick(e) {
    e.preventDefault();
    $(e.currentTarget).toggleClass("active");
    const selector = $(e.currentTarget).next(".AccordionListItem-panel");
    return $(selector).toggleClass("show");
  }
}

Bindable.register("toggle-accordion", ToggleAccordion);
