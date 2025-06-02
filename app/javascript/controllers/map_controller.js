import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    users: Array,
    mapboxApiKey: String
  }

  connect() {
    if (!this.mapboxApiKeyValue) {
      console.error("Mapbox API key is missing.")
      return
    }

    mapboxgl.accessToken = this.mapboxApiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: [0, 0],
      zoom: 1
    })

    if (!this.usersValue || this.usersValue.length === 0) {
      console.warn("No users with geocoded data found.")
      return
    }

    this.addMarkers(this.usersValue)
    this.fitMapToMarkers(this.usersValue)
  }

  addMarkers(users) {
    users.forEach(user => {
      const popup = new mapboxgl.Popup().setHTML(`
        <strong>${user.full_name}</strong><br />
        ${user.location}
      `)

      new mapboxgl.Marker()
        .setLngLat([user.lng, user.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  fitMapToMarkers(users) {
    const bounds = new mapboxgl.LngLatBounds()

    users.forEach(user => {
      bounds.extend([user.lng, user.lat])
    })

    this.map.fitBounds(bounds, {
      padding: 70,
      maxZoom: 12,
      duration: 1000
    })
  }
}
