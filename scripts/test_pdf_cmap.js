const fs = require('fs');
const zlib = require('zlib');
const buf = fs.readFileSync('F:\\ewha\\tiếng hàn\\Chức năng đề thi\\Đề thi thật\\Kỳ thi số 96\\TOPIK 96 Level II Đọc_읽기_onthitopik.com.pdf');
let idx = 0;
let cmaps = [];
while (true) {
    let sIdx = buf.indexOf(Buffer.from('stream'), idx);
    if (sIdx === -1) break;
    let dataStart = sIdx + 6;
    if (buf[dataStart] === 0x0d) dataStart++;
    if (buf[dataStart] === 0x0a) dataStart++;
    let eIdx = buf.indexOf(Buffer.from('endstream'), dataStart);
    if (eIdx === -1) break;
    let streamData = buf.subarray(dataStart, eIdx);
    idx = eIdx + 9;
    try {
        let decomp = zlib.inflateSync(streamData);
        let s = decomp.toString('latin1');
        if (s.includes('beginbfrange') || s.includes('beginbfchar')) {
            cmaps.push(s);
        }
    } catch(e) {}
}
console.log('CMaps found:', cmaps.length);
if (cmaps.length > 0) {
    console.log('Sample CMap:', cmaps[0].slice(0, 500));
}
