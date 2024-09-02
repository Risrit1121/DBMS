const fs = require('fs');
const readline = require('readline');

const inputfile = readline.createInterface({
  input: fs.createReadStream('source.txt')
});

const authorscsv = fs.createWriteStream('authors.csv', { flags: 'a' });
const paperauthcsv = fs.createWriteStream('paperauth.csv', { flags: 'a' });
const respapercsv = fs.createWriteStream('respaper.csv', { flags: 'a' });
const citationscsv = fs.createWriteStream('citations.csv', { flags: 'a' });

let str = '';
class paper {
  title = '';
  authors = null;
  year = '';
  venue = '';
  index = null;
  citations = null;
  abstract = '';
}


const paperProcess = (str) => {
  let resPaper = new paper();
  // let resPaper = {};

  str = str.replace(/\'/g, '\'\'');
  str = str.replace(/\"/g, '\"\"');

  let data = str.split('\n');
  const citations = [];
  data.forEach(element => {

    switch (element.substr(0, 2)) {
      case "#*":
        resPaper.title = element.substr(2);
        break;
      case "#@":
        // element = element.replace(/,,/g, ',');
        // if (element !== '#@')
        resPaper.authors = element.substr(2).split(',');
        break;
      case "#t":
        resPaper.year = Number(element.substr(2));
        break;
      case "#c":
        let temp = element.substr(2);
        if (temp != '')
          resPaper.venue = temp;
        break;
      case "#i":
        resPaper.index = Number(element.substr(6));
        break;
      case "#!":
        resPaper.abstract = element.substr(2);
        break;
      case "#%":
        citations.push(Number(element.substr(2)));
        break;
    }
  });
  // let temnn = ''
  // citations.forEach(ele => {
  //   temnn += ele + " "
  // })
  // console.log(temnn);
  if (citations.length != 0)
    resPaper.citations = citations;
  // if (resPaper.authors[0] === '')
  //   resPaper.authors = null;
  return resPaper;

};
let resPaper = null;


let csvData;
const map1 = new Map();
const authPapObj = [];
let authIndex = 1;
const delim = '\u0005'
const writeToJson = (str) => {
  if (str === '')
    return;
  resPaper = paperProcess(str);

  csvData = resPaper.index + delim + resPaper.title + delim + resPaper.year + delim + resPaper.venue + delim + resPaper.abstract + '\n';
  respapercsv.write(csvData);

  if (resPaper.citations != null) {
    csvData = resPaper.index + delim + resPaper.citations[0];

    resPaper.citations.forEach(element => {
      if (element !== resPaper.index) {
        csvData = resPaper.index + delim + element + '\n';
        citationscsv.write(csvData);
      }
    })
  }

  if (resPaper.authors !== null) { //resPaper.authors[0] !== '' || 
    resPaper.authors.forEach(element => {
      if (element !== '' && map1.get(element) == undefined)
        map1.set(element, authIndex++);
    })
    resPaper.authors=[...new Set(resPaper.authors)];

    resPaper.authors.forEach((element, index) => {
      let authid = map1.get(element);
      authPapObj.push({ RPid: resPaper.index, authid: (authid == undefined) ? 0 : authid, num: index + 1 })
    })
  }

}

inputfile.on('line', line => {
  str = str.concat(`${line}\n`);

  if (line === '') {
    writeToJson(str);
    str = ``;
  }

});

inputfile.on('close', () => {
  // console.log('file is closed bro');
  writeToJson(str);

  for (const [key, value] of map1) {
    let temp = key.trim();
    temp = temp.split(' ');
    let firstname = temp[0];
    let lastname = (temp.length == 1) ? '' : key.substr(temp[0].length + 1);

    csvData = value + delim + firstname + delim + lastname + '\n';
    authorscsv.write(csvData);
  }

  authPapObj.forEach((ele, index) => {
    csvData = ele.RPid + delim + ele.authid + delim + ele.num + '\n';
    paperauthcsv.write(csvData);
  })
})

map1.set('Anonymous', 0);