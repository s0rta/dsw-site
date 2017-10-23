class Bindable {
  constructor(context, dataKey){
    if (context == null) { context = document; }
    if (dataKey == null) { dataKey = 'bindable'; }
    this.bindables = []
    this.dataKey = dataKey;
    this.context = context;
    this.instanceKey = `${this.dataKey}-instance`;
  }


  bindableElements() {
    return $(`[data-${this.dataKey}]`, this.context);
  }

  bindAll() {
    for (let el of Array.from(this.bindableElements())) { this.bind(el); }
    return this;
  }


  getRefs() {
    return Array.from(this.bindables).map((bindable) => $(bindable).data(this.instanceKey));
  }


  dispose() {
    for (let bindable of Array.from(this.bindables)) {
      var instance;
      bindable = $(bindable);
      if (instance = bindable.data(this.instanceKey)) {
        if (typeof (instance != null ? instance.release : undefined) === 'function') { instance.release(); }
        if (typeof (instance != null ? instance.dispose : undefined) === 'function') { instance.dispose(); }
        bindable.data(this.instanceKey, null);
      }
    }

    delete this.bindables;
    this.bindables = [];
    return this;
  }


  // Marked for Deprecation
  release() {
    return this.dispose();
  }


  bind(el, dataKey) {
    let _class;
    if (dataKey == null) { ({ dataKey } = this); }
    el = $(el);
    const key = el.data(dataKey);
    if (_class = this.getClass(key)) {
      if (!el.data(this.instanceKey)) { return el.data(this.instanceKey, new _class(el)); }
    } else {
      return (typeof console !== 'undefined' && console !== null ? console.error(`Bindable for key: ${key} not found in Bindable.registry for instance`, el) : undefined);
    }
  }

  getClass(key) {
    return (this.registry[key] != null ? this.registry[key].class : undefined);
  }


  register(key, klass) {
    if (this.registry == null) { this.registry = {}; }
    this.registry[key] = {class: klass};
    return null;
  }
};

export { Bindable }

const bindable = new Bindable()

export default bindable
