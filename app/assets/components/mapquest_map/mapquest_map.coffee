#= require utensils/bindable
#= require components/dsw

class dsw.MapquestMap
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()


  initialize: =>
    @map = L.map(@el[0], {
      layers: MQ.mapLayer()
    })

    MQ.geocode({ map: @map })
      .search(@data.address)
    MQ.geocode().search(@data.address).on 'success', (e) =>
      best = e.result.best
      latlng = best.latlng
      @map.setView(latlng, 14)
      L.marker([ latlng.lat, latlng.lng ])
        .addTo(@map)
        .bindPopup("<strong>#{@data.name}</strong><br />#{@data.address}")
        .openPopup()

utensils.Bindable.register 'mapquest-map', dsw.MapquestMap
