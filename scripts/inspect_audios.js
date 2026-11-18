const fs = require('fs');
const path = require('path');

function checkAudios(dir) {
    const res = [];
    function scan(d) {
        for (const item of fs.readdirSync(d, { withFileTypes: true })) {
            const p = path.join(d, item.name);
            if (item.isDirectory()) scan(p);
            else if (item.name.endsWith('.mp3')) res.push(p);
        }
    }
    scan(dir);
    return res;
}

const files = checkAudios('de');
console.log('Total mp3s in de:', files.length);

const byFolder = {};
files.forEach(f => {
    const rel = path.relative('de', f);
    const top = rel.split(path.sep).slice(0, 2).join('/');
    byFolder[top] = (byFolder[top] || 0) + 1;
});
console.log('MP3 distribution in de:');
console.log(JSON.stringify(byFolder, null, 2));
