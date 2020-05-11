const fs = require('fs')
const path = require('path')

const folderPath = path.resolve('./public/static') 


const readFolderNames = () => fs.readdirSync(folderPath)


const readFilesInFolder = (folder) => { 
  const fileToJson = (fileName) => 
    JSON.parse(
      fs.readFileSync(
        path.resolve(`${folderPath}/${folder}/${fileName}`)
      ).toString()
    )

  return fs
    .readdirSync( path.resolve(`./public/static/${folder}`))
    .map(fileToJson)
}


const zip = (arr1, arr2) => {
  return arr1.map((x, i) => [ x, arr2[i] ] )
}


const main = () => {
  const folders = readFolderNames()
  const contents = folders.map(readFilesInFolder)

  const json = JSON.stringify(
    Object.fromEntries(
      zip(folders, contents)
    )
  )

  fs.writeFileSync( path.resolve('./public/cms.json'), json )
}


main()
