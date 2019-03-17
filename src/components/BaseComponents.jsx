import styled from 'styled-components'

export const Page = styled.div`
  background: linear-gradient(to right, #673ab7, #3f51b5, #2196f3, #00bcd4, #009688);
  min-height: 100vh;
  color: white;
`

export const SplashArt = styled.div`
  background: #212121;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
  color: white;
  clip-path: polygon(0% 0%, 100% 10%, 100% 100%, 0% 75%);
  filter: drop-shadow(0px 10px 5px rgba(0, 0, 0, 0.1)); 
`

  export const Title = styled.h1`
    font-family: 'Ubuntu', san-serif;
    font-size: 2em;
    text-align: center;
    background: linear-gradient(to right, #42a5f5, #26c6da);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

`

export const Description = styled.p`
  font-family: 'Ubuntu Mono', san-serif;
  font-size: 1em;
  text-align: center;
  color: linear-gradient(right, #2196f3, #00bcd4);
`