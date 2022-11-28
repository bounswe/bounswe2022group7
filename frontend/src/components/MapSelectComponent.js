import React, { useRef, useMemo } from 'react'
import {
    MapContainer,
    TileLayer,
    Marker,
    Popup,
} from 'react-leaflet'

// map is not rendered properly unless we import this css
// https://stackoverflow.com/questions/40365440/react-leaflet-map-not-correctly-displayed
import 'leaflet/dist/leaflet.css'

// Handling the problem with marker being invisible
// ref: https://github.com/PaulLeCam/react-leaflet/issues/453#issuecomment-410450387
import L from 'leaflet';
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
    iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
    iconUrl: require('leaflet/dist/images/marker-icon.png'),
    shadowUrl: require('leaflet/dist/images/marker-shadow.png')
});

// Draggable Marker from Documentation
// ref: https://react-leaflet.js.org/docs/example-draggable-marker/  
function DraggableMarker(props) {

  let {position, setPosition} = props
  const markerRef = useRef(null)
  
  const eventHandlers = useMemo(
    () => ({
    dragend() {
      const marker = markerRef.current
      if (marker != null) {
      setPosition(marker.getLatLng())
      }
    },
  }), [])

  return (
    <Marker
      draggable={true}
      eventHandlers={eventHandlers}
      position={position}
      ref={markerRef}>
        <Popup>
          was is das
        </Popup>
    </Marker>
  )
}

export default function MapSelectComponent(props) {
  let {position, setPosition} = props

  return (
    // map style must be set
    // ref: https://github.com/PaulLeCam/react-leaflet/issues/108#issuecomment-436213422
    <MapContainer center={position} zoom={13} style={{ width: '100%', height: '600px' }} scrollWheelZoom={false}>
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      <DraggableMarker
        position={position}
        setPosition={setPosition}
      />

    </MapContainer>
  )
}