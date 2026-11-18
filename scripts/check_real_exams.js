const fs = require('fs');
const path = require('path');
const base = 'F:\\ewha\\tiếng hàn\\Chức năng đề thi\\Đề thi thật';
['Kỳ thi số 96', 'Kỳ thi số 102', 'Kỳ thi số 64', 'Kỳ thi số 52'].forEach(folder => {
    const p = path.join(base, folder);
    if (fs.existsSync(p)) {
        console.log('=== ' + folder + ' ===');
        fs.readdirSync(p).forEach(f => {
            const full = path.join(p, f);
            const stat = fs.statSync(full);
            if (stat.isDirectory()) {
                console.log('  [DIR] ' + f + ' (files: ' + fs.readdirSync(full).length + ')');
            } else {
                console.log('  ' + f + ' (' + (stat.size / 1024).toFixed(1) + ' KB)');
            }
        });
    } else {
        console.log('NOT FOUND:', folder);
    }
});
