import React, { Component } from 'react'
import { GlobalStyle } from './components/GlobalStyle'
import { Title, Description, Page, SplashArt } from './components/BaseComponents'
import Circle from './components/Circle'
import './App.css'

class App extends Component {
  constructor () {
    super()
    this.randomCircles = this.randomCircles.bind(this)
  }
  state = {
    numberOfCircles: []
  }
  randomCircles () {
    const randomNumber = Math.floor(Math.random() * 20)
    let numberOfCircles = []
    for (let i = 0;i < randomNumber;i++) {
      numberOfCircles.push(1)
    }
    this.setState({ numberOfCircles })
  }

  componentDidMount () {
    this.randomCircles()
  }
  render () {
    return (
      <div className='App'>
        <GlobalStyle />

        <Page onClick={() => this.randomCircles()}>
          <SplashArt>
            <Title>Andrew Cline</Title>
            <Description>
              Javascript Developer from Peoria, IL.
            </Description>
            {this.state.numberOfCircles.map((number, i) => {
              return <Circle key={i}></Circle>
            })}
          </SplashArt>
        </Page>
      </div>
    )
  }
}

export default App
