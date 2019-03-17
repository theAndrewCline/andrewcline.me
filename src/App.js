import React, { Component } from 'react'
import { GlobalStyle } from './components/GlobalStyle'
import { Title, Description, Page, SplashArt } from './components/BaseComponents'
import './App.css'

class App extends Component {
  render () {
    return (
      <div className='App'>
        <GlobalStyle />

        <Page>
          <SplashArt>
            <Title>Andrew Cline</Title>
            <Description>
              Javascript Developer from Peoria, IL.
            </Description>
          </SplashArt>

        </Page>
      </div>
    )
  }
}

export default App
