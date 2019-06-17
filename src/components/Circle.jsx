import React from 'react'

function Circle () {
  const randomSize = Math.floor(Math.random() * 100)
  const randomX = Math.floor(Math.random() * 1000)
  const randomY = Math.floor(Math.random() * 1000)

  const style = {
    position: 'absolute',
    top: randomX + 'px',
    right: randomY + 'px',
    height: randomSize + 'px',
    width: randomSize + 'px',
    borderRadius: '100%',
    backgroundColor: 'lightgreen',
    zIndex: '100'
  }
  return <div style={style} />
}

export default Circle