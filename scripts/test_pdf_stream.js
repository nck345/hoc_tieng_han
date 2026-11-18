const fs = require('fs');
const zlib = require('zlib');

const buf = fs.readFileSync('F:\\ewha\\tiếng hàn\\Chức năng đề thi\\Đề thi thật\\Kỳ thi số 96\\TOPIK 96 Level II Đọc_읽기_onthitopik.com.pdf');
console.log('PDF length:', buf.length);

// Let's find streams
let count = 0;
let textSnippets = [];
let re = /stream\r?\n([\s\S]*?)\r?\nendstream/g;
// Since binary, let's search for stream bytes
let idx = 0;
while (true) {
    let sIdx = buf.indexOf(Buffer.from('stream'), idx);
    if (sIdx === -1) break;
    let newlineLen = 1;
    if (buf[sIdx+6] === 0x0d && buf[sIdx+7] === 0x0a) newlineLen = 2;
    let dataStart = sIdx + 6 + (buf[sIdx+6] === 0x0a ? 1 : (buf[sIdx+6] === 0x0d ? (buf[sIdx+7] === 0x0a ? 2 : 1) : 0));
    let eIdx = buf.indexOf(Buffer.from('endstream'), dataStart);
    if (eIdx === -1) break;
    let streamData = buf.subarray(dataStart, eIdx);
    idx = eIdx + 9;
    count++;
    try {
        let decompressed = zlib.inflateSync(streamData);
        let str = decompressed.toString('utf-8');
        if (str.includes('고르십시오') || str.includes('TOPIK') || str.includes('맞은')) {
            textSnippets.push(str.slice(0, 300));
        }
    } catch(e) {}
}
console.log('Total streams:', count, 'Matching snippets found:', textSnippets.length);
if (textSnippets.length > 0) {
    console.log('Snippet 0:', textSnippets[0]);
}
