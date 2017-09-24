#= require utensils/bindable
#= require ./dsw

class dsw.ScheduleMap
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()


  initialize: =>
    @map = L.map(@el[0], {
      layers: MQ.lightLayer()
    })

    addItem = (item) =>
      MQ.geocode({ map: @map })
        .search(item.address)
      MQ.geocode().search(item.address).on 'success', (e) =>
        best = e.result.best
        latlng = best.latlng
        # @map.setView(latlng, 14)
        L.marker([ latlng.lat, latlng.lng ])
          .addTo(@map)
          .bindPopup("<a href='#{item.link}'>#{item.title}</a><br /><em>#{item.venue_name}</em><br />#{item.address}")
          .openPopup()
    addItem(item) for item in @data.items

utensils.Bindable.register 'schedule-map', dsw.ScheduleMap
