import Bindable from 'utensils/bindable'

export default class MapquestMap {
  constructor(el, data) {
    this.el = el;
    this.data = data ? data : this.el.data();
    this.initialize();
  }

  initialize() {
    this.map = L.map(this.el[0], {
      layers: MQ.mapLayer()
    });

    MQ.geocode({ map: this.map })
      .search(this.data.address);
    MQ.geocode().search(this.data.address).on('success', e => {
      const { best } = e.result;
      const { latlng } = best;
      this.map.setView(latlng, 14);
      L.marker([ latlng.lat, latlng.lng ])
        .addTo(this.map)
        .bindPopup(`<strong>${this.data.name}</strong><br />${this.data.address}`)
        .openPopup();
    });
  }
};

Bindable.register('mapquest-map', MapquestMap);
