import QtQuick

// One image surface for still and animated wallpapers. Overlay playback
// pauses while it is closed; image dimensions follow the display surface.
Item {
  id: root

  property alias source: img.source
  property alias fillMode: img.fillMode
  property alias asynchronous: img.asynchronous
  property alias cache: img.cache
  property alias status: img.status
  property bool playing: true

  AnimatedImage {
    id: img
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
    asynchronous: true
    cache: true
    playing: root.playing
    paused: !root.playing
    speed: 1.0
    // AnimatedImage scales a frame to exactly sourceSize, with no aspect
    // correction, so a two-dimension sourceSize squashed a landscape
    // wallpaper on the portrait output; the fill mode had nothing left to
    // crop. Bind the height only: Qt derives the width from the source's
    // aspect ratio, and PreserveAspectCrop crops the overflow. An unhonored
    // binding degrades to the full-size load, which still renders correctly.
    sourceSize: Qt.size(-1, Math.max(1, Math.round(root.height)))
  }
}
