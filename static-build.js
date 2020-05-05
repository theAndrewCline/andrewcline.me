const fs = require('fs')
const path = require('path')

// returns an array of file names in posts
// _ -> [ filenames ]
const readFileNames = () => fs.readdirSync( path.resolve('./static/posts') )

// Filename -> FileContent
const readFile = (name) => fs
  .readFileSync( path.resolve(`./static/posts/${name}`))
  .toString()

// [ filenames ] -> JSON with filenames
const readFiles = (fileNames) => {
  return fileNames.map(readFile)
}

// [ filecontents ] -> JSON { posts: [ filecontents ] }
const makeJSON = (posts) => JSON.stringify({ posts })

const main = () => {
  const json = makeJSON(readFiles(readFileNames()))

  fs.writeFileSync( path.resolve('./public/cms.json'), json )

  console.log('wrote cms.json')
}

main()

