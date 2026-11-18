const fs = require('fs');
const path = require('path');

const base = 'F:\\ewha\\tiếng hàn\\Chức năng đề thi';
function list(dir, depth=0) {
    if (depth > 3) return;
    try {
        const entries = fs.readdirSync(dir, { withFileTypes: true });
        for (const e of entries) {
            const full = path.join(dir, e.name);
            if (e.isDirectory()) {
                console.log('  '.repeat(depth) + '[DIR] ' + e.name);
                list(full, depth + 1);
            } else {
                console.log('  '.repeat(depth) + ' - ' + e.name + ' (' + (fs.statSync(full).size / 1024 / 1024).toFixed(2) + ' MB)');
            }
        }
    } catch(err) {
        console.error('Error reading', dir, err.message);
    }
}
list(base);
